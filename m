Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTEEEqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTEEEqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:46:15 -0400
Received: from 12-251-63-144.client.attbi.com ([12.251.63.144]:16454 "EHLO
	vlad.geekizoid.com") by vger.kernel.org with ESMTP id S261918AbTEEEpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:45:33 -0400
Reply-To: <vlad@geekizoid.com>
From: "Vlad@geekizoid.com" <vlad@geekizoid.com>
To: "Lkml \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Error compiling 2.5.69
Date: Sun, 4 May 2003 23:57:50 -0500
Message-ID: <000701c312c2$e14ab1b0$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0008_01C31298.F874A9B0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C31298.F874A9B0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I get the following error trying to compile 2.5.69.  This is the same =
config as 2.5.68, make with 'make oldconfig' and 'make bzlilo && make =
modules modules_install'.

Config and config.old attached.

Error:
arch/i386/oprofile/init.c: In function `oprofile_arch_init':
arch/i386/oprofile/init.c:25: `ENODEV' undeclared (first use in this =
function)
arch/i386/oprofile/init.c:25: (Each undeclared identifier is reported =
only once
arch/i386/oprofile/init.c:25: for each function it appears in.)
arch/i386/oprofile/init.c:27: warning: control reaches end of non-void =
function
make[1]: *** [arch/i386/oprofile/init.o] Error 1
make: *** [arch/i386/oprofile] Error 2


--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------=


