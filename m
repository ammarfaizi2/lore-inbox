Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDQQPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 12:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbUDQQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 12:15:46 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:8681 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S262874AbUDQQOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 12:14:02 -0400
From: "Stephen Lee" <slee@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Cc: <steve@tuxsoft.com>
Subject: 2.6.6-rc1 caused dedicated Quake 3 server to core dump
Date: Sat, 17 Apr 2004 11:14:28 -0500
Message-ID: <008f01c42497$10ad48f0$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0090_01C4246D.27D740F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0090_01C4246D.27D740F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

For years now, I've been running a dedicated Quake 3 server on my linux
box.  Last night, was the first time I've ever seen a core dump with
Quake.  2.6.5 was and is now running fine, but under 2.6.6-rc1 it core
dumped within about 30 minutes with the attached dmesg output.  I am
also including my config's for 2.6.5 and 2.6.6-rc1.  The only things I'm
aware of as being different is CONFIG_POSIX_MQUEUE=y and the relabeling
of usbhid (2.6.6-rc1) from just hid (2.6.5).  If any additional
information is needed, please let me know.  Also, please CC as I'm no
longer on this mailing list.

Thanks,
Steve

------=_NextPart_000_0090_01C4246D.27D740F0
Content-Type: application/octet-stream;
	name="config-2.6.6-rc1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config-2.6.6-rc1"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_STANDALONE=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D15=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_IKCONFIG is not set=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_STOP_MACHINE=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_ELAN is not set=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUMM is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
