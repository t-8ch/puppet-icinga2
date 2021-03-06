# == Defined type: icinga2::object::host
#  
#  This is a defined type for Icinga 2 host objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-host
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::host (
  $object_hostname = $name,
  $display_name = $fqdn,
  $ipv4_address = $ipaddress_eth0,
  $ipv6_address = undef,
  $template_to_import = 'generic-host',
  $groups = [],
  $vars = {},
  $check_command = undef,
  $max_check_attempts = undef,
  $check_period = undef,
  $check_interval = undef,
  $retry_interval = undef,
  $enable_notifications = undef,
  $enable_active_checks = undef,
  $enable_passive_checks = undef,
  $enable_event_handler = undef,
  $enable_flap_detection = undef,
  $enable_perfdata = undef,
  $event_command = undef,
  #flapping_threshold is defined as a percentage, eg. 10%, 50%, etc.
  $flapping_threshold = undef,
  $volatile = undef,
  $notes = undef,
  $notes_url = undef,
  $action_url = undef,
  $icon_image = undef,
  $icon_image_alt = undef,
  $target_dir = '/etc/icinga2/conf.d',
  $target_file_name = "${fqdn}.conf",
  $target_file_owner = 'root',
  $target_file_group = 'root',
  $target_file_mode = '644'
) {

  #Do some validation of the class' parameters:
  validate_string($object_hostname)
  validate_string($template_to_import)
  validate_string($display_name)
  validate_string($ipv4_address)  
  validate_array($groups)
  validate_hash($vars)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)

  file {"${target_dir}/${target_file_name}":
    ensure => file,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_host.conf.erb'),
    notify => Service['icinga2'],
  }

}