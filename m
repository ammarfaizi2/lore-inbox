Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUJaLGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUJaLGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUJaLFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:05:25 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:44097
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261546AbUJaKEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:04:41 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3dtX009642@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 505] M68k: Update defconfig for 2.6.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfig for 2.6.9

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9/arch/m68k/defconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-m68k-2.6.9/arch/defconfig	2004-09-20 11:03:03.000000000 +0200
@@ -1,28 +1,62 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.9-m68k
+# Thu Oct 28 21:23:03 2004
 #
+CONFIG_M68K=y
+CONFIG_MMU=y
 CONFIG_UID16=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
 
 #
 # Platform dependent setup
 #
-# CONFIG_ISA is not set
-# CONFIG_PCMCIA is not set
+# CONFIG_SUN3 is not set
 CONFIG_AMIGA=y
 # CONFIG_ATARI is not set
-# CONFIG_HADES is not set
-# CONFIG_PCI is not set
 # CONFIG_MAC is not set
 # CONFIG_APOLLO is not set
 # CONFIG_VME is not set
 # CONFIG_HP300 is not set
 # CONFIG_SUN3X is not set
-# CONFIG_SUN3 is not set
 # CONFIG_Q40 is not set
 
 #
@@ -32,84 +66,165 @@ CONFIG_M68020=y
 CONFIG_M68030=y
 CONFIG_M68040=y
 # CONFIG_M68060 is not set
+CONFIG_MMU_MOTOROLA=y
 # CONFIG_M68KFPU_EMU is not set
 # CONFIG_ADVANCED is not set
 
 #
 # General setup
 #
-CONFIG_NET=y
-CONFIG_SYSVIPC=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-CONFIG_KCORE_ELF=y
-# CONFIG_KCORE_AOUT is not set
-CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_AOUT=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ZORRO=y
 # CONFIG_AMIGA_PCMCIA is not set
 # CONFIG_HEARTBEAT is not set
 CONFIG_PROC_HARDWARE=y
+# CONFIG_ZORRO_NAMES is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
 # CONFIG_PARPORT is not set
-# CONFIG_PRINTER is not set
 
 #
-# Loadable module support
+# Plug and Play support
 #
-# CONFIG_MODULES is not set
 
 #
 # Block devices
 #
-# CONFIG_BLK_DEV_FD is not set
 CONFIG_AMIGA_FLOPPY=y
 # CONFIG_AMIGA_Z2RAM is not set
-# CONFIG_BLK_DEV_XD is not set
-# CONFIG_PARIDE is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_MD is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 
 #
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+# CONFIG_CHR_DEV_SG is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_DEBUG is not set
+CONFIG_A3000_SCSI=y
+CONFIG_A2091_SCSI=y
+CONFIG_GVP11_SCSI=y
+# CONFIG_CYBERSTORM_SCSI is not set
+# CONFIG_CYBERSTORMII_SCSI is not set
+# CONFIG_BLZ2060_SCSI is not set
+# CONFIG_BLZ1230_SCSI is not set
+# CONFIG_FASTLANE_SCSI is not set
+# CONFIG_OKTAGON_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
 # Networking options
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK is not set
-# CONFIG_NETFILTER is not set
-# CONFIG_FILTER is not set
+# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
+# CONFIG_ARPD is not set
 # CONFIG_SYN_COOKIES is not set
-
-#
-# (it is safe to leave these untouched)
-#
-# CONFIG_SKB_LARGE is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
 # CONFIG_IPV6 is not set
-# CONFIG_KHTTPD is not set
-# CONFIG_ATM is not set
+# CONFIG_NETFILTER is not set
 
 #
+# SCTP Configuration (EXPERIMENTAL)
 #
-#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-# CONFIG_DECNET is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
@@ -118,150 +233,310 @@ CONFIG_INET=y
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
-# ATA/IDE/MFM/RLL support
+# Network testing
 #
-# CONFIG_IDE is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
 
 #
-# SCSI support
+# Ethernet (10 or 100Mbit)
 #
-CONFIG_SCSI=y
+# CONFIG_NET_ETHERNET is not set
 
 #
-# SCSI support type (disk, tape, CD-ROM)
+# Ethernet (1000 Mbit)
 #
-CONFIG_BLK_DEV_SD=y
-CONFIG_SD_EXTRA_DEVS=40
-CONFIG_CHR_DEV_ST=y
-CONFIG_ST_EXTRA_DEVS=2
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-CONFIG_SR_EXTRA_DEVS=2
-# CONFIG_CHR_DEV_SG is not set
 
 #
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+# Ethernet (10000 Mbit)
 #
-# CONFIG_SCSI_MULTI_LUN is not set
-CONFIG_SCSI_CONSTANTS=y
-# CONFIG_SCSI_LOGGING is not set
 
 #
-# SCSI low-level drivers
+# Token Ring devices
 #
