Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTGUWMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270743AbTGUWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:12:50 -0400
Received: from main.gmane.org ([80.91.224.249]:37073 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270734AbTGUWL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:11:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: andreas baeurle <a.baeurle@web.de>
Subject: Re: XP vfat partitions
Date: Tue, 22 Jul 2003 00:22:46 +0200
Message-ID: <bfhp94$1cr$1@main.gmane.org>
References: <bfechu$tse$1@main.gmane.org> <20030721175147.GD1158@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1177785.zP1uSfZheF"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1177785.zP1uSfZheF
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit

Mike Fedyk wrote:

> On Sun, Jul 20, 2003 at 05:27:03PM +0200, andreas wrote:
>> My question is howto mount a Xp-vfat partition with 2.6 kernel.
>> In my fstab is following entry:
>> /dev/hda2       /windows/C      vfat   
>> users,gid=users,umask=0002,iocharset=iso8859-1 code=437 0 0
> 
> Yes?
> 
> And what is your error message, and why do you think it's not working
> anymore?
I have 3 Partitions with vfat
the error message is:
<3>FAT: Unrecognized mount option code
<3>FAT: Unrecognized mount option code
<3>FAT: Unrecognized mount option code
in boot.msg
I have testet lsmod it shows me one vfat module loaded but not used

thanks
andreas
--nextPart1177785.zP1uSfZheF
Content-Type: text/plain; name=".config"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=m

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=64000
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=y
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
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
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
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
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_FERAL_ISP is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_IOCTL_V4=y

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_ARP_MANGLE is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
CONFIG_SCTP_ADLER32=y
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_HMAC_NONE=y
# CONFIG_SCTP_HMAC_SHA1 is not set
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_X25=m
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
CONFIG_NET_FASTROUTE=y
CONFIG_NET_HW_FLOWCONTROL=y

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=m
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
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
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

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
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=y
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PROSAVAGE is not set
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_ALI=m
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_GAMMA=m
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
# CONFIG_VIDEO_CPIA_USB is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_ROOT_NFS is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
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
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_KGDB is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--nextPart1177785.zP1uSfZheF
Content-Type: text/plain; name="boot.msg"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="boot.msg"

Inspecting /boot/System.map-2.6.0-test1-mm2
Loaded 25750 symbols from /boot/System.map-2.6.0-test1-mm2.
Symbols match kernel version 2.6.0.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.0-test1-mm2 (root@cascade) (gcc-Version 3.3 (SuSE Linux)) #1 Sun Jul 20 12:20:26 CEST 2003
<4>Video mode to be used for restore is 31a
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>384MB LOWMEM available.
<4>On node 0 totalpages: 98304
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 94208 pages, LIFO batch:16
<4>  HighMem zone: 0 pages, LIFO batch:1
<6>ACPI: RSDP (v000 ASUS                       ) @ 0x000f8190
<4>  >>> ERROR: Invalid checksum
<4>Building zonelist for node : 0
<4>Kernel command line: splash=silent root=0309 noinitrd vga=794 apic pci=biosirq hdd=ide-scsi hddlun=0
<6>ide_setup: hdd=ide-scsi
<6>ide_setup: hddlun=0
<4>No local APIC present or hardware disabled
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order 11: 16384 bytes)
<4>Detected 450.880 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 892.92 BogoMIPS
<6>Memory: 384784k/393216k available (2439k kernel code, 7680k reserved, 750k data, 348k init, 0k highmem)
<6>Security Scaffold v1.0.0 initialized
<6>Capability LSM initialized
<6>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>-> /dev
<6>-> /dev/console
<6>-> /root
<6>CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
<6>CPU: L2 Cache: 256K (32 bytes/line)
<7>CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
<4>CPU: AMD-K6(tm) 3D+ Processor stepping 01
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<6>mtrr: v2.0 (20020519)
<4>Initializing RT netlink socket
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
<6>PCI: Using configuration type 1
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
<6>ACPI: Subsystem revision 20030714
<4>tbxfroot-0324 [04] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
<3>ACPI: System description tables not found
<4> tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
<4> tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
<3>ACPI: Unable to load the System Description Tables
<6>Linux Plug and Play Support v0.96 (c) Adam Belay
<6>PnPBIOS: Scanning system for PnP BIOS support...
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00fd1f0
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xd220, dseg 0xf0000
<6>PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
<5>SCSI subsystem initialized
<4>ACPI: ACPI tables contain no PCI IRQ routing entries
<4>PCI: Invalid ACPI-PCI IRQ routing table
<4>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
<6>vesafb: framebuffer at 0xe0000000, mapped to 0xd8800000, size 8192k
<6>vesafb: mode is 1280x1024x16, linelength=2560, pages=2
<6>vesafb: protected mode interface info at c000:8558
<6>vesafb: scrolling: redraw
<6>vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
<6>fb0: VESA VGA frame buffer device
<4>Console: switching to colour frame buffer device 160x64
<4>pty: 256 Unix98 ptys configured
<5>VFS: Disk quotas dquot_6.5.1
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<6>SGI XFS for Linux 2.6.0-test1-mm2 with no debug enabled
<6>Initializing Cryptographic API
<6>isapnp: Scanning for PnP cards...
<6>pnp: SB audio device quirk - increasing port range
<6>pnp: AWE32 quirk - adding two ports
<6>isapnp: Card 'Creative SB AWE64  PnP'
<6>isapnp: 1 Plug & Play card detected total
<6>Real Time Clock Driver v1.11
<6>Linux agpgart interface v0.100 (c) Dave Jones
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>anticipatory scheduling elevator
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>ALI15X3: IDE controller at PCI slot 0000:00:0f.0
<6>ALI15X3: chipset revision 193
<6>ALI15X3: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
<6>    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:pio
<4>hda: WDC WD600AB-00BVA0, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hdc: LTN526, ATAPI CD/DVD-ROM drive
<4>hdd: 8X4X32, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hda: max request size: 128KiB
<6>hda: host protected area => 1
<6>hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
<4>ide-floppy driver 0.99.newide
<4>Console: switching to colour frame buffer device 160x64
<6>mice: PS/2 mouse device common for all mice
<6>input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
<6>ALSA device list:
<6>  No soundcards found.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>found reiserfs format "3.6" with standard journal
<4>Reiserfs journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<4>reiserfs: checking transaction log (hda9) for (hda9)
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 348k freed
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<4>Module md cannot be unloaded due to unsafe usage in include/linux/module.h:483
<6>Adding 538136k swap on /dev/hda8.  Priority:42 extents:1
<4>found reiserfs format "3.6" with standard journal
<4>Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<4>reiserfs: checking transaction log (hda1) for (hda1)
<4>Using r5 hash to sort names
<3>FAT: Unrecognized mount option code
<3>FAT: Unrecognized mount option code
<3>FAT: Unrecognized mount option code
<4>end_request: I/O error, dev hdc, sector 0
<4>hdc: ATAPI 52X CD-ROM drive, 120kB Cache, (U)DMA
<6>Uniform CD-ROM driver Revision: 3.12
<6>scsi0 : SCSI host adapter emulation for IDE ATAPI devices
<5>  Vendor: ATAPI     Model: CD-R/RW 8X4X32    Rev: 5.CX
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Tue Jul 22 01:52:57 2003

