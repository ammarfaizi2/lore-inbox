Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTB0Nxs>; Thu, 27 Feb 2003 08:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTB0Nxs>; Thu, 27 Feb 2003 08:53:48 -0500
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:3543 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S264984AbTB0Nxa>; Thu, 27 Feb 2003 08:53:30 -0500
Date: Thu, 27 Feb 2003 14:03:37 +0000
From: Chris Sykes <chris@spackhandychoptubes.co.uk>
To: linux-kernel@vger.kernel.org
Subject: OOPS: linux-2.4.20-rc1
Message-ID: <20030227140337.GD2592@spackhandychoptubes.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
User-Agent: Mutt/1.4i
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KuLpqunXa7jZSBt+
Content-Type: multipart/mixed; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I got noticed a few Oops's in the logs of my firewall/gateway box.
It's been running fine for months without any other oops and still
seems to be chugging away quite happily.

The box is am AMD K6233 with 192MB, realtek 8139 network card
connected to my LAN and a 3c509 connected to my ADSL router.
Running linux 2.4.20-rc1 on an up-to-date Debian stable.

My .config and decoded Oops are attached.  ksymoops through up some
warnings, not sure why as the kernel / System.map and running modules
should definately match.

Let me know if you need any more info.

--=20

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
/\       "Don't worry. Everything is getting nicely out of control ..."
v/_                          Douglas Adams - The Salmon of Doubt


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=3Dy
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_ALIGNMENT_16=3Dy
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_ISA=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_EISA=3Dy
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=3Dy
# CONFIG_ACPI is not set
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=3Dy
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_TOS=3Dy
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dy
CONFIG_IP_NF_IRC=3Dm
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
CONFIG_IP_NF_TARGET_REDIRECT=3Dy
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dy
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dy
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
# =20
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_PIIX_TUNING=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
CONFIG_SCSI=3Dm

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=3Dm
# CONFIG_3C515 is not set
CONFIG_VORTEX=3Dm
# CONFIG_LANCE is not set
CONFIG_NET_VENDOR_SMC=3Dy
CONFIG_WD80x3=3Dm
CONFIG_ULTRA=3Dm
CONFIG_ULTRA32=3Dm
CONFIG_SMC9194=3Dm
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=3Dy
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
CONFIG_E100=3Dm
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=3Dm
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
CONFIG_EPIC100=3Dm
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=3Dm
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SERIAL_EXTENDED=3Dy
# CONFIG_SERIAL_MANY_PORTS is not set
CONFIG_SERIAL_SHARE_IRQ=3Dy
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_HVC_CONSOLE is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
CONFIG_I2C_ALGOPCF=3Dm
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=3Dm
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
CONFIG_MINIX_FS=3Dm
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=3Dm
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI_ALT=3Dy
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
CONFIG_USB_BLUETOOTH=3Dm
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
#     Input core support is needed for USB HID input layer or HIDBP support
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=3Dm
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm

--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.decoded"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.5 on i586 2.4.20-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc1/ (default)
     -m /boot/System.map-2.4.20-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol sk_chk_filter_R__ver_sk_chk_filte=
r not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol sk_run_filter_R__ver_sk_run_filte=
r not found in System.map.  Ignoring ksyms_base entry
8139too Fast Ethernet driver 0.9.26
Unable to handle kernel paging request at virtual address 08000034
c01454fb
*pde =3D 06bb4067
Oops: 0000
CPU:    0
EIP:    0010:[<c01454fb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: c125a978   ebx: 08000000   ecx: 0000000f   edx: c1240000
esi: 07fffff0   edi: 00000000   ebp: 1aaf151b   esp: c18aff00
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29587, stackpage=3Dc18af000)
Stack: c1217f18 07fffff0 c125a978 c8ef3000 0000000b c8ef3000 c8ef300b 00000=
000=20
       c18aff98 c013c90e c7bbfb60 c18aff50 c8ef3000 c013ce7e c7bbfb60 c18af=
