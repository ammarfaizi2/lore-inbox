Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKRJNm>; Mon, 18 Nov 2002 04:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSKRJNl>; Mon, 18 Nov 2002 04:13:41 -0500
Received: from mail.set-software.de ([193.218.212.121]:61118 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S261742AbSKRJNS>; Mon, 18 Nov 2002 04:13:18 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Mon, 18 Nov 2002 10:20:03 GMT
Message-ID: <20021118.10200352@knigge.local.net>
Subject: 2.4.xx: 8139 isn't working
To: <linux-kernel@vger.kernel.org>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------=_4D4800AAE74702C065B4"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------=_4D4800AAE74702C065B4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

my new board (GA-8ST, P4, single-CPU, SiS Chipset) has a RealTek 8139=20=

on board which isn't working with Linux 2.4.xx (tried 2.4.18, 2.4.19,=20=

2.4.20rc1 and  2.4.20rc2).

I've attached lspci, dmesg and config from my  2.4.20rc2 and from a=20
2.2.20, where the NIC is working like a charm....

2.2.20:
eth0: RealTek RTL8139 Fast Ethernet at 0xe000, IRQ 11,=20
00:20:ed:3a:f5:ee.


2.4.20-rc2:
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd082f000, 00:20:ed:3a:f5:ee,=20=

IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner=20
ability 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.


I've also tried 8139cp, but the driver says that my nic isn't a 8139C+=20=

and I should try 8139too instead - with no success as you can see....


If I can help any further, let me know (please with an additional=20
personal addressed E-Mail).


Bye
  Michael



--------------=_4D4800AAE74702C065B4
Content-Description: filename="config-2.2.20"
Content-Disposition: inline; filename="config-2.2.20"
Content-Type: text/plain; name ="config-2.2.20"
Content-Transfer-Encoding: quoted-printable

CONFIG_X86=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_M386=3Dy
CONFIG_1GB=3Dy
CONFIG_MATH_EMULATION=3Dy
CONFIG_MTRR=3Dy
CONFIG_MODULES=3Dy
CONFIG_KMOD=3Dy
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_PCI_OLD_PROC=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_APM=3Dy
CONFIG_APM_DISABLE_BY_DEFAULT=3Dy
CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDEFLOPPY=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dm
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_CS5530=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_PARIDE_PARPORT=3Dm
CONFIG_PACKET=3Dm
CONFIG_NETLINK=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_FIREWALL=3Dy
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
CONFIG_NET_ETHERNET=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_EL1=3Dm
CONFIG_EL2=3Dm
CONFIG_ELPLUS=3Dm
CONFIG_EL16=3Dm
CONFIG_EL3=3Dm
CONFIG_3C515=3Dm
CONFIG_VORTEX=3Dy
CONFIG_LANCE=3Dm
CONFIG_NET_VENDOR_SMC=3Dy
CONFIG_WD80x3=3Dm
CONFIG_ULTRA=3Dm
CONFIG_ULTRA32=3Dm
CONFIG_SMC9194=3Dm
CONFIG_NET_VENDOR_RACAL=3Dy
CONFIG_NI5010=3Dm
CONFIG_NI52=3Dm
CONFIG_NI65=3Dm
CONFIG_RTL8139=3Dy
CONFIG_RTL8139TOO=3Dm
CONFIG_8139TOO_8129=3Dy
CONFIG_NET_ISA=3Dy
CONFIG_AT1700=3Dm
CONFIG_E2100=3Dm
CONFIG_DEPCA=3Dm
CONFIG_EWRK3=3Dm
CONFIG_EEXPRESS=3Dm
CONFIG_EEXPRESS_PRO=3Dm
CONFIG_FMV18X=3Dm
CONFIG_HPLAN_PLUS=3Dm
CONFIG_HPLAN=3Dm
CONFIG_HP100=3Dm
CONFIG_ETH16I=3Dm
CONFIG_NE2000=3Dm
CONFIG_NET_EISA=3Dy
CONFIG_PCNET32=3Dy
CONFIG_ADAPTEC_STARFIRE=3Dm
CONFIG_AC3200=3Dm
CONFIG_APRICOT=3Dm
CONFIG_CS89x0=3Dm
CONFIG_DM9102=3Dm
CONFIG_DE4X5=3Dm
CONFIG_DEC_ELCP=3Dy
CONFIG_DGRS=3Dm
CONFIG_EEXPRESS_PRO100=3Dy
CONFIG_LNE390=3Dm
CONFIG_NE3210=3Dm
CONFIG_NE2K_PCI=3Dy
CONFIG_TLAN=3Dm
CONFIG_VIA_RHINE=3Dy
CONFIG_SIS900=3Dm
CONFIG_ES3210=3Dm
CONFIG_EPIC100=3Dm
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_XPEED=3Dm
CONFIG_CD_NO_IDESCSI=3Dy
CONFIG_AZTCD=3Dm
CONFIG_GSCD=3Dm
CONFIG_SBPCD=3Dm
CONFIG_MCD=3Dm
CONFIG_MCD_IRQ=3D11
CONFIG_MCD_BASE=3D300
CONFIG_MCDX=3Dm
CONFIG_OPTCD=3Dm
CONFIG_CM206=3Dm
CONFIG_SJCD=3Dm
CONFIG_ISP16_CDI=3Dm
CONFIG_CDU31A=3Dm
CONFIG_CDU535=3Dm
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SERIAL_EXTENDED=3Dy
CONFIG_SERIAL_MANY_PORTS=3Dy
CONFIG_SERIAL_SHARE_IRQ=3Dy
CONFIG_SERIAL_MULTIPORT=3Dy
CONFIG_HUB6=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_MOUSE=3Dy
CONFIG_BUSMOUSE=3Dm
CONFIG_MS_BUSMOUSE=3Dm
CONFIG_PSMOUSE=3Dy
CONFIG_82C710_MOUSE=3Dm
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_MINIX_FS=3Dm
CONFIG_NTFS_FS=3Dm
CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_LOCKD=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"cp437"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_RU=3Dm
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_FB_VGA16=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FBCON_CFB8=3Dy
CONFIG_FBCON_CFB16=3Dy
CONFIG_FBCON_CFB24=3Dy
CONFIG_FBCON_CFB32=3Dy
CONFIG_FBCON_VGA_PLANES=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy


