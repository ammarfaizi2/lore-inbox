Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUERJKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUERJKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 05:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUERJKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 05:10:55 -0400
Received: from smtp3.idctelecomitalia.biz ([217.169.125.100]:31438 "EHLO
	dtcmfe03.dtc.swing.com") by vger.kernel.org with ESMTP
	id S261321AbUERJJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 05:09:23 -0400
From: "Eduard Roccatello" <lilo@roccatello.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.6 issues on IDE and GemTek Radio
Date: Tue, 18 May 2004 10:58:44 +0200
Organization: Novacomp Technology
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAl7tkcaWqPUW2mjQuSvWqZAEAKqodSdQVOEaR9VOf9kh0aQAAAAGXGwAAEAAAAFePwr1XwpRLqbyaidpgUrgBAAAAAA==@roccatello.it>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C43CC7.177EA230"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ5HmgCr+Z/aktLTbydViJA3WZslgDlz0wg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-OriginalArrivalTime: 18 May 2004 09:07:25.0780 (UTC) FILETIME=[898FC940:01C43CB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello people,
I've some trouble on 2.6.6 with ide devices

(this is from syslog)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }

VP_IDE: User given PCI clock speed impossible (66000), using 33 MHz instead.
VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.

and with gemtek radio module: no problems on module insertion but oops on
accessing /dev/radio node

I've attached some infos that can be useful to trace this problem
Thank you

--
Eduard Roccatello
S.P.I.N.E. Group @ http://www.spine-group.org
Xfce Desktop Enviroment @ http://www.xfce.org


------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	name="botappend.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="botappend.txt"

  append = "idebus=66 ide0=ata66 hdd=ide-cd hdc=ide-cd"


------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	name="config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config.txt"

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
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
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
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

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
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

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
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
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
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
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
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_AMANDA=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
# CONFIG_IP6_NF_RAW is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
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
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
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
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
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
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_GEMTEK=m
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
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
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
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
# CONFIG_SND_INTEL8X0M is not set
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
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
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
# CONFIG_USB_SE401 is not set
CONFIG_USB_STV680=m
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=y
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
# CONFIG_USB_ZERO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
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
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf-8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
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
CONFIG_NLS_ISO8859_1=y
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
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y


------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	name="gemtek.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gemtek.txt"