CONFIG_MK7=3Dy=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D6=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_X86_USE_3DNOW=3Dy=0A=
CONFIG_HPET_TIMER=3Dy=0A=
# CONFIG_HPET_EMULATE_RTC is not set=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D2=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
CONFIG_X86_MCE_NONFATAL=3Dy=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_MICROCODE is not set=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
# CONFIG_EDD is not set=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
# CONFIG_HIGHPTE is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_IRQBALANCE=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
# CONFIG_REGPARM is not set=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_SOFTWARE_SUSPEND is not set=0A=
# CONFIG_PM_DISK is not set=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
# CONFIG_ACPI_SLEEP is not set=0A=
# CONFIG_ACPI_AC is not set=0A=
# CONFIG_ACPI_BATTERY is not set=0A=
# CONFIG_ACPI_BUTTON is not set=0A=
# CONFIG_ACPI_FAN is not set=0A=
CONFIG_ACPI_PROCESSOR=3Dm=0A=
CONFIG_ACPI_THERMAL=3Dm=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
# CONFIG_X86_PM_TIMER is not set=0A=
=0A=
#=0A=
# APM (Advanced Power Management) BIOS Support=0A=
#=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GOMMCONFIG is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
# CONFIG_PCI_USE_VECTOR is not set=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_CARMEL is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_LBD is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
# CONFIG_IDEDISK_MULTI_MODE is not set=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dm=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
# CONFIG_IDE_TASKFILE_IO is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
# CONFIG_IDE_GENERIC is not set=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_GENERIC is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
CONFIG_BLK_DEV_AMD74XX=3Dy=0A=
# CONFIG_BLK_DEV_ATIIXP is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy=0A=
CONFIG_PDC202XX_FORCE=3Dy=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dm=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dm=0A=
CONFIG_NET_KEY=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
CONFIG_INET_AH=3Dy=0A=
CONFIG_INET_ESP=3Dy=0A=
CONFIG_INET_IPCOMP=3Dy=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_FTP=3Dm=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_TFTP=3Dm=0A=
CONFIG_IP_NF_AMANDA=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dm=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
CONFIG_IP_NF_MATCH_MAC=3Dm=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_MARK=3Dm=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dm=0A=
CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dm=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dm=0A=
CONFIG_IP_NF_MATCH_STATE=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
CONFIG_IP_NF_FILTER=3Dm=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
CONFIG_IP_NF_NAT=3Dm=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dm=0A=
CONFIG_IP_NF_TARGET_SAME=3Dm=0A=
CONFIG_IP_NF_NAT_LOCAL=3Dy=0A=
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dm=0A=
CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
CONFIG_IP_NF_MANGLE=3Dm=0A=
CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
CONFIG_IP_NF_TARGET_MARK=3Dm=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm=0A=
CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dm=0A=
CONFIG_IP_NF_ARPFILTER=3Dm=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
CONFIG_XFRM=3Dy=0A=
CONFIG_XFRM_USER=3Dy=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
CONFIG_VORTEX=3Dm=0A=
# CONFIG_TYPHOON is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_HP100 is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_FORCEDETH is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
CONFIG_E100=3Dm=0A=
CONFIG_E100_NAPI=3Dy=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dm=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
CONFIG_INPUT_PCSPKR=3Dm=0A=
CONFIG_INPUT_UINPUT=3Dm=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
# CONFIG_SERIAL_8250_CONSOLE is not set=0A=
# CONFIG_SERIAL_8250_ACPI is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_HW_RANDOM=3Dm=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dm=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
# CONFIG_HANGCHECK_TIMER is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dm=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dm=0A=
CONFIG_SND_TIMER=3Dm=0A=
CONFIG_SND_PCM=3Dm=0A=
CONFIG_SND_HWDEP=3Dm=0A=
CONFIG_SND_RAWMIDI=3Dm=0A=
CONFIG_SND_SEQUENCER=3Dm=0A=
CONFIG_SND_SEQ_DUMMY=3Dm=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dm=0A=
CONFIG_SND_PCM_OSS=3Dm=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
CONFIG_SND_RTCTIMER=3Dm=0A=
# CONFIG_SND_VERBOSE_PRINTK is not set=0A=
# CONFIG_SND_DEBUG is not set=0A=
=0A=
#=0A=
# Generic devices=0A=
#=0A=
# CONFIG_SND_DUMMY is not set=0A=
# CONFIG_SND_VIRMIDI is not set=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
# CONFIG_SND_MPU401 is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
CONFIG_SND_AC97_CODEC=3Dm=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_AU8810 is not set=0A=
# CONFIG_SND_AU8820 is not set=0A=
# CONFIG_SND_AU8830 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_BT87X is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
CONFIG_SND_EMU10K1=3Dm=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_MIXART is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
# CONFIG_SND_ALS4000 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
# CONFIG_SND_ENS1371 is not set=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
# CONFIG_SND_INTEL8X0 is not set=0A=
# CONFIG_SND_INTEL8X0M is not set=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
=0A=
#=0A=
# ALSA USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
CONFIG_USB_OHCI_HCD=3Dm=0A=
# CONFIG_USB_UHCI_HCD is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
CONFIG_USB_PRINTER=3Dm=0A=
# CONFIG_USB_STORAGE is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
CONFIG_USB_HID=3Dm=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
CONFIG_USB_HIDDEV=3Dy=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
CONFIG_USB_KBD=3Dm=0A=
CONFIG_USB_MOUSE=3Dm=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_EXT2_FS is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
CONFIG_REISERFS_FS=3Dy=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_REISERFS_PROC_INFO is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_NFS_FS is not set=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_EXPORTFS is not set=0A=
CONFIG_SMB_FS=3Dm=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"cp437"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dm=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set=0A=
# CONFIG_FRAME_POINTER is not set=0A=
# CONFIG_4KSTACKS is not set=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dm=0A=
CONFIG_CRYPTO_MD4=3Dm=0A=
CONFIG_CRYPTO_MD5=3Dy=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dm=0A=
CONFIG_CRYPTO_SHA512=3Dm=0A=
CONFIG_CRYPTO_DES=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH=3Dm=0A=
CONFIG_CRYPTO_TWOFISH=3Dm=0A=
CONFIG_CRYPTO_SERPENT=3Dm=0A=
CONFIG_CRYPTO_AES=3Dm=0A=
CONFIG_CRYPTO_CAST5=3Dm=0A=
CONFIG_CRYPTO_CAST6=3Dm=0A=
CONFIG_CRYPTO_ARC4=3Dm=0A=
CONFIG_CRYPTO_DEFLATE=3Dy=0A=
# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A=
CONFIG_CRYPTO_TEST=3Dm=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dm=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_X86_SMP=3Dy=0A=
CONFIG_X86_HT=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_X86_TRAMPOLINE=3Dy=0A=
CONFIG_PC=3Dy=0A=

------=_NextPart_000_0090_01C4246D.27D740F0
Content-Type: application/octet-stream;
	name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Unable to handle kernel paging request at virtual address ffffff83=0A=
 printing eip:=0A=