--------------=_4D4800AAE74702C065B4
Content-Description: filename="config-2.4.20-rc2"
Content-Disposition: inline; filename="config-2.4.20-rc2"
Content-Type: text/plain; name ="config-2.4.20-rc2"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

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
CONFIG_M586MMX=3Dy
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
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
CONFIG_X86_USE_STRING_486=3Dy
CONFIG_X86_ALIGNMENT_16=3Dy
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PPRO_FENCE=3Dy
# CONFIG_X86_F00F_WORKS_OK is not set
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
CONFIG_MTRR=3Dy
CONFIG_SMP=3Dy
# CONFIG_MULTIQUAD is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_ISA=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
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
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
# CONFIG_PM is not set
# CONFIG_APM is not set

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
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
CONFIG_PARPORT_OTHER=3Dy
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_LARGE_TABLES=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_INET_ECN=3Dy
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
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
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_CMD640_ENHANCED=3Dy
CONFIG_BLK_DEV_ISAPNP=3Dy
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_AEC62XX=3Dy
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=3Dy
CONFIG_WDC_ALI15X3=3Dy
CONFIG_BLK_DEV_AMD74XX=3Dy
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=3Dy
# CONFIG_BLK_DEV_CMD680 is not set
CONFIG_BLK_DEV_CY82C693=3Dy
CONFIG_BLK_DEV_CS5530=3Dy
CONFIG_BLK_DEV_HPT34X=3Dy
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_SVWKS=3Dy
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_SLC90E66=3Dy
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
CONFIG_IDE_CHIPSETS=3Dy
CONFIG_BLK_DEV_4DRIVES=3Dy
CONFIG_BLK_DEV_ALI14XX=3Dy
CONFIG_BLK_DEV_DTC2278=3Dy
CONFIG_BLK_DEV_HT6560B=3Dy
CONFIG_BLK_DEV_QD65XX=3Dy
CONFIG_BLK_DEV_UMC8672=3Dy
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=3Dm
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
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

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_LAN=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_LANCE=3Dm
# CONFIG_NET_VENDOR_SMC is not set
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
# CONFIG_TULIP_MMIO is not set
CONFIG_DE4X5=3Dm
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
CONFIG_E100=3Dm
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=3Dm
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
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
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
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
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# Mice
#
CONFIG_BUSMOUSE=3Dm
CONFIG_ATIXL_BUSMOUSE=3Dm
CONFIG_LOGIBUSMOUSE=3Dm
CONFIG_MS_BUSMOUSE=3Dm
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
CONFIG_INTEL_RNG=3Dm
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
CONFIG_AGP_INTEL=3Dy
CONFIG_AGP_I810=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_AGP_AMD=3Dy
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_ALI=3Dy
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=3Dy
CONFIG_DRM_TDFX=3Dy
CONFIG_DRM_R128=3Dm
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
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
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
CONFIG_JBD_DEBUG=3Dy
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_UMSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=3Dm
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=3Dm
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=3Dm
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=3Dm

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
CONFIG_SOUND=3Dm
# CONFIG_SOUND_ALI5455 is not set
CONFIG_SOUND_BT878=3Dm
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=3Dm
# CONFIG_MIDI_EMU10K1 is not set
CONFIG_SOUND_FUSION=3Dm
CONFIG_SOUND_CS4281=3Dm
CONFIG_SOUND_ES1370=3Dm
CONFIG_SOUND_ES1371=3Dm
CONFIG_SOUND_ESSSOLO1=3Dm
CONFIG_SOUND_MAESTRO=3Dm
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=3Dm
# CONFIG_SOUND_RME96XX is not set
CONFIG_SOUND_SONICVIBES=3Dm
CONFIG_SOUND_TRIDENT=3Dm
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=3Dm
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

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