Configuring serial ports...

ttyS0 at 0x03f8 (irq = 4) is a 16550A

ttyS1 at 0x02f8 (irq = 3) is a 16550A

Configured serial ports


doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel

Run file system check on root for LVM activation


doneRemounting root file system (/) read/write for vgscan...

Scanning for LVM volume groups...

modprobe: FATAL: Module lvm_mod not found.




vgscan -- LVM driver/module not loaded?



Activating LVM volume groups...

modprobe: FATAL: Module lvm_mod not found.




modprobe: FATAL: Module lvm_mod not found.




vgchange -- LVM driver/module not loaded?




done

Activating swap-devices in /etc/fstab...


doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel

Checking file systems...

fsck 1.28 (31-Aug-2002)

Reiserfs super block in block 16 on 0x309 of format 3.6 with standard journal

Blocks (total/free): 4887768/1663292 by 4096 bytes

Filesystem is clean

/dev/hda3: clean, 57/26208 files, 18403/104422 blocks


doneMounting local file systems...

proc on /proc type proc (rw)

devpts on /dev/pts type devpts (rw,mode=0620,gid=5)

/dev/hda3 on /boot type ext2 (rw)

/dev/hda1 on /data1 type reiserfs (rw)

mount: wrong fs type, bad option, bad superblock on /dev/hda2,

       or too many mounted file systems

mount: wrong fs type, bad option, bad superblock on /dev/hda5,

       or too many mounted file systems

mount: wrong fs type, bad option, bad superblock on /dev/hda7,

       or too many mounted file systems


failedLoading required kernel modules


doneSetting up IDE DMA mode



/dev/hdc:

 setting using_dma to 1 (on)

 using_dma    =  1 (on)


