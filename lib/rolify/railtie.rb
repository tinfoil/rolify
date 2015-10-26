require 'rolify'
require 'rails'

module Rolify
  module MongoidAdapter
    extend ActiveSupport::Concern

    included do
      extend Rolify
    end
  end

  class Railtie < Rails::Railtie
    initializer 'rolify.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :extend, Rolify
      end

      config.before_initialize do
        ::Mongoid::Document.module_eval do
          include MongoidAdapter
        end
      end if defined?(Mongoid)
    end
  end
end