--------------=_4D4800AAE74702C065B4
Content-Description: filename="dmesg-2.2.20"
Content-Disposition: inline; filename="dmesg-2.2.20"
Content-Type: text/plain; name ="dmesg-2.2.20"
Content-Transfer-Encoding: quoted-printable

Linux version 2.2.20-idepci (herbert@gondolin) (gcc version 2.7.2.3) #1 =
Sat Apr 20 12:45:19 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 0fef0000 @ 00100000 (usable)
Detected 1716933 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3420.97 BogoMIPS
Memory: 257592k/262080k available (1164k kernel code, 412k reserved, 284=
0k data, 72k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
8K L1 data cache
12K L1 instruction cache
8192K L1 instruction cache
CPU: L1 I Cache: 8204K  L1 D Cache: 8K
CPU:               Intel(R) Pentium(R) 4 CPU 1.70GHz
CPU: Intel               Intel(R) Pentium(R) 4 CPU 1.70GHz stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.=

Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfaaa0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5=20
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ ena=
bled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 4K080H4, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CDROM drive
hdd: LITE-ON LTR-12101B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: MAXTOR 4K080H4, 76319MB w/2000kB Cache, CHS=3D9729/255/63
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.11
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vo=
rtex.html
pcnet32.c: PCI bios is present, checking for devices...
rtl8139.c:v1.07 5/6/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/d=
rivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xe000, IRQ 11, 00:20:ed:3a:f5:ee=
.
via-rhine.c:v1.08b-LK1.0.1 12/14/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
Partition check:
 hda: hda1 hda2 hda3
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
apm: disabled on user request.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 72k freed
Adding Swap: 248996k swap-space (priority -1)
eth1: 8139too Fast Ethernet driver 0.9.18-pre4 Jeff Garzik <jgarzik@mand=
rakesoft.com>
eth1: Linux-2.2 bug reports to Jens David <dg1kjd@afthd.tu-darmstadt.de>=

eth1: RealTek RTL8139 Fast Ethernet board found at 0xd0028000, IRQ 11
eth1: Chip is 'RTL-8139C' - MAC address '00:20:ed:3a:f5:ee'.


--------------=_4D4800AAE74702C065B4
Content-Description: filename="dmesg-2.4.20-rc2"
Content-Disposition: inline; filename="dmesg-2.4.20-rc2"
Content-Type: text/plain; name ="dmesg-2.4.20-rc2"
Content-Transfer-Encoding: quoted-printable

Linux version 2.4.20-rc2 (root@knigge) (gcc version 2.95.4 20011002 (Deb=
ian prerelease)) #1 SMP Mon Nov 18 09:57:35 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f5590
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f6f90
RSD PTR  v0 [GBT   ]
__va_range(0xfff3000, 0x68): idx=3D8 mapped at ffff6000
ACPI table found: RSDT v1 [GBT    AWRDACPI 16944.11825]
__va_range(0xfff3040, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xfff3040, 0x74): idx=3D8 mapped at ffff6000
ACPI table found: FACP v1 [GBT    AWRDACPI 16944.11825]
__va_range(0xfff6ac0, 0x24): idx=3D8 mapped at ffff6000
__va_range(0xfff6ac0, 0x5a): idx=3D8 mapped at ffff6000
ACPI table found: APIC v1 [GBT    AWRDACPI 16944.11825]
__va_range(0xfff6ac0, 0x5a): idx=3D8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Unknown CPU [15:1] APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])=

INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])=

LAPIC_NMI (acpi_id[0x00ff] polarity[0x0] trigger[0x0] lint[0x1])
1 CPUs total
Local APIC address fee00000
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: BOOT_IMAGE=3DLinux-2.4.20 ro root=3D302
Initializing CPU#0
Detected 1716.934 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3420.97 BogoMIPS
Memory: 256744k/262080k available (1110k kernel code, 4948k reserved, 48=
0k data, 112k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 1.70GHz stepping 02
per-CPU timeslice cutoff: 731.52 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23 =
not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178014
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0014
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1716.8996 MHz.
..... host bus clock speed is 100.9939 MHz.
cpu: 0, clocks: 1009939, slice: 504969
CPU0<T0:1009936,T1:504960,D:7,S:504969,C:1009939>
Waiting on wait_init_idle (map =3D 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfaaa0, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/0646] at 00:00.0
PCI->APIC IRQ transform: (B0,I2,P2) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIA=
L_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS5513
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 4K080H4, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=3D9729/255/63
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: unsupported bridge
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 112k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 248996k swap-space (priority -1)
Real Time Clock Driver v1.10e
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd082f000, 00:20:ed:3a:f5:ee, IR=
Q 19
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner abili=
ty 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner abili=
ty 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner abili=
ty 45e1.


--------------=_4D4800AAE74702C065B4
Content-Description: filename="lspci-2.2.20"
Content-Disposition: inline; filename="lspci-2.2.20"
Content-Type: text/plain; name ="lspci-2.2.20"
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 06=
46
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0646
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable)
	Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog=
-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04=
)
	Flags: bus master, medium devsel, latency 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog=
-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,=
B step)
	Flags: bus master, medium devsel, latency 128
	I/O ports at f000

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Si=
S7012 PCI Audio Accelerator (rev a0)
	Subsystem: Giga-byte Technology: Unknown device a002
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d800
	I/O ports at dc00
	Capabilities: [48] Power Management version 2

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (r=
ev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e000
	Memory at eb005000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro TF =
(prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7106
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 5
	Memory at e4000000 (32-bit, prefetchable)
	I/O ports at c000
	Memory at e9000000 (32-bit, non-prefetchable)
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2



--------------=_4D4800AAE74702C065B4
Content-Description: filename="lspci-2.4.20-rc2"
Content-Disposition: inline; filename="lspci-2.4.20-rc2"
Content-Type: text/plain; name ="lspci-2.4.20-rc2"
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 06=
46
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0646
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=3D64M]
	Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog=
-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04=
)
	Flags: bus master, medium devsel, latency 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog=
-if 88 [Master SecP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,=
B step)
	Flags: bus master, medium devsel, latency 128
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f000 [size=3D16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Si=
S7012 PCI Audio Accelerator (rev a0)
	Subsystem: Giga-byte Technology: Unknown device a002
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at d800 [size=3D256]
	I/O ports at dc00 [size=3D128]
	Capabilities: [48] Power Management version 2

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (r=
ev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at e000 [size=3D256]
	Memory at eb005000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Vital Product Data

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro TF =
(prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7106
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 16
	Memory at e4000000 (32-bit, prefetchable) [size=3D64M]
	I/O ports at c000 [size=3D256]
	Memory at e9000000 (32-bit, non-prefetchable) [size=3D16K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2



--------------=_4D4800AAE74702C065B4--

