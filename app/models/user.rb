class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  has_many :authentications, dependent: :destroy
  has_many :messages
  accepts_nested_attributes_for :authentications

  def name
    email.split('@')[0]
  end

end