------=_NextPart_000_0008_01C31298.F874A9B0
Content-Type: application/octet-stream;
	name="config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config"

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
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
CONFIG_M586MMX=3Dy=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_PPRO_FENCE=3Dy=0A=
CONFIG_X86_F00F_BUG=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_ALIGNMENT_16=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
# CONFIG_X86_UP_APIC is not set=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_MICROCODE is not set=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
CONFIG_EDD=3Dy=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
# CONFIG_PM is not set=0A=
=0A=
#=0A=
# ACPI Support=0A=
#=0A=
# CONFIG_ACPI is not set=0A=
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
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
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
CONFIG_PNP=3Dy=0A=
CONFIG_PNP_NAMES=3Dy=0A=
CONFIG_PNP_DEBUG=3Dy=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
# CONFIG_ISAPNP is not set=0A=
CONFIG_PNPBIOS=3Dy=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
CONFIG_BLK_DEV_RAM=3Dm=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D7777=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_LBD=3Dy=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL device support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_IDEDISK_STROKE=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
CONFIG_BLK_DEV_IDESCSI=3Dy=0A=
CONFIG_IDE_TASK_IOCTL=3Dy=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
# CONFIG_BLK_DEV_IDEPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDE_TCQ is not set=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
CONFIG_CHR_DEV_ST=3Dy=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
CONFIG_SCSI_REPORT_LUNS=3Dy=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dy=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D64=0A=
CONFIG_AIC7XXX_RESET_DELAY_MS=3D2000=0A=
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set=0A=
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set=0A=
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set=0A=
CONFIG_AIC7XXX_DEBUG_MASK=3D0=0A=
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
CONFIG_SCSI_QLOGIC_1280=3Dy=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
CONFIG_SCSI_DC395x=3Dm=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
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
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
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
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
CONFIG_INET_IPCOMP=3Dm=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_XFRM_USER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
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
CONFIG_DUMMY=3Dy=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dm=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_CS89x0 is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_EEPRO100=3Dy=0A=
# CONFIG_EEPRO100_PIO is not set=0A=
# CONFIG_E100 is not set=0A=
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
# CONFIG_NET_POCKET is not set=0A=
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
CONFIG_IXGB=3Dm=0A=
# CONFIG_IXGB_NAPI is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PPP=3Dy=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dy=0A=
CONFIG_PPP_SYNC_TTY=3Dy=0A=
CONFIG_PPP_DEFLATE=3Dy=0A=
CONFIG_PPP_BSDCOMP=3Dy=0A=
CONFIG_PPPOE=3Dy=0A=
CONFIG_SLIP=3Dy=0A=
CONFIG_SLIP_COMPRESSED=3Dy=0A=
# CONFIG_SLIP_SMART is not set=0A=
# CONFIG_SLIP_MODE_SLIP6 is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices (depends on LLC=3Dy)=0A=
#=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
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
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
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
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_INPORT is not set=0A=
# CONFIG_MOUSE_LOGIBM is not set=0A=
# CONFIG_MOUSE_PC110PAD is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
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
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# I2C Hardware Sensors Mainboard support=0A=
#=0A=
=0A=
#=0A=
# I2C Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_I2C_SENSOR is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
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
# CONFIG_HW_RANDOM is not set=0A=
CONFIG_NVRAM=3Dy=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
CONFIG_AGP_VIA=3Dy=0A=
CONFIG_AGP_AMD=3Dy=0A=
CONFIG_AGP_SIS=3Dy=0A=
CONFIG_AGP_ALI=3Dy=0A=
CONFIG_AGP_SWORKS=3Dy=0A=
# CONFIG_AGP_AMD_8151 is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_R128 is not set=0A=
CONFIG_DRM_RADEON=3Dy=0A=
# CONFIG_DRM_I810 is not set=0A=
# CONFIG_DRM_I830 is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
CONFIG_HANGCHECK_TIMER=3Dm=0A=
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
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
# CONFIG_EXT2_FS_POSIX_ACL is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
CONFIG_JBD=3Dy=0A=
CONFIG_JBD_DEBUG=3Dy=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
CONFIG_REISERFS_FS=3Dy=0A=
CONFIG_REISERFS_CHECK=3Dy=0A=
CONFIG_REISERFS_PROC_INFO=3Dy=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
CONFIG_XFS_FS=3Dy=0A=
# CONFIG_XFS_RT is not set=0A=
# CONFIG_XFS_QUOTA is not set=0A=
# CONFIG_XFS_POSIX_ACL is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_QUOTA=3Dy=0A=
CONFIG_QFMT_V1=3Dm=0A=
CONFIG_QFMT_V2=3Dm=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
CONFIG_UDF_FS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_NTFS_FS=3Dy=0A=
CONFIG_NTFS_DEBUG=3Dy=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
CONFIG_UFS_FS=3Dy=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
# CONFIG_NFS_V4 is not set=0A=
CONFIG_NFSD=3Dy=0A=
# CONFIG_NFSD_V3 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_SUNRPC_GSS is not set=0A=
CONFIG_SMB_FS=3Dy=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
CONFIG_CIFS=3Dy=0A=
CONFIG_NCP_FS=3Dy=0A=
CONFIG_NCPFS_PACKET_SIGNING=3Dy=0A=
CONFIG_NCPFS_IOCTL_LOCKING=3Dy=0A=
CONFIG_NCPFS_STRONG=3Dy=0A=
CONFIG_NCPFS_NFS_NS=3Dy=0A=
CONFIG_NCPFS_OS2_NS=3Dy=0A=
CONFIG_NCPFS_SMALLDOS=3Dy=0A=
CONFIG_NCPFS_NLS=3Dy=0A=
CONFIG_NCPFS_EXTRAS=3Dy=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_BSD_DISKLABEL=3Dy=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
CONFIG_SOLARIS_X86_PARTITION=3Dy=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
CONFIG_LDM_PARTITION=3Dy=0A=
CONFIG_LDM_DEBUG=3Dy=0A=
# CONFIG_NEC98_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
CONFIG_SMB_NLS=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
CONFIG_NLS_CODEPAGE_852=3Dm=0A=
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
CONFIG_NLS_ISO8859_1=3Dy=0A=
CONFIG_NLS_ISO8859_2=3Dm=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dy=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dy=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
# CONFIG_VIDEO_SELECT is not set=0A=
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
CONFIG_SOUND=3Dy=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dy=0A=
CONFIG_SND_SEQUENCER=3Dy=0A=
# CONFIG_SND_SEQ_DUMMY is not set=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dy=0A=
CONFIG_SND_PCM_OSS=3Dy=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
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
# ISA devices=0A=
#=0A=
# CONFIG_SND_AD1848 is not set=0A=
# CONFIG_SND_CS4231 is not set=0A=
# CONFIG_SND_CS4232 is not set=0A=
# CONFIG_SND_CS4236 is not set=0A=
# CONFIG_SND_ES1688 is not set=0A=
# CONFIG_SND_ES18XX is not set=0A=
# CONFIG_SND_GUSCLASSIC is not set=0A=
# CONFIG_SND_GUSEXTREME is not set=0A=
# CONFIG_SND_GUSMAX is not set=0A=
# CONFIG_SND_INTERWAVE is not set=0A=
# CONFIG_SND_INTERWAVE_STB is not set=0A=
# CONFIG_SND_OPTI92X_AD1848 is not set=0A=
# CONFIG_SND_OPTI92X_CS4231 is not set=0A=
# CONFIG_SND_OPTI93X is not set=0A=
# CONFIG_SND_SB8 is not set=0A=
# CONFIG_SND_SB16 is not set=0A=
# CONFIG_SND_SBAWE is not set=0A=
# CONFIG_SND_WAVEFRONT is not set=0A=
# CONFIG_SND_CMI8330 is not set=0A=
# CONFIG_SND_OPL3SA2 is not set=0A=
# CONFIG_SND_SGALAXY is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
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
CONFIG_SND_INTEL8X0=3Dy=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
=0A=
#=0A=
# ALSA USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
CONFIG_SOUND_PRIME=3Dy=0A=
# CONFIG_SOUND_BT878 is not set=0A=
# CONFIG_SOUND_CMPCI is not set=0A=
# CONFIG_SOUND_EMU10K1 is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_CS4281 is not set=0A=
# CONFIG_SOUND_ES1370 is not set=0A=
# CONFIG_SOUND_ES1371 is not set=0A=
# CONFIG_SOUND_ESSSOLO1 is not set=0A=
# CONFIG_SOUND_MAESTRO is not set=0A=
# CONFIG_SOUND_MAESTRO3 is not set=0A=
# CONFIG_SOUND_ICH is not set=0A=
# CONFIG_SOUND_RME96XX is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_MSNDCLAS is not set=0A=
# CONFIG_SOUND_MSNDPIN is not set=0A=
# CONFIG_SOUND_VIA82CXXX is not set=0A=
CONFIG_SOUND_OSS=3Dy=0A=
# CONFIG_SOUND_TRACEINIT is not set=0A=
# CONFIG_SOUND_DMAP is not set=0A=
CONFIG_SOUND_AD1816=3Dy=0A=
# CONFIG_SOUND_SGALAXY is not set=0A=
# CONFIG_SOUND_ADLIB is not set=0A=
# CONFIG_SOUND_ACI_MIXER is not set=0A=
# CONFIG_SOUND_CS4232 is not set=0A=
# CONFIG_SOUND_SSCAPE is not set=0A=
# CONFIG_SOUND_GUS is not set=0A=
# CONFIG_SOUND_VMIDI is not set=0A=
# CONFIG_SOUND_TRIX is not set=0A=
# CONFIG_SOUND_MSS is not set=0A=
# CONFIG_SOUND_MPU401 is not set=0A=
# CONFIG_SOUND_NM256 is not set=0A=
# CONFIG_SOUND_MAD16 is not set=0A=
# CONFIG_SOUND_PAS is not set=0A=
# CONFIG_SOUND_PSS is not set=0A=
# CONFIG_SOUND_SB is not set=0A=
# CONFIG_SOUND_AWE32_SYNTH is not set=0A=
# CONFIG_SOUND_WAVEFRONT is not set=0A=
# CONFIG_SOUND_MAUI is not set=0A=
# CONFIG_SOUND_YM3812 is not set=0A=
# CONFIG_SOUND_OPL3SA1 is not set=0A=
# CONFIG_SOUND_OPL3SA2 is not set=0A=
# CONFIG_SOUND_YMFPCI is not set=0A=
# CONFIG_SOUND_UART6850 is not set=0A=
# CONFIG_SOUND_AEDSP16 is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
CONFIG_USB_BANDWIDTH=3Dy=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_EHCI_HCD=3Dy=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
CONFIG_USB_UHCI_HCD=3Dy=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
CONFIG_USB_STORAGE=3Dy=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_ISD200 is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_HP8200e is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
# CONFIG_USB_HID is not set=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_SCANNER is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
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
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_BRLVGER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
CONFIG_PROFILING=3Dy=0A=
CONFIG_OPROFILE=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_SECURITY=3Dy=0A=
# CONFIG_SECURITY_NETWORK is not set=0A=
CONFIG_SECURITY_CAPABILITIES=3Dy=0A=
CONFIG_SECURITY_ROOTPLUG=3Dy=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dm=0A=
CONFIG_CRYPTO_MD4=3Dm=0A=
CONFIG_CRYPTO_MD5=3Dm=0A=
CONFIG_CRYPTO_SHA1=3Dm=0A=
CONFIG_CRYPTO_SHA256=3Dm=0A=
CONFIG_CRYPTO_SHA512=3Dm=0A=
CONFIG_CRYPTO_DES=3Dm=0A=
CONFIG_CRYPTO_BLOWFISH=3Dm=0A=
CONFIG_CRYPTO_TWOFISH=3Dm=0A=
CONFIG_CRYPTO_SERPENT=3Dm=0A=
CONFIG_CRYPTO_AES=3Dm=0A=
CONFIG_CRYPTO_DEFLATE=3Dm=0A=
CONFIG_CRYPTO_TEST=3Dm=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=