f50=20
       00000000 00000008 c2c68900 00000000 c8ef3000 0000000b 1aaf151b 00000=
008=20
Call Trace:    [<c013c90e>] [<c013ce7e>] [<c013d329>] [<c013d58a>] [<c013a1=
b7>]
  [<c01071c3>]
Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 28 39 7e 0c 75 df 8b 47 4c 85=20


>>EIP; c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D

>>eax; c125a978 <_end+f82260/c5418e8>
>>ebx; 08000000 Before first symbol
>>edx; c1240000 <_end+f678e8/c5418e8>
>>esi; 07fffff0 Before first symbol
>>ebp; 1aaf151b Before first symbol
>>esp; c18aff00 <_end+15d77e8/c5418e8>

Trace; c013c90e <cached_lookup+e/60>
Trace; c013ce7e <link_path_walk+35e/660>
Trace; c013d329 <path_lookup+29/40>
Trace; c013d58a <__user_walk+2a/40>
Trace; c013a1b7 <sys_lstat64+17/80>
Trace; c01071c3 <system_call+33/40>

Code;  c01454fb <d_lookup+5b/100>
00000000 <_EIP>:
Code;  c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D
   0:   39 6e 44                  cmp    %ebp,0x44(%esi)   <=3D=3D=3D=3D=3D
Code;  c01454fe <d_lookup+5e/100>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0145500 <d_lookup+60/100>
   5:   75 e8                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c0145502 <d_lookup+62/100>
   7:   8b 7c 24 28               mov    0x28(%esp,1),%edi
Code;  c0145506 <d_lookup+66/100>
   b:   39 7e 0c                  cmp    %edi,0xc(%esi)
Code;  c0145509 <d_lookup+69/100>
   e:   75 df                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c014550b <d_lookup+6b/100>
  10:   8b 47 4c                  mov    0x4c(%edi),%eax
Code;  c014550e <d_lookup+6e/100>
  13:   85 00                     test   %eax,(%eax)

 <1>Unable to handle kernel paging request at virtual address 2f636f98
c01454fb
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01454fb>]    Not tainted
EFLAGS: 00010213
eax: c125a978   ebx: 2f636f64   ecx: 0000000f   edx: c1240000
esi: 2f636f54   edi: 00000000   ebp: 1aaf151b   esp: c277bf00
ds: 0018   es: 0018   ss: 0018
Process integrit (pid: 29621, stackpage=3Dc277b000)
Stack: c397000a 2f636f54 c125a978 c3970014 0000000b c3970014 c397001f 00000=
000=20
       c277bf98 c013c90e c7bbfb60 c277bf50 c3970014 c013ce7e c7bbfb60 c277b=
f50=20
       00000000 00000008 c2c68900 00000000 c3970014 0000000b 1aaf151b 00000=
008=20
Call Trace:    [<c013c90e>] [<c013ce7e>] [<c013d329>] [<c013d58a>] [<c013a1=
b7>]
  [<c01071c3>]
Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 28 39 7e 0c 75 df 8b 47 4c 85=20


>>EIP; c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D

>>eax; c125a978 <_end+f82260/c5418e8>
>>ebx; 2f636f64 Before first symbol
>>edx; c1240000 <_end+f678e8/c5418e8>
>>esi; 2f636f54 Before first symbol
>>ebp; 1aaf151b Before first symbol
>>esp; c277bf00 <_end+24a37e8/c5418e8>

Trace; c013c90e <cached_lookup+e/60>
Trace; c013ce7e <link_path_walk+35e/660>
Trace; c013d329 <path_lookup+29/40>
Trace; c013d58a <__user_walk+2a/40>
Trace; c013a1b7 <sys_lstat64+17/80>
Trace; c01071c3 <system_call+33/40>

Code;  c01454fb <d_lookup+5b/100>
00000000 <_EIP>:
Code;  c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D
   0:   39 6e 44                  cmp    %ebp,0x44(%esi)   <=3D=3D=3D=3D=3D