done

Restore device permissions
done

Activating remaining swap-devices in /etc/fstab...


doneSetting up the CMOS clock
done

Setting up timezone data
done

Setting up hostname 'cascade'
done

Setting up loopback interface 
done

Enabling syn flood protection
done

Enabling IP forwarding
done

Creating /var/log/boot.msg


doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel

<notice>killproc: kill(31,29)
Running /etc/init.d/boot.local

modprobe: FATAL: Error inserting cpia_pp (/lib/modules/2.6.0-test1-mm2/kernel/drivers/media/video/cpia_pp.ko): Unknown symbol in module, or unknown parameter (see dmesg)




/etc/init.d/boot.local: line 35: /proc/sys/kernel/lowlatency: No such file or directory


failed<notice>killproc: kill(31,3)

Boot logging started on /dev/tty1(/dev/console) at Mon Jul 21 23:53:11 2003

Master Resource Control: previous runlevel: N, switching to runlevel: 
5


INIT: Entering runlevel: 5


<notice>/etc/init.d/rc5.d/S01SuSEfirewall2_init start
Starting Firewall Initialization (phase 1 of 3) 
done

<notice>'/etc/init.d/rc5.d/S01SuSEfirewall2_init start' exits with status 0
<notice>/etc/init.d/rc5.d/S01alsasound start
Starting sound driver:  already running
done

<notice>'/etc/init.d/rc5.d/S01alsasound start' exits with status 0
<notice>/etc/init.d/rc5.d/S01amavis start
<notice>'/etc/init.d/rc5.d/S01amavis start' exits with status 5
<notice>/etc/init.d/rc5.d/S01atd start
Starting service at daemon<notice>startproc: execve (/usr/sbin/atd) [ /usr/sbin/atd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=20 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/atd ]

done

<notice>'/etc/init.d/rc5.d/S01atd start' exits with status 0
<notice>/etc/init.d/rc5.d/S01kbd start
Loading keymap qwertz/de-latin1-nodeadkeys.map.gz


doneLoading compose table latin1.add
done

Loading console font lat9w-16.psfu


doneLoading screenmap trivial


doneSetting up console ttys


done<notice>'/etc/init.d/rc5.d/S01kbd start' exits with status 0
<notice>/etc/init.d/rc5.d/S01random start
Initializing random number generator
done

<notice>'/etc/init.d/rc5.d/S01random start' exits with status 0
<notice>/etc/init.d/rc5.d/S01rpmconfigcheck start
<notice>'/etc/init.d/rc5.d/S01rpmconfigcheck start' exits with status 0
<notice>/etc/init.d/rc5.d/S05network start
Setting up network interfaces:

    lo        
done

    eth0      IP/Netmask:     192.168.0.1 / 255.255.255.0  
done

    eth1      IP/Netmask:      192.10.0.1 / 255.255.255.0  
done

    dsl0      
manual

<notice>'/etc/init.d/rc5.d/S05network start' exits with status 0
<notice>/etc/init.d/rc5.d/S06syslog start
Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ /sbin/syslogd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=25 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/sbin/syslogd ]
<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=25 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/sbin/klogd ]

done

<notice>'/etc/init.d/rc5.d/S06syslog start' exits with status 0
<notice>/etc/init.d/rc5.d/S07SuSEfirewall2_setup start
Starting Firewall Initialization (phase 2 of 3) Warning: No nameservers in /etc/resolv.conf!

Warning: No nameservers in /etc/resolv.conf!

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"


done

<notice>'/etc/init.d/rc5.d/S07SuSEfirewall2_setup start' exits with status 0
<notice>/etc/init.d/rc5.d/S07nmb start
Starting Samba classic NMB daemon <notice>startproc: execve (/usr/lib/samba/classic/nmbd) [ /usr/lib/samba/classic/nmbd -D -s /etc/samba/smb.conf ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=27 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/lib/samba/classic/nmbd ]

done

<notice>'/etc/init.d/rc5.d/S07nmb start' exits with status 0
<notice>/etc/init.d/rc5.d/S07sshd start
Starting SSH daemon<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=28 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/sshd ]

done

<notice>'/etc/init.d/rc5.d/S07sshd start' exits with status 0
<notice>/etc/init.d/rc5.d/S08lisa start
Starting lan browser daemon for KDE<notice>startproc: execve (/usr/sbin/lisa) [ /usr/sbin/lisa -c /etc/lisarc ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=29 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/lisa ]

done