May 12 23:51:51 darkstar kernel: videodev: "GemTek radio" has no release =
callback. Please fix your driver for proper sysfs support, see =
http://lwn.net/Articles/36850/
May 12 23:52:03 darkstar kernel: Unable to handle kernel NULL pointer =
dereference at virtual address 00000000
May 12 23:52:03 darkstar kernel:  printing eip:
May 12 23:52:03 darkstar kernel: cf262391
May 12 23:52:03 darkstar kernel: *pde =3D 00000000
May 12 23:52:03 darkstar kernel: Oops: 0002 [#1]
May 12 23:52:03 darkstar kernel: PREEMPT=20
May 12 23:52:03 darkstar kernel: CPU:    0
May 12 23:52:03 darkstar kernel: EIP:    0060:[<cf262391>]    Not =
tainted
May 12 23:52:03 darkstar kernel: EFLAGS: 00210246   (2.6.6)=20
May 12 23:52:03 darkstar kernel: EIP is at gemtek_do_ioctl+0x111/0x1e0 =
[radio_gemtek]
May 12 23:52:03 darkstar kernel: eax: 00000000   ebx: cf263500   ecx: =
0000000a   edx: cf2630a0
May 12 23:52:03 darkstar kernel: esi: 80287610   edi: 00000000   ebp: =
c662fef0   esp: c662feb0
May 12 23:52:03 darkstar kernel: ds: 007b   es: 007b   ss: 0068
May 12 23:52:03 darkstar kernel: Process gqradio (pid: 435, =
threadinfo=3Dc662e000 task=3Dc647a630)
May 12 23:52:03 darkstar kernel: Stack: c6213680 0017e080 00000000 =
c662fef0 c024a0aa c662fef0 bffff99c 80287610=20
May 12 23:52:03 darkstar kernel:        fffffff2 c662fef0 00000000 =
c02aa72b c61cfc9c c6213680 80287610 c662fef0=20
May 12 23:52:03 darkstar kernel:        0017e080 00004d46 00000000 =
40183fd2 40a29c83 0005c542 bffff9e8 4013bd50=20
May 12 23:52:03 darkstar kernel: Call Trace:
May 12 23:52:03 darkstar kernel:  [<c024a0aa>] copy_from_user+0x4a/0x80
May 12 23:52:03 darkstar kernel:  [<c02aa72b>] video_usercopy+0x7b/0x140
May 12 23:52:03 darkstar kernel:  [<c015b146>] open_namei+0xa6/0x410
May 12 23:52:03 darkstar kernel:  [<c014b461>] dentry_open+0x151/0x220
May 12 23:52:03 darkstar kernel:  [<c014b308>] filp_open+0x68/0x70
May 12 23:52:03 darkstar kernel:  [<cf26248f>] gemtek_ioctl+0x2f/0x40 =
[radio_gemtek]
May 12 23:52:03 darkstar kernel:  [<cf262280>] gemtek_do_ioctl+0x0/0x1e0 =
[radio_gemtek]
May 12 23:52:03 darkstar kernel:  [<c015e6a0>] sys_ioctl+0x100/0x270
May 12 23:52:03 darkstar kernel:  [<c010421b>] syscall_call+0x7/0xb
May 12 23:52:03 darkstar kernel:=20
May 12 23:52:03 darkstar kernel: Code: f3 ab b8 10 00 00 00 be 01 00 00 =
00 bb ff ff ff ff 83 0d 0c=20


------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	name="messages.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="messages.txt"

May 12 23:43:07 darkstar syslogd 1.4.1: restart.
May 12 23:43:09 darkstar kernel: klogd 1.4.1, log source =3D /proc/kmsg =
started.
May 12 23:43:09 darkstar kernel: BIOS-provided physical RAM map:
May 12 23:43:09 darkstar kernel: 191MB LOWMEM available.
May 12 23:43:09 darkstar kernel: DMI 2.2 present.
May 12 23:43:09 darkstar kernel: ACPI disabled because your bios is from =
00 and too old
May 12 23:43:09 darkstar kernel: You can enable it with acpi=3Dforce
May 12 23:43:09 darkstar kernel: ide_setup: idebus=3D66
May 12 23:43:09 darkstar kernel: ide_setup: ide0=3Data66
May 12 23:43:09 darkstar kernel: ide_setup: hdd=3Dide-cd
May 12 23:43:09 darkstar kernel: ide_setup: hdc=3Dide-cd
May 12 23:43:09 darkstar kernel: Initializing CPU#0
May 12 23:43:09 darkstar kernel: Using tsc for high-res timesource
May 12 23:43:09 darkstar kernel: Memory: 189628k/196544k available =
(3143k kernel code, 6292k reserved, 998k data, 168k init, 0k highmem)
May 12 23:43:09 darkstar kernel: Dentry cache hash table entries: 32768 =
(order: 5, 131072 bytes)
May 12 23:43:09 darkstar kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 12 23:43:09 darkstar kernel: CPU: L2 cache: 256K
May 12 23:43:09 darkstar kernel: Enabling fast FPU save and restore... =
done.
May 12 23:43:09 darkstar kernel: Enabling unmasked SIMD FPU exception =
support... done.
May 12 23:43:09 darkstar kernel: Checking 'hlt' instruction... OK.
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 16
May 12 23:43:09 darkstar kernel: PCI: PCI BIOS revision 2.10 entry at =
0xfb2f0, last bus=3D1
May 12 23:43:09 darkstar kernel: PCI: Using configuration type 1
May 12 23:43:09 darkstar kernel: mtrr: v2.0 (20020519)
May 12 23:43:09 darkstar kernel: SCSI subsystem initialized
May 12 23:43:09 darkstar kernel: usbcore: registered new driver usbfs
May 12 23:43:09 darkstar kernel: usbcore: registered new driver hub
May 12 23:43:09 darkstar kernel: PCI: Using IRQ router VIA [1106/0596] =
at 0000:00:07.0
May 12 23:43:09 darkstar kernel: apm: BIOS version 1.2 Flags 0x07 =
(Driver version 1.16ac)
May 12 23:43:09 darkstar kernel: NTFS driver 2.1.8 [Flags: R/O].
May 12 23:43:09 darkstar kernel: udf: registering filesystem
May 12 23:43:09 darkstar kernel: SGI XFS with no debug enabled
May 12 23:43:09 darkstar kernel: Initializing Cryptographic API
May 12 23:43:09 darkstar kernel: Activating ISA DMA hang workarounds.
May 12 23:43:09 darkstar kernel: Real Time Clock Driver v1.12
May 12 23:43:09 darkstar kernel: Linux agpgart interface v0.100 (c) Dave =
Jones
May 12 23:43:09 darkstar kernel: agpgart: Detected VIA Apollo Pro 133 =
chipset
May 12 23:43:09 darkstar kernel: agpgart: Maximum main memory to use for =
agp memory: 149M
May 12 23:43:09 darkstar kernel: agpgart: AGP aperture is 128M @ =
0xd0000000
May 12 23:43:09 darkstar kernel: [drm] Initialized mga 3.1.0 20021029 on =
minor 0
May 12 23:43:09 darkstar kernel: Serial: 8250/16550 driver $Revision: =
1.90 $ 8 ports, IRQ sharing disabled
May 12 23:43:09 darkstar kernel: Floppy drive(s): fd0 is 1.44M
May 12 23:43:09 darkstar kernel: FDC 0 is a post-1991 82077
May 12 23:43:09 darkstar kernel: loop: loaded (max 8 devices)
May 12 23:43:09 darkstar kernel: PPP generic driver version 2.4.2
May 12 23:43:09 darkstar kernel: PPP Deflate Compression module =
registered
May 12 23:43:09 darkstar kernel: 8139too Fast Ethernet driver 0.9.27
May 12 23:43:09 darkstar kernel: PCI: Found IRQ 9 for device =
0000:00:0f.0
May 12 23:43:09 darkstar kernel: eth0: RealTek RTL8139 at 0xcc826000, =
00:40:05:89:8a:b4, IRQ 9
May 12 23:43:09 darkstar kernel: Linux video capture interface: v1.00
May 12 23:43:09 darkstar kernel: Uniform Multi-Platform E-IDE driver =
Revision: 7.00alpha2
May 12 23:43:09 darkstar kernel: ide: Assuming 66MHz system bus speed =
for PIO modes
May 12 23:43:09 darkstar kernel: VP_IDE: IDE controller at PCI slot =
0000:00:07.1
May 12 23:43:09 darkstar kernel: VP_IDE: chipset revision 16
May 12 23:43:09 darkstar kernel: VP_IDE: not 100%% native mode: will =
probe irqs later
May 12 23:43:09 darkstar kernel: VP_IDE: VIA vt82c596b (rev 22) IDE =
UDMA66 controller on pci0000:00:07.1
May 12 23:43:09 darkstar kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS =
settings: hda:DMA, hdb:DMA
May 12 23:43:09 darkstar kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS =
settings: hdc:DMA, hdd:DMA
May 12 23:43:09 darkstar kernel: hda: 160086528 sectors (81964 MB) =
w/2048KiB Cache, CHS=3D65535/16/63
May 12 23:43:09 darkstar kernel:  hda: hda1 hda2 hda3 hda4
May 12 23:43:09 darkstar kernel: hda: Write Cache FAILED Flushing!
May 12 23:43:09 darkstar kernel: hdb: 30008475 sectors (15364 MB) =
w/512KiB Cache, CHS=3D29770/16/63
May 12 23:43:09 darkstar kernel:  hdb: hdb1 hdb2
May 12 23:43:09 darkstar kernel: Uniform CD-ROM driver Revision: 3.20
May 12 23:43:09 darkstar kernel: USB Universal Host Controller Interface =
driver v2.2
May 12 23:43:09 darkstar kernel: PCI: Found IRQ 10 for device =
0000:00:07.2
May 12 23:43:09 darkstar kernel: uhci_hcd 0000:00:07.2: VIA =
Technologies, Inc. USB
May 12 23:43:09 darkstar kernel: uhci_hcd 0000:00:07.2: irq 10, io base =
0000d400
May 12 23:43:09 darkstar kernel: uhci_hcd 0000:00:07.2: new USB bus =
registered, assigned bus number 1
May 12 23:43:09 darkstar kernel: hub 1-0:1.0: USB hub found
May 12 23:43:09 darkstar kernel: hub 1-0:1.0: 2 ports detected
May 12 23:43:09 darkstar kernel: usbcore: registered new driver usblp
May 12 23:43:09 darkstar kernel: drivers/usb/class/usblp.c: v0.13: USB =
Printer Device Class driver
May 12 23:43:09 darkstar kernel: Initializing USB Mass Storage driver...
May 12 23:43:09 darkstar kernel: usbcore: registered new driver =
usb-storage
May 12 23:43:09 darkstar kernel: USB Mass Storage support registered.
May 12 23:43:09 darkstar kernel: usbcore: registered new driver hiddev
May 12 23:43:09 darkstar kernel: usbcore: registered new driver hid
May 12 23:43:09 darkstar kernel: drivers/usb/input/hid-core.c: v2.0:USB =
HID core driver
May 12 23:43:09 darkstar kernel: mice: PS/2 mouse device common for all =
mice
May 12 23:43:09 darkstar kernel: serio: i8042 AUX port at 0x60,0x64 irq =
12
May 12 23:43:09 darkstar kernel: input: ImExPS/2 Logitech Explorer Mouse =
on isa0060/serio1
May 12 23:43:09 darkstar kernel: serio: i8042 KBD port at 0x60,0x64 irq =
1
May 12 23:43:09 darkstar kernel: input: AT Translated Set 2 keyboard on =
isa0060/serio0
May 12 23:43:09 darkstar kernel: i2c /dev entries driver
May 12 23:43:09 darkstar kernel: Advanced Linux Sound Architecture =
Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
May 12 23:43:09 darkstar kernel: PCI: Found IRQ 5 for device =
0000:00:0b.0
May 12 23:43:09 darkstar kernel: ALSA device list:
May 12 23:43:09 darkstar kernel:   #0: Sound Blaster Live! (rev.7) at =
0xd800, irq 5
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 2
May 12 23:43:09 darkstar kernel: IP: routing cache hash table of 1024 =
buckets, 8Kbytes
May 12 23:43:09 darkstar kernel: TCP: Hash tables configured =
(established 16384 bind 32768)
May 12 23:43:09 darkstar kernel: ipt_recent v0.3.1: Stephen Frost =
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 1
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 10
May 12 23:43:09 darkstar kernel: IPv6 over IPv4 tunneling driver
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 17
May 12 23:43:09 darkstar kernel: NET: Registered protocol family 15
May 12 23:43:09 darkstar kernel: hda: Write Cache FAILED Flushing!
May 12 23:43:09 darkstar last message repeated 5 times
May 12 23:43:09 darkstar kernel: XFS mounting filesystem hda3
May 12 23:43:09 darkstar kernel: usb 1-1: new full speed USB device =
using address 2
May 12 23:43:09 darkstar kernel: Freeing unused kernel memory: 168k =
freed
May 12 23:43:09 darkstar kernel: scsi0 : SCSI emulation for USB Mass =
Storage devices
May 12 23:43:09 darkstar kernel:   Vendor: I0MEGA    Model: Mini  64*IOM =
     Rev: 3.04
May 12 23:43:09 darkstar kernel:   Type:   Direct-Access                 =
     ANSI SCSI revision: 02
May 12 23:43:09 darkstar kernel: SCSI device sda: 127840 512-byte hdwr =
sectors (65 MB)
May 12 23:43:09 darkstar kernel: sda: assuming Write Enabled
May 12 23:43:09 darkstar kernel:  sda: sda1
May 12 23:43:09 darkstar kernel: Attached scsi removable disk sda at =
scsi0, channel 0, id 0, lun 0
May 12 23:43:09 darkstar kernel: Attached scsi generic sg0 at scsi0, =
channel 0, id 0, lun 0,  type 0
May 12 23:43:09 darkstar kernel: usb 1-2: new low speed USB device using =
address 3
May 12 23:43:09 darkstar kernel: Adding 393616k swap on /dev/hda2.  =
Priority:-1 extents:1
May 12 23:43:09 darkstar kernel: hiddev96: USB HID v1.10 Device =
[American Power Conversion Back-UPS CS 500 FW:808.q3.I USB FW:q3] on =
usb-0000:00:07.2-2
May 12 23:43:09 darkstar kernel: eth0: link up, 100Mbps, full-duplex, =
lpa 0x45E1
May 12 23:43:09 darkstar sshd[295]: Server listening on :: port 22.
May 12 23:43:18 darkstar kernel: bttv: driver version 0.9.14 loaded
May 12 23:43:18 darkstar kernel: bttv: using 8 buffers with 2080k (520 =
pages) each for capture
May 12 23:43:18 darkstar kernel: bttv: Bt8xx card found (0).
May 12 23:43:18 darkstar kernel: PCI: Found IRQ 11 for device =
0000:00:09.0
May 12 23:43:18 darkstar kernel: PCI: Sharing IRQ 11 with 0000:00:09.1
May 12 23:43:18 darkstar kernel: bttv0: Bt878 (rev 17) at 0000:00:09.0, =
irq: 11, latency: 32, mmio: 0xde000000
May 12 23:43:18 darkstar kernel: bttv0: detected: Pinnacle PCTV =
[card=3D39], PCI subsystem ID is 11bd:0012
May 12 23:43:18 darkstar kernel: bttv0: using: Pinnacle PCTV Studio/Rave =
[card=3D39,insmod option]
May 12 23:43:18 darkstar kernel: bttv0: i2c: checking for MSP34xx @ =
0x80... not found
May 12 23:43:18 darkstar kernel: bttv0: pinnacle/mt: id=3D1 info=3D"PAL =
/ mono" radio=3Dno
May 12 23:43:18 darkstar kernel: bttv0: i2c: checking for MSP34xx @ =
0x80... not found
May 12 23:43:18 darkstar kernel: bttv0: i2c: checking for TDA9875 @ =
0xb0... not found
May 12 23:43:18 darkstar kernel: bttv0: i2c: checking for TDA7432 @ =
0x8a... not found
May 12 23:43:18 darkstar kernel: bttv0: registered device video0
May 12 23:43:18 darkstar kernel: bttv0: registered device vbi0
May 12 23:43:18 darkstar kernel: bttv0: PLL: 28636363 =3D> 35468950 .. =
ok
May 12 23:43:37 darkstar kernel: agpgart: Found an AGP 1.0 compliant =
device at 0000:00:00.0.
May 12 23:43:37 darkstar kernel: agpgart: Putting AGP V2 device at =
0000:00:00.0 into 2x mode
May 12 23:43:37 darkstar kernel: agpgart: Putting AGP V2 device at =
0000:01:00.0 into 2x mode


------=_NextPart_000_0000_01C43CC7.177EA230
Content-Type: text/plain;
	name="syslog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog.txt"

May 12 23:43:09 darkstar kernel: Linux version 2.6.6 (root@darkstar) =
(gcc version 3.2.3) #8 Wed May 12 23:41:05 CEST 2004
May 12 23:43:09 darkstar kernel:  BIOS-e820: 0000000000000000 - =
000000000009fc00 (usable)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 000000000009fc00 - =
00000000000a0000 (reserved)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 00000000000f0000 - =
0000000000100000 (reserved)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 0000000000100000 - =
000000000bff0000 (usable)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 000000000bff0000 - =
000000000bff3000 (ACPI NVS)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 000000000bff3000 - =
000000000c000000 (ACPI data)
May 12 23:43:09 darkstar kernel:  BIOS-e820: 00000000ffff0000 - =
0000000100000000 (reserved)
May 12 23:43:09 darkstar kernel: On node 0 totalpages: 49136
May 12 23:43:09 darkstar kernel:   DMA zone: 4096 pages, LIFO batch:1
May 12 23:43:09 darkstar kernel:   Normal zone: 45040 pages, LIFO =
batch:10
May 12 23:43:09 darkstar kernel:   HighMem zone: 0 pages, LIFO batch:1
May 12 23:43:09 darkstar kernel: Built 1 zonelists
May 12 23:43:09 darkstar kernel: Kernel command line: =
BOOT_IMAGE=3Dlinux-266 rw root=3D303 idebus=3D66 ide0=3Data66 =
hdd=3Dide-cd hdc=3Dide-cd
May 12 23:43:09 darkstar kernel: Local APIC disabled by BIOS -- =
reenabling.
May 12 23:43:09 darkstar kernel: Found and enabled local APIC!
May 12 23:43:09 darkstar kernel: PID hash table entries: 1024 (order 10: =
8192 bytes)
May 12 23:43:09 darkstar kernel: Detected 733.614 MHz processor.
May 12 23:43:09 darkstar kernel: Console: colour VGA+ 80x25
May 12 23:43:09 darkstar kernel: Checking if this processor honours the =
WP bit even in supervisor mode... Ok.
May 12 23:43:09 darkstar kernel: Calibrating delay loop... 1445.88 =
BogoMIPS
May 12 23:43:09 darkstar kernel: Inode-cache hash table entries: 16384 =
(order: 4, 65536 bytes)
May 12 23:43:09 darkstar kernel: Mount-cache hash table entries: 512 =
(order: 0, 4096 bytes)
May 12 23:43:09 darkstar kernel: CPU: Intel Pentium III (Coppermine) =
stepping 03
May 12 23:43:09 darkstar kernel: POSIX conformance testing by UNIFIX
May 12 23:43:09 darkstar kernel: enabled ExtINT on CPU#0
May 12 23:43:09 darkstar kernel: ESR value before enabling vector: =
00000000
May 12 23:43:09 darkstar kernel: ESR value after enabling vector: =
00000000
May 12 23:43:09 darkstar kernel: Using local APIC timer interrupts.
May 12 23:43:09 darkstar kernel: calibrating APIC timer ...
May 12 23:43:09 darkstar kernel: ..... CPU clock speed is 733.0289 MHz.
May 12 23:43:09 darkstar kernel: ..... host bus clock speed is 133.0325 =
MHz.
May 12 23:43:09 darkstar kernel: PCI: Probing PCI hardware
May 12 23:43:09 darkstar kernel: PCI: Probing PCI hardware (bus 00)
May 12 23:43:09 darkstar kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a =
16550A
May 12 23:43:09 darkstar kernel: ttyS1 at I/O 0x2f8 (irq =3D 3) is a =
16550A
May 12 23:43:09 darkstar kernel: Using anticipatory io scheduler
May 12 23:43:09 darkstar kernel: VP_IDE: User given PCI clock speed =
impossible (66000), using 33 MHz instead.
May 12 23:43:09 darkstar kernel: VP_IDE: Use ide0=3Data66 if you want to =
assume 80-wire cable.
May 12 23:43:09 darkstar kernel: hda: Maxtor 6Y080L0, ATA DISK drive
May 12 23:43:09 darkstar kernel: hdb: ST315323A, ATA DISK drive
May 12 23:43:09 darkstar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 12 23:43:09 darkstar kernel: hdc: HL-DT-STDVD-ROM GDR8161B, ATAPI =
CD/DVD-ROM drive
May 12 23:43:09 darkstar kernel: hdd: HL-DT-ST GCE-8480B, ATAPI =
CD/DVD-ROM drive
May 12 23:43:09 darkstar kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 12 23:43:09 darkstar kernel: hda: max request size: 128KiB
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: hdb: max request size: 128KiB
May 12 23:43:09 darkstar kernel: hdc: ATAPI 48X DVD-ROM drive, 256kB =
Cache
May 12 23:43:09 darkstar kernel: hdd: ATAPI 48X CD-ROM CD-R/RW CD-MRW =
drive, 2048kB Cache
May 12 23:43:09 darkstar kernel: ide-floppy driver 0.99.newide
May 12 23:43:09 darkstar kernel: ip_conntrack version 2.1 (1535 buckets, =
12280 max) - 296 bytes per conntrack
May 12 23:43:09 darkstar kernel: ip_tables: (C) 2000-2002 Netfilter core =
team
May 12 23:43:09 darkstar kernel: arp_tables: (C) 2002 David S. Miller
May 12 23:43:09 darkstar kernel: ip6_tables: (C) 2000-2002 Netfilter =
core team
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: UDF-fs: No VRS found
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: status=3D0x51 { =
DriveReady SeekComplete Error }
May 12 23:43:09 darkstar kernel: hda: task_no_data_intr: error=3D0x04 { =
DriveStatusError }
May 12 23:43:09 darkstar kernel: VFS: Mounted root (xfs filesystem).
May 12 23:43:09 darkstar kernel: sda: assuming drive cache: write =
through
May 12 23:43:09 darkstar kernel: EXT2-fs warning: mounting unchecked fs, =
running e2fsck is recommended
May 12 23:43:09 darkstar kernel: EXT2-fs warning: mounting unchecked fs, =
running e2fsck is recommended
May 12 23:43:09 darkstar sshd[295]: error: Bind to port 22 on 0.0.0.0 =
failed: Address already in use.
May 12 23:43:18 darkstar nmbd[309]: [2004/05/12 23:43:18, 0] =
lib/util_sock.c:open_socket_in(646)=20
May 12 23:43:18 darkstar nmbd[309]:   bind failed on port 137 =
socket_addr =3D 192.168.0.2.=20
May 12 23:43:18 darkstar nmbd[309]:   Error =3D Cannot assign requested =
address=20
May 12 23:43:18 darkstar nmbd[309]: [2004/05/12 23:43:18, 0] =
nmbd/nmbd_subnetdb.c:make_subnet(126)=20
May 12 23:43:18 darkstar nmbd[309]: nmbd_subnetdb:make_subnet()=20
May 12 23:43:18 darkstar nmbd[309]:   Failed to open nmb socket on =
interface 192.168.0.2=20
May 12 23:43:18 darkstar nmbd[309]: for port 137. =20
May 12 23:43:18 darkstar nmbd[309]: Error was Cannot assign requested =
address=20
May 12 23:43:18 darkstar nmbd[309]: [2004/05/12 23:43:18, 0] =
nmbd/nmbd.c:main(732)=20
May 12 23:43:18 darkstar nmbd[309]:   ERROR: Failed when creating subnet =
lists. Exiting.=20
May 12 23:43:18 darkstar kernel: bttv0: using tuner=3D33
May 12 23:43:18 darkstar kernel: tda9887: chip found @ 0x86
May 12 23:43:18 darkstar kernel: tuner: chip found at addr 0xc0 i2c-bus =
bt878 #0 [sw]
May 12 23:43:18 darkstar kernel: tuner: type set to 33 (MT20xx =
universal) by bt878 #0 [sw]
May 12 23:43:18 darkstar kernel: tuner: microtune: companycode=3D3cbf =
part=3D42 rev=3D11
May 12 23:43:18 darkstar kernel: tuner: microtune MT2050 found, OK
May 12 23:43:37 darkstar kernel: atkbd.c: Unknown key released =
(translated set 2, code 0x7a on isa0060/serio0).
May 12 23:43:37 darkstar kernel: atkbd.c: This is an XFree86 bug. It =
shouldn't access hardware directly.
May 12 23:43:37 darkstar kernel: atkbd.c: Unknown key released =
(translated set 2, code 0x7a on isa0060/serio0).
May 12 23:43:37 darkstar kernel: atkbd.c: This is an XFree86 bug. It =
shouldn't access hardware directly.


------=_NextPart_000_0000_01C43CC7.177EA230--