Code;  c01454fe <d_lookup+5e/100>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0145500 <d_lookup+60/100>
   5:   75 e8                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c0145502 <d_lookup+62/100>
   7:   8b 7c 24 28               mov    0x28(%esp,1),%edi
Code;  c0145506 <d_lookup+66/100>
   b:   39 7e 0c                  cmp    %edi,0xc(%esi)
Code;  c0145509 <d_lookup+69/100>
   e:   75 df                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c014550b <d_lookup+6b/100>
  10:   8b 47 4c                  mov    0x4c(%edi),%eax
Code;  c014550e <d_lookup+6e/100>
  13:   85 00                     test   %eax,(%eax)

 <1>Unable to handle kernel paging request at virtual address 2f636f98
c01454fb
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01454fb>]    Not tainted
EFLAGS: 00010213
eax: c125a978   ebx: 2f636f64   ecx: 0000000f   edx: c1240000
esi: 2f636f54   edi: 00000000   ebp: 1aaf151b   esp: cb2c3f00
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29816, stackpage=3Dcb2c3000)
Stack: c5d08000 2f636f54 c125a978 c5d08000 0000000b c5d08000 c5d0800b 00000=
000=20
       cb2c3f98 c013c90e c7bbfb60 cb2c3f50 c5d08000 c013ce7e c7bbfb60 cb2c3=
f50=20
       00000000 00000008 c2c68900 00000000 c5d08000 0000000b 1aaf151b 00000=
008=20
Call Trace:    [<c013c90e>] [<c013ce7e>] [<c013d329>] [<c013d58a>] [<c013a1=
b7>]
  [<c01071c3>]
Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 28 39 7e 0c 75 df 8b 47 4c 85=20


>>EIP; c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D

>>eax; c125a978 <_end+f82260/c5418e8>
>>ebx; 2f636f64 Before first symbol
>>edx; c1240000 <_end+f678e8/c5418e8>
>>esi; 2f636f54 Before first symbol
>>ebp; 1aaf151b Before first symbol
>>esp; cb2c3f00 <_end+afeb7e8/c5418e8>

Trace; c013c90e <cached_lookup+e/60>
Trace; c013ce7e <link_path_walk+35e/660>
Trace; c013d329 <path_lookup+29/40>
Trace; c013d58a <__user_walk+2a/40>
Trace; c013a1b7 <sys_lstat64+17/80>
Trace; c01071c3 <system_call+33/40>

Code;  c01454fb <d_lookup+5b/100>
00000000 <_EIP>:
Code;  c01454fb <d_lookup+5b/100>   <=3D=3D=3D=3D=3D
   0:   39 6e 44                  cmp    %ebp,0x44(%esi)   <=3D=3D=3D=3D=3D
Code;  c01454fe <d_lookup+5e/100>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0145500 <d_lookup+60/100>
   5:   75 e8                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c0145502 <d_lookup+62/100>
   7:   8b 7c 24 28               mov    0x28(%esp,1),%edi
Code;  c0145506 <d_lookup+66/100>
   b:   39 7e 0c                  cmp    %edi,0xc(%esi)
Code;  c0145509 <d_lookup+69/100>
   e:   75 df                     jne    ffffffef <_EIP+0xffffffef> c01454e=
a <d_lookup+4a/100>
Code;  c014550b <d_lookup+6b/100>
  10:   8b 47 4c                  mov    0x4c(%edi),%eax
Code;  c014550e <d_lookup+6e/100>
  13:   85 00                     test   %eax,(%eax)


3 warnings issued.  Results may not be reliable.

--bjuZg6miEcdLYP6q--

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Xhq5y8ZewFQK83cRAsTgAJwJeER83k2XcFK5vdMh6ZfQDYRy7ACcDsPd
OITe9bMrmJA3TXovows8rQg=
=NY/s
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