-CONFIG_A3000_SCSI=y
-# CONFIG_A4000T_SCSI is not set
-CONFIG_A2091_SCSI=y
-CONFIG_GVP11_SCSI=y
-# CONFIG_CYBERSTORM_SCSI is not set
-# CONFIG_CYBERSTORMII_SCSI is not set
-# CONFIG_BLZ2060_SCSI is not set
-# CONFIG_BLZ1230_SCSI is not set
-# CONFIG_FASTLANE_SCSI is not set
-# CONFIG_A4091_SCSI is not set
-# CONFIG_WARPENGINE_SCSI is not set
-# CONFIG_BLZ603EPLUS_SCSI is not set
-# CONFIG_OKTAGON_SCSI is not set
 
 #
-# Network device support
+# Wireless LAN (non-hamradio)
 #
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_SLIP is not set
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
 # CONFIG_PPP is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_ARIADNE is not set
-# CONFIG_ZORRO8390 is not set
-# CONFIG_A2065 is not set
-# CONFIG_HYDRA is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_AMIGA is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_AMIGA is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Character devices
 #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
-CONFIG_BUSMOUSE=y
-CONFIG_AMIGA_BUILTIN_SERIAL=y
-# CONFIG_GVPIOEXT is not set
-# CONFIG_GVPIOEXT_LP is not set
-# CONFIG_GVPIOEXT_PLIP is not set
-# CONFIG_MULTIFACE_III_TTY is not set
-# CONFIG_SUN3X_ZS is not set
-# CONFIG_SUN_KEYBOARD is not set
-# CONFIG_SUN_MOUSE is not set
-# CONFIG_SBUS is not set
-# CONFIG_SERIAL_CONSOLE is not set
-# CONFIG_USERIAL is not set
-# CONFIG_WATCHDOG is not set
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_A2232 is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 
 #
-# Sound support
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FB=y
+CONFIG_FB_MODE_HELPERS=y
+# CONFIG_FB_CIRRUS is not set
+CONFIG_FB_AMIGA=y
+CONFIG_FB_AMIGA_OCS=y
+CONFIG_FB_AMIGA_ECS=y
+CONFIG_FB_AMIGA_AGA=y
+# CONFIG_FB_FM2 is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+
+#
+# Sound
 #
 # CONFIG_SOUND is not set
 
 #
+# USB support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# Character devices
+#
+CONFIG_AMIGA_BUILTIN_SERIAL=y
+# CONFIG_MULTIFACE_III_TTY is not set
+# CONFIG_GVPIOEXT is not set
+# CONFIG_SERIAL_CONSOLE is not set
+
+#
 # File systems
 #
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+CONFIG_MINIX_FS=y
+# CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+# CONFIG_VFAT_FS is not set
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
-CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
-# CONFIG_UMSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
-# CONFIG_ISO9660_FS is not set
-# CONFIG_JOLIET is not set
-CONFIG_MINIX_FS=y
-# CONFIG_NTFS_FS is not set
-# CONFIG_NTFS_DEBUG is not set
-# CONFIG_NTFS_RW is not set
+# CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
-CONFIG_PROC_FS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
-# CONFIG_UDF_FS is not set
 # CONFIG_UFS_FS is not set
 
 #
 # Network File Systems
 #
-# CONFIG_CODA_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ROOT_NFS is not set
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
-CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_AMIGA_PARTITION=y
-CONFIG_NLS=y
 
 #
 # Native Language Support
 #
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
@@ -277,7 +552,15 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_865 is not set
 # CONFIG_NLS_CODEPAGE_866 is not set
 # CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -285,44 +568,32 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_ISO8859_5 is not set
 # CONFIG_NLS_ISO8859_6 is not set
 # CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
 # CONFIG_NLS_ISO8859_15 is not set
 # CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 
 #
-# Console drivers
+# Kernel hacking
 #
-CONFIG_FB=y
+# CONFIG_DEBUG_KERNEL is not set
 
 #
-# Frame-buffer support
+# Security options
 #
-CONFIG_FB=y
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FB_CLGEN is not set
-# CONFIG_FB_PM2 is not set
-CONFIG_FB_AMIGA=y
-CONFIG_FB_AMIGA_OCS=y
-CONFIG_FB_AMIGA_ECS=y
-CONFIG_FB_AMIGA_AGA=y
-# CONFIG_FB_CYBER is not set
-# CONFIG_FB_VIRGE is not set
-# CONFIG_FB_RETINAZ3 is not set
-# CONFIG_FB_FM2 is not set
-# CONFIG_FB_VIRTUAL is not set
-# CONFIG_FBCON_ADVANCED is not set
-CONFIG_FBCON_MFB=y
-CONFIG_FBCON_AFB=y
-CONFIG_FBCON_ILBM=y
-# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
-# CONFIG_FBCON_FONTS is not set
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_FONT_PEARL_8x8=y
+# CONFIG_SECURITY is not set
 
 #
-# Kernel hacking
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
 #
-# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