<notice>'/etc/init.d/rc5.d/S08lisa start' exits with status 0
<notice>/etc/init.d/rc5.d/S08nscd start
Starting Name Service Cache Daemon<notice>startproc: execve (/usr/sbin/nscd) [ /usr/sbin/nscd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=30 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/nscd ]

done

<notice>'/etc/init.d/rc5.d/S08nscd start' exits with status 0
<notice>/etc/init.d/rc5.d/S08portmap start
Starting RPC portmap daemon<notice>startproc: execve (/sbin/portmap) [ /sbin/portmap
failed

<notice>'/etc/init.d/rc5.d/S08portmap start' exits with status 7
<notice>/etc/init.d/rc5.d/S08postfix start
 ], [ CONSOLE=/dev/consoleStarting mail service (Postfix) TERM=linux SHELL=/bin/sh progress=31 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/sbin/portmap ]

done

<notice>'/etc/init.d/rc5.d/S08postfix start' exits with status 0
<notice>/etc/init.d/rc5.d/S08resmgr start
Starting resource manager<notice>startproc: execve (/sbin/resmgrd) [ /sbin/resmgrd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=33 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/sbin/resmgrd ]

done

<notice>'/etc/init.d/rc5.d/S08resmgr start' exits with status 0
<notice>/etc/init.d/rc5.d/S08smpppd start
Starting SMPPPD<notice>startproc: execve (/usr/sbin/smpppd) [ /usr/sbin/smpppd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=34 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/smpppd ]

done

<notice>'/etc/init.d/rc5.d/S08smpppd start' exits with status 0
<notice>/etc/init.d/rc5.d/S08webmin start
<notice>'/etc/init.d/rc5.d/S08webmin start' exits with status 0
<notice>/etc/init.d/rc5.d/S08xdm start
Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kde3/bin/kdm ], [ LC_MONETARY= CONSOLE=/dev/console TERM=linux SHELL=/bin/sh LC_NUMERIC= QTDIR=/usr/lib/qt3 LC_ALL= progress=36 INIT_VERSION=sysvinit-2.82 KDEROOTHOME=/root/.kdm REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin LC_MESSAGES= vga=794 RUNLEVEL=5 LC_COLLATE=POSIX PWD=/ LANG=de_DE@euro PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 no_proxy=localhost RC_LC_COLLATE=POSIX WINDOWMANAGER=/usr/X11R6/bin/kde PRINTER=normal RC_LANG=de_DE@euro LC_CTYPE=de_DE@euro splash=silent sscripts=40 LC_TIME= _=/sbin/startproc DAEMON=/opt/kde3/bin/kdm ]

done

<notice>'/etc/init.d/rc5.d/S08xdm start' exits with status 0
<notice>/etc/init.d/rc5.d/S09cron start
Starting CRON daemon<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=37 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/cron ]

done

Starting cupsd<notice>'/etc/init.d/rc5.d/S09cron start' exits with status 0
<notice>/etc/init.d/rc5.d/S09cups start
<notice>startproc: execve (/usr/sbin/cupsd) [ /usr/sbin/cupsd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=38 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/sbin/cupsd ]

done

<notice>'/etc/init.d/rc5.d/S09cups start' exits with status 0
<notice>/etc/init.d/rc5.d/S10SuSEfirewall2_final start
Starting Firewall Initialization (phase 3 of 3) Warning: No nameservers in /etc/resolv.conf!

Warning: No nameservers in /etc/resolv.conf!

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"

Cannot find device "ppp0"


done

<notice>'/etc/init.d/rc5.d/S10SuSEfirewall2_final start' exits with status 0
<notice>/etc/init.d/rc5.d/S10smb start
Starting Samba classic SMB daemon <notice>
failed

<notice>'/etc/init.d/rc5.d/S10smb start' exits with status 7
startproc: execve (/usr/lib/samba/classic/smbd) [ /usr/lib/samba/classic/smbd -D -s /etc/samba/smb.conf ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh TMPDIR=/var/tmp progress=40 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=160 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=794 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=64 HOME=/ SHLVL=2 splash=silent sscripts=40 _=/sbin/startproc DAEMON=/usr/lib/samba/classic/smbd ]
<notice>/etc/init.d/rc5.d/S20avupdater start
Starting AntiVir: avupdater.

<notice>'/etc/init.d/rc5.d/S20avupdater start' exits with status 0
Master Resource Control: runlevel 5 has been 
reached

Failed services in runlevel 5:   portmap  smb

Skipped services in runlevel 5:  amavis

<notice>killproc: kill(253,3)

--nextPart1177785.zP1uSfZheF--

