#
# Copyright (C) 2010 OpenWrt.org
#

PART_NAME=firmware
REQUIRE_IMAGE_METADATA=1

platform_check_image() {
	return 0
}

platform_pre_upgrade() {
	local board=$(board_name)

	case "$board" in
	mikrotik,rb750gr3|\
	mikrotik,rbm11g|\
	mikrotik,rbm33g)
		[ -z "$(rootfs_type)" ] && mtd erase firmware
		;;
	esac
}

platform_nand_pre_upgrade() {
	local board=$(board_name)

	case "$board" in
	ubnt-erx|\
	ubnt-erx-sfp)
		platform_upgrade_ubnt_erx "$1"
		;;
	esac
}

platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
	hc5962|\
	r6220|\
	netgear,r6350|\
	ubnt-erx|\
	ubnt-erx-sfp|\
	xiaomi,mir3g|\
	xiaomi,mir3p)
		nand_do_upgrade "$1"
		;;
	tplink,c50-v4)
		MTD_ARGS="-t romfile"
		default_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
}