------=_NextPart_000_0008_01C31298.F874A9B0
Content-Type: application/octet-stream;
	name="config.old"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config.old"

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
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
CONFIG_M586MMX=3Dy=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
CONFIG_X86_GENERIC=3Dy=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D7=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_PPRO_FENCE=3Dy=0A=
CONFIG_X86_F00F_BUG=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_ALIGNMENT_16=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
# CONFIG_X86_UP_APIC is not set=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_MICROCODE is not set=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
CONFIG_EDD=3Dy=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
# CONFIG_PM is not set=0A=
=0A=
#=0A=
# ACPI Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_AC=3Dy=0A=
CONFIG_ACPI_BATTERY=3Dy=0A=
CONFIG_ACPI_BUTTON=3Dy=0A=
CONFIG_ACPI_FAN=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
CONFIG_ACPI_DEBUG=3Dy=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
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
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dy=0A=
CONFIG_PARPORT_PC=3Dy=0A=
CONFIG_PARPORT_PC_CML1=3Dy=0A=
# CONFIG_PARPORT_SERIAL is not set=0A=
# CONFIG_PARPORT_PC_FIFO is not set=0A=
# CONFIG_PARPORT_PC_SUPERIO is not set=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
CONFIG_PNP_NAMES=3Dy=0A=
CONFIG_PNP_DEBUG=3Dy=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
# CONFIG_ISAPNP is not set=0A=
# CONFIG_PNPBIOS is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
CONFIG_BLK_DEV_RAM=3Dm=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D7777=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_LBD=3Dy=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL device support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_IDEDISK_STROKE=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
CONFIG_BLK_DEV_IDESCSI=3Dy=0A=
CONFIG_IDE_TASK_IOCTL=3Dy=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
# CONFIG_BLK_DEV_IDEPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDE_TCQ is not set=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
CONFIG_CHR_DEV_ST=3Dy=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
CONFIG_SCSI_REPORT_LUNS=3Dy=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dy=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D64=0A=
CONFIG_AIC7XXX_RESET_DELAY_MS=3D2000=0A=
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set=0A=
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set=0A=
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set=0A=
CONFIG_AIC7XXX_DEBUG_MASK=3D0=0A=
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
CONFIG_SCSI_QLOGIC_1280=3Dy=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
CONFIG_SCSI_DC395x=3Dm=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
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
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
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
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
CONFIG_INET_IPCOMP=3Dm=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_XFRM_USER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
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
CONFIG_DUMMY=3Dy=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dm=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_CS89x0 is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_EEPRO100=3Dy=0A=
# CONFIG_EEPRO100_PIO is not set=0A=
# CONFIG_E100 is not set=0A=
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
# CONFIG_NET_POCKET is not set=0A=
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
CONFIG_IXGB=3Dm=0A=
# CONFIG_IXGB_NAPI is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PLIP=3Dy=0A=
CONFIG_PPP=3Dy=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dy=0A=
CONFIG_PPP_SYNC_TTY=3Dy=0A=
CONFIG_PPP_DEFLATE=3Dy=0A=
CONFIG_PPP_BSDCOMP=3Dy=0A=
CONFIG_PPPOE=3Dy=0A=
CONFIG_SLIP=3Dy=0A=
CONFIG_SLIP_COMPRESSED=3Dy=0A=
# CONFIG_SLIP_SMART is not set=0A=
# CONFIG_SLIP_MODE_SLIP6 is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices (depends on LLC=3Dy)=0A=
#=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
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
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
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
# CONFIG_SERIO_PARKBD is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_INPORT is not set=0A=
# CONFIG_MOUSE_LOGIBM is not set=0A=
# CONFIG_MOUSE_PC110PAD is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
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
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
CONFIG_PRINTER=3Dy=0A=
# CONFIG_LP_CONSOLE is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# I2C Hardware Sensors Mainboard support=0A=
#=0A=
=0A=
#=0A=
# I2C Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_I2C_SENSOR is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
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
# CONFIG_HW_RANDOM is not set=0A=
CONFIG_NVRAM=3Dy=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
CONFIG_AGP_VIA=3Dy=0A=
CONFIG_AGP_AMD=3Dy=0A=
CONFIG_AGP_SIS=3Dy=0A=
CONFIG_AGP_ALI=3Dy=0A=
CONFIG_AGP_SWORKS=3Dy=0A=
# CONFIG_AGP_AMD_8151 is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_R128 is not set=0A=
CONFIG_DRM_RADEON=3Dy=0A=
# CONFIG_DRM_I810 is not set=0A=
# CONFIG_DRM_I830 is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
CONFIG_HANGCHECK_TIMER=3Dm=0A=
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
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
# CONFIG_EXT2_FS_POSIX_ACL is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
CONFIG_REISERFS_FS=3Dy=0A=
CONFIG_REISERFS_CHECK=3Dy=0A=
CONFIG_REISERFS_PROC_INFO=3Dy=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_QUOTA=3Dy=0A=
CONFIG_QFMT_V1=3Dm=0A=
CONFIG_QFMT_V2=3Dm=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
CONFIG_UDF_FS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_NTFS_FS=3Dy=0A=
CONFIG_NTFS_DEBUG=3Dy=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
CONFIG_UFS_FS=3Dy=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
# CONFIG_NFS_V4 is not set=0A=
CONFIG_NFSD=3Dy=0A=
# CONFIG_NFSD_V3 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_SUNRPC_GSS is not set=0A=
CONFIG_SMB_FS=3Dy=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
CONFIG_CIFS=3Dy=0A=
CONFIG_NCP_FS=3Dy=0A=
CONFIG_NCPFS_PACKET_SIGNING=3Dy=0A=
CONFIG_NCPFS_IOCTL_LOCKING=3Dy=0A=
CONFIG_NCPFS_STRONG=3Dy=0A=
CONFIG_NCPFS_NFS_NS=3Dy=0A=
CONFIG_NCPFS_OS2_NS=3Dy=0A=
CONFIG_NCPFS_SMALLDOS=3Dy=0A=
CONFIG_NCPFS_NLS=3Dy=0A=
CONFIG_NCPFS_EXTRAS=3Dy=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_BSD_DISKLABEL=3Dy=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
CONFIG_SOLARIS_X86_PARTITION=3Dy=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
CONFIG_LDM_PARTITION=3Dy=0A=
CONFIG_LDM_DEBUG=3Dy=0A=
# CONFIG_NEC98_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
CONFIG_SMB_NLS=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
CONFIG_NLS_CODEPAGE_852=3Dm=0A=
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
CONFIG_NLS_ISO8859_1=3Dy=0A=
CONFIG_NLS_ISO8859_2=3Dm=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dy=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
# CONFIG_VIDEO_SELECT is not set=0A=
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
CONFIG_SOUND=3Dy=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dy=0A=
CONFIG_SND_SEQUENCER=3Dy=0A=
# CONFIG_SND_SEQ_DUMMY is not set=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dy=0A=
CONFIG_SND_PCM_OSS=3Dy=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
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
# ISA devices=0A=
#=0A=
# CONFIG_SND_AD1848 is not set=0A=
# CONFIG_SND_CS4231 is not set=0A=
# CONFIG_SND_CS4232 is not set=0A=
# CONFIG_SND_CS4236 is not set=0A=
# CONFIG_SND_ES1688 is not set=0A=
# CONFIG_SND_ES18XX is not set=0A=
# CONFIG_SND_GUSCLASSIC is not set=0A=
# CONFIG_SND_GUSEXTREME is not set=0A=
# CONFIG_SND_GUSMAX is not set=0A=
# CONFIG_SND_INTERWAVE is not set=0A=
# CONFIG_SND_INTERWAVE_STB is not set=0A=
# CONFIG_SND_OPTI92X_AD1848 is not set=0A=
# CONFIG_SND_OPTI92X_CS4231 is not set=0A=
# CONFIG_SND_OPTI93X is not set=0A=
# CONFIG_SND_SB8 is not set=0A=
# CONFIG_SND_SB16 is not set=0A=
# CONFIG_SND_SBAWE is not set=0A=
# CONFIG_SND_WAVEFRONT is not set=0A=
# CONFIG_SND_CMI8330 is not set=0A=
# CONFIG_SND_OPL3SA2 is not set=0A=
# CONFIG_SND_SGALAXY is not set=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
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
CONFIG_SND_INTEL8X0=3Dy=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
=0A=
#=0A=
# ALSA USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
CONFIG_SOUND_PRIME=3Dy=0A=
# CONFIG_SOUND_BT878 is not set=0A=
# CONFIG_SOUND_CMPCI is not set=0A=
# CONFIG_SOUND_EMU10K1 is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_CS4281 is not set=0A=
# CONFIG_SOUND_ES1370 is not set=0A=
# CONFIG_SOUND_ES1371 is not set=0A=
# CONFIG_SOUND_ESSSOLO1 is not set=0A=
# CONFIG_SOUND_MAESTRO is not set=0A=
# CONFIG_SOUND_MAESTRO3 is not set=0A=
# CONFIG_SOUND_ICH is not set=0A=
# CONFIG_SOUND_RME96XX is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_MSNDCLAS is not set=0A=
# CONFIG_SOUND_MSNDPIN is not set=0A=
# CONFIG_SOUND_VIA82CXXX is not set=0A=
CONFIG_SOUND_OSS=3Dy=0A=
# CONFIG_SOUND_TRACEINIT is not set=0A=
# CONFIG_SOUND_DMAP is not set=0A=
CONFIG_SOUND_AD1816=3Dy=0A=
# CONFIG_SOUND_SGALAXY is not set=0A=
# CONFIG_SOUND_ADLIB is not set=0A=
# CONFIG_SOUND_ACI_MIXER is not set=0A=
# CONFIG_SOUND_CS4232 is not set=0A=
# CONFIG_SOUND_SSCAPE is not set=0A=
# CONFIG_SOUND_GUS is not set=0A=
# CONFIG_SOUND_VMIDI is not set=0A=
# CONFIG_SOUND_TRIX is not set=0A=
# CONFIG_SOUND_MSS is not set=0A=
# CONFIG_SOUND_MPU401 is not set=0A=
# CONFIG_SOUND_NM256 is not set=0A=
# CONFIG_SOUND_MAD16 is not set=0A=
# CONFIG_SOUND_PAS is not set=0A=
# CONFIG_SOUND_PSS is not set=0A=
# CONFIG_SOUND_SB is not set=0A=
# CONFIG_SOUND_AWE32_SYNTH is not set=0A=
# CONFIG_SOUND_WAVEFRONT is not set=0A=
# CONFIG_SOUND_MAUI is not set=0A=
# CONFIG_SOUND_YM3812 is not set=0A=
# CONFIG_SOUND_OPL3SA1 is not set=0A=
# CONFIG_SOUND_OPL3SA2 is not set=0A=
# CONFIG_SOUND_YMFPCI is not set=0A=
# CONFIG_SOUND_UART6850 is not set=0A=
# CONFIG_SOUND_AEDSP16 is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
CONFIG_USB_BANDWIDTH=3Dy=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_EHCI_HCD=3Dy=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
CONFIG_USB_UHCI_HCD=3Dy=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
CONFIG_USB_STORAGE=3Dy=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_ISD200 is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_HP8200e is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
# CONFIG_USB_HID is not set=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_SCANNER is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
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
# CONFIG_USB_USS720 is not set=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_BRLVGER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
CONFIG_PROFILING=3Dy=0A=
CONFIG_OPROFILE=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_SECURITY=3Dy=0A=
# CONFIG_SECURITY_NETWORK is not set=0A=
CONFIG_SECURITY_CAPABILITIES=3Dy=0A=
CONFIG_SECURITY_ROOTPLUG=3Dy=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dm=0A=
CONFIG_CRYPTO_MD4=3Dm=0A=
CONFIG_CRYPTO_MD5=3Dm=0A=
CONFIG_CRYPTO_SHA1=3Dm=0A=
CONFIG_CRYPTO_SHA256=3Dm=0A=
CONFIG_CRYPTO_SHA512=3Dm=0A=
CONFIG_CRYPTO_DES=3Dm=0A=
CONFIG_CRYPTO_BLOWFISH=3Dm=0A=
CONFIG_CRYPTO_TWOFISH=3Dm=0A=
CONFIG_CRYPTO_SERPENT=3Dm=0A=
CONFIG_CRYPTO_AES=3Dm=0A=
CONFIG_CRYPTO_DEFLATE=3Dm=0A=
CONFIG_CRYPTO_TEST=3Dm=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=

------=_NextPart_000_0008_01C31298.F874A9B0--