c01c9cbe=0A=
*pde =3D 00003067=0A=
*pte =3D 00000000=0A=
Oops: 0002 [#1]=0A=
PREEMPT SMP=0A=
CPU:    0=0A=
EIP:    0060:[<c01c9cbe>]    Tainted: P=0A=
EFLAGS: 00210286   (2.6.6-rc1)=0A=
EIP is at copy_to_user+0xe/0x50=0A=
eax: da32c000   ebx: da32dec4   ecx: f64638c0   edx: 00000000=0A=
esi: 00000025   edi: 00000025   ebp: cecfcc3c   esp: da32dd24=0A=
ds: 007b   es: 007b   ss: 0068=0A=
Process quake3.x86 (pid: 4068, threadinfo=3Dda32c000 task=3Dcfc58840)=0A=
Stack: 088c8e60 e78fc83c 00000020 da32dec4 00000020 c023d017 088c8e60 =
cecfcc3c=0A=
       00000025 f64638c0 00000025 00000025 00000025 c023d6e0 da32dec4 =
cecfcc3c=0A=
       00000025 f7fef5c0 f03f6900 00000000 0000002d f64638c0 00000025 =
00000000=0A=
Call Trace:=0A=
 [<c023d017>] memcpy_toiovec+0x37/0x60=0A=
 [<c023d6e0>] skb_copy_datagram_iovec+0x50/0x200=0A=
 [<c0277a08>] udp_recvmsg+0x1b8/0x2c0=0A=
 [<c027ff4a>] inet_recvmsg+0x5a/0x80=0A=
 [<c0237b1c>] sock_recvmsg+0x9c/0xc0=0A=
 [<c0106825>] do_IRQ+0xe5/0x190=0A=
 [<c0104a2a>] reschedule_interrupt+0x1a/0x20=0A=
 [<c029c01c>] schedule+0x39c/0x6b0=0A=
 [<c0139ee5>] __alloc_pages+0x95/0x2f0=0A=
 [<c0104a2a>] reschedule_interrupt+0x1a/0x20=0A=
 [<c02377dc>] sockfd_lookup+0x1c/0x80=0A=
 [<c0239064>] sys_recvfrom+0xb4/0x120=0A=
 [<c0116bd0>] default_wake_function+0x0/0x20=0A=
 [<c0116bd0>] default_wake_function+0x0/0x20=0A=
 [<c01f6b70>] read_chan+0x0/0x880=0A=
 [<c01f17ba>] tty_read+0x14a/0x180=0A=
 [<c023988a>] sys_socketcall+0x1ba/0x260=0A=
 [<c010409b>] syscall_call+0x7/0xb=0A=
=0A=
Code: 89 74 24 10 8b 4c 24 20 8b 5c 24 18 89 da 01 ca 19 f6 39 50=0A=

------=_NextPart_000_0090_01C4246D.27D740F0
Content-Type: application/octet-stream;
	name="config-2.6.5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config-2.6.5"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_STANDALONE=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D15=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_IKCONFIG is not set=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_STOP_MACHINE=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_ELAN is not set=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUMM is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
CONFIG_MK7=3Dy=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D6=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_X86_USE_3DNOW=3Dy=0A=
CONFIG_HPET_TIMER=3Dy=0A=
# CONFIG_HPET_EMULATE_RTC is not set=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D2=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
CONFIG_X86_MCE_NONFATAL=3Dy=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_MICROCODE is not set=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
# CONFIG_EDD is not set=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
# CONFIG_HIGHPTE is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_IRQBALANCE=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
# CONFIG_REGPARM is not set=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_SOFTWARE_SUSPEND is not set=0A=
# CONFIG_PM_DISK is not set=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
# CONFIG_ACPI_SLEEP is not set=0A=
# CONFIG_ACPI_AC is not set=0A=
# CONFIG_ACPI_BATTERY is not set=0A=
# CONFIG_ACPI_BUTTON is not set=0A=
# CONFIG_ACPI_FAN is not set=0A=
CONFIG_ACPI_PROCESSOR=3Dm=0A=
CONFIG_ACPI_THERMAL=3Dm=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
# CONFIG_X86_PM_TIMER is not set=0A=
=0A=
#=0A=
# APM (Advanced Power Management) BIOS Support=0A=
#=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GOMMCONFIG is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
# CONFIG_PCI_USE_VECTOR is not set=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_CARMEL is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_LBD is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
# CONFIG_IDEDISK_MULTI_MODE is not set=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dm=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
# CONFIG_IDE_TASKFILE_IO is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
# CONFIG_IDE_GENERIC is not set=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_GENERIC is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
CONFIG_BLK_DEV_AMD74XX=3Dy=0A=
# CONFIG_BLK_DEV_ATIIXP is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy=0A=
CONFIG_PDC202XX_FORCE=3Dy=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dm=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dm=0A=
CONFIG_NET_KEY=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
CONFIG_INET_AH=3Dy=0A=
CONFIG_INET_ESP=3Dy=0A=
CONFIG_INET_IPCOMP=3Dy=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_FTP=3Dm=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_TFTP=3Dm=0A=
CONFIG_IP_NF_AMANDA=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dm=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
CONFIG_IP_NF_MATCH_MAC=3Dm=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_MARK=3Dm=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dm=0A=
CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dm=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dm=0A=
CONFIG_IP_NF_MATCH_STATE=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
CONFIG_IP_NF_FILTER=3Dm=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
CONFIG_IP_NF_NAT=3Dm=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dm=0A=
CONFIG_IP_NF_TARGET_SAME=3Dm=0A=
CONFIG_IP_NF_NAT_LOCAL=3Dy=0A=
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dm=0A=
CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
CONFIG_IP_NF_MANGLE=3Dm=0A=
CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
CONFIG_IP_NF_TARGET_MARK=3Dm=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm=0A=
CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dm=0A=
CONFIG_IP_NF_ARPFILTER=3Dm=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
CONFIG_XFRM=3Dy=0A=
CONFIG_XFRM_USER=3Dy=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
CONFIG_VORTEX=3Dm=0A=
# CONFIG_TYPHOON is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_HP100 is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_FORCEDETH is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
CONFIG_E100=3Dm=0A=
CONFIG_E100_NAPI=3Dy=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SIS190 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dm=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
CONFIG_INPUT_PCSPKR=3Dm=0A=
CONFIG_INPUT_UINPUT=3Dm=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
# CONFIG_SERIAL_8250_CONSOLE is not set=0A=
# CONFIG_SERIAL_8250_ACPI is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_HW_RANDOM=3Dm=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dm=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
# CONFIG_HANGCHECK_TIMER is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dm=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dm=0A=
CONFIG_SND_TIMER=3Dm=0A=
CONFIG_SND_PCM=3Dm=0A=
CONFIG_SND_HWDEP=3Dm=0A=
CONFIG_SND_RAWMIDI=3Dm=0A=
CONFIG_SND_SEQUENCER=3Dm=0A=
CONFIG_SND_SEQ_DUMMY=3Dm=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dm=0A=
CONFIG_SND_PCM_OSS=3Dm=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
CONFIG_SND_RTCTIMER=3Dm=0A=
# CONFIG_SND_VERBOSE_PRINTK is not set=0A=
# CONFIG_SND_DEBUG is not set=0A=
=0A=
#=0A=
# Generic devices=0A=
#=0A=
# CONFIG_SND_DUMMY is not set=0A=
# CONFIG_SND_VIRMIDI is not set=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
# CONFIG_SND_MPU401 is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
CONFIG_SND_AC97_CODEC=3Dm=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_AU8810 is not set=0A=
# CONFIG_SND_AU8820 is not set=0A=
# CONFIG_SND_AU8830 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_BT87X is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
CONFIG_SND_EMU10K1=3Dm=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_MIXART is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
# CONFIG_SND_ALS4000 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
# CONFIG_SND_ENS1371 is not set=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
# CONFIG_SND_INTEL8X0 is not set=0A=
# CONFIG_SND_INTEL8X0M is not set=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
=0A=
#=0A=
# ALSA USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
CONFIG_USB_OHCI_HCD=3Dm=0A=
# CONFIG_USB_UHCI_HCD is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
CONFIG_USB_PRINTER=3Dm=0A=
# CONFIG_USB_STORAGE is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
CONFIG_USB_HID=3Dm=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
CONFIG_USB_HIDDEV=3Dy=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
CONFIG_USB_KBD=3Dm=0A=
CONFIG_USB_MOUSE=3Dm=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_EXT2_FS is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
CONFIG_REISERFS_FS=3Dy=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_REISERFS_PROC_INFO is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_NFS_FS is not set=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_EXPORTFS is not set=0A=
CONFIG_SMB_FS=3Dm=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"cp437"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dm=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set=0A=
# CONFIG_FRAME_POINTER is not set=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dm=0A=
CONFIG_CRYPTO_MD4=3Dm=0A=
CONFIG_CRYPTO_MD5=3Dy=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dm=0A=
CONFIG_CRYPTO_SHA512=3Dm=0A=
CONFIG_CRYPTO_DES=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH=3Dm=0A=
CONFIG_CRYPTO_TWOFISH=3Dm=0A=
CONFIG_CRYPTO_SERPENT=3Dm=0A=
CONFIG_CRYPTO_AES=3Dm=0A=
CONFIG_CRYPTO_CAST5=3Dm=0A=
CONFIG_CRYPTO_CAST6=3Dm=0A=
CONFIG_CRYPTO_ARC4=3Dm=0A=
CONFIG_CRYPTO_DEFLATE=3Dy=0A=
# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A=
CONFIG_CRYPTO_TEST=3Dm=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dm=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_X86_SMP=3Dy=0A=
CONFIG_X86_HT=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_X86_TRAMPOLINE=3Dy=0A=
CONFIG_PC=3Dy=0A=

------=_NextPart_000_0090_01C4246D.27D740F0--


