Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJIJGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJIJGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUJIJGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:06:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:52675 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266603AbUJIJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:05:34 -0400
From: =?iso-8859-1?Q?Sven_L=FCppken?= <sven@slueppken.de>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9-rc3-mm3 boot failure
Date: Sat, 9 Oct 2004 11:05:37 +0200
Message-ID: <IAEBLGJPKLBIFOFDIIMCCEDDCBAA.sven@slueppken.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0009_01C4ADEF.E7EDB200"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e856fb27c8b2307bc265ceb037e68242
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C4ADEF.E7EDB200
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi everybody,

I compiled the linux 2.6.9-rc3-mm3 kernel successfully (config attached) and
wanted to boot it but after a few moments it stops booting. Only a hard
reset helps.
It works till the line

PCI: Via IRQ fixup for 0000:0010.1, from 0 to 5

then it just stops and nothing more happens.

I think something related to USB comes afterwards, comparing the booting
with an older
kernel. I don't know what happens and I don't really know how to debug it,
as I never debugged a kernel
before so every help is welcome.

I use Gentoo Linux, gcc 3.4.2, reiser4 and udev.

Kind regards,
Sven Lüppken
Student at the University of Applied
Sciences Suedwestfalen Germany

------=_NextPart_000_0009_01C4ADEF.E7EDB200
Content-Type: application/octet-stream;
	name="config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.9-rc3-mm3=0A=
# Sat Oct  9 10:03:01 2004=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
CONFIG_GENERIC_IOMAP=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT_V3 is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_AUDIT=3Dy=0A=
CONFIG_AUDITSYSCALL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
# CONFIG_IKCONFIG is not set=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dm=0A=
CONFIG_IOSCHED_CFQ=3Dm=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_SHMEM=3Dy=0A=
# CONFIG_TINY_SHMEM is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
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
# CONFIG_SMP is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
# CONFIG_PREEMPT_BKL is not set=0A=
CONFIG_X86_UP_APIC=3Dy=0A=
CONFIG_X86_UP_IOAPIC=3Dy=0A=
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
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
# CONFIG_REGPARM is not set=0A=
=0A=
#=0A=
# Performance-monitoring counters support=0A=
#=0A=
# CONFIG_PERFCTR is not set=0A=
# CONFIG_KEXEC is not set=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_PM_DEBUG is not set=0A=
CONFIG_SOFTWARE_SUSPEND=3Dy=0A=
CONFIG_PM_STD_PARTITION=3D"/dev/hdb2"=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
CONFIG_ACPI_SLEEP=3Dy=0A=
CONFIG_ACPI_SLEEP_PROC_FS=3Dy=0A=
CONFIG_ACPI_AC=3Dy=0A=
CONFIG_ACPI_BATTERY=3Dy=0A=
CONFIG_ACPI_BUTTON=3Dy=0A=
CONFIG_ACPI_FAN=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_THINKPAD is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
CONFIG_ACPI_BLACKLIST_YEAR=3D0=0A=
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
CONFIG_APM=3Dm=0A=
# CONFIG_APM_IGNORE_USER_SUSPEND is not set=0A=
# CONFIG_APM_DO_ENABLE is not set=0A=
# CONFIG_APM_CPU_IDLE is not set=0A=
# CONFIG_APM_DISPLAY_BLANK is not set=0A=
# CONFIG_APM_RTC_IS_GMT is not set=0A=
# CONFIG_APM_ALLOW_INTS is not set=0A=
# CONFIG_APM_REAL_MODE_POWER_OFF is not set=0A=
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
# CONFIG_PCI_MSI is not set=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
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
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
CONFIG_FW_LOADER=3Dm=0A=
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
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
# CONFIG_BLK_DEV_CRYPTOLOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
# CONFIG_BLK_DEV_UB is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
# CONFIG_LBD is not set=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
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
# CONFIG_BLK_DEV_IDE_SATA is not set=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_BLK_DEV_IDESCSI is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_IDE_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
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
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
CONFIG_BLK_DEV_VIA82CXXX=3Dy=0A=
# CONFIG_IDE_ARM is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
CONFIG_SCSI_PROC_FS=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
# CONFIG_BLK_DEV_SR is not set=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI Transport Attributes=0A=
#=0A=
# CONFIG_SCSI_SPI_ATTRS is not set=0A=
# CONFIG_SCSI_FC_ATTRS is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_3W_9XXX is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_MEGARAID_NEWGEN is not set=0A=
# CONFIG_MEGARAID_LEGACY is not set=0A=
# CONFIG_SCSI_SATA is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_IPR is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_QLOGIC_1280_1040 is not set=0A=
CONFIG_SCSI_QLA2XXX=3Dy=0A=
# CONFIG_SCSI_QLA21XX is not set=0A=
# CONFIG_SCSI_QLA22XX is not set=0A=
# CONFIG_SCSI_QLA2300 is not set=0A=
# CONFIG_SCSI_QLA2322 is not set=0A=
# CONFIG_SCSI_QLA6312 is not set=0A=
# CONFIG_SCSI_QLA6322 is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
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
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
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
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dy=0A=
# CONFIG_IP_NF_CT_ACCT is not set=0A=
# CONFIG_IP_NF_CT_PROTO_SCTP is not set=0A=
# CONFIG_IP_NF_FTP is not set=0A=
# CONFIG_IP_NF_IRC is not set=0A=
# CONFIG_IP_NF_TFTP is not set=0A=
# CONFIG_IP_NF_AMANDA is not set=0A=
CONFIG_IP_NF_QUEUE=3Dy=0A=
CONFIG_IP_NF_IPTABLES=3Dy=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dy=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dy=0A=
CONFIG_IP_NF_MATCH_MAC=3Dy=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy=0A=
CONFIG_IP_NF_MATCH_MARK=3Dy=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy=0A=
CONFIG_IP_NF_MATCH_TOS=3Dy=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dy=0A=
CONFIG_IP_NF_MATCH_ECN=3Dy=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dy=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dy=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dy=0A=
CONFIG_IP_NF_MATCH_TTL=3Dy=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dy=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dy=0A=
CONFIG_IP_NF_MATCH_STATE=3Dy=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dy=0A=
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set=0A=
# CONFIG_IP_NF_MATCH_REALM is not set=0A=
# CONFIG_IP_NF_MATCH_SCTP is not set=0A=
# CONFIG_IP_NF_MATCH_COMMENT is not set=0A=
CONFIG_IP_NF_FILTER=3Dy=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dy=0A=
CONFIG_IP_NF_TARGET_LOG=3Dy=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dy=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dy=0A=
CONFIG_IP_NF_NAT=3Dy=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dy=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dy=0A=
CONFIG_IP_NF_TARGET_SAME=3Dy=0A=
# CONFIG_IP_NF_NAT_LOCAL is not set=0A=
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set=0A=
CONFIG_IP_NF_MANGLE=3Dy=0A=
CONFIG_IP_NF_TARGET_TOS=3Dy=0A=
CONFIG_IP_NF_TARGET_ECN=3Dy=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dy=0A=
CONFIG_IP_NF_TARGET_MARK=3Dy=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dy=0A=
CONFIG_IP_NF_RAW=3Dm=0A=
CONFIG_IP_NF_TARGET_NOTRACK=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dy=0A=
CONFIG_IP_NF_ARPFILTER=3Dy=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dy=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_KGDBOE is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NETPOLL_RX is not set=0A=
# CONFIG_NETPOLL_TRAP is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
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
# CONFIG_E100 is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
CONFIG_NE2K_PCI=3Dm=0A=
# CONFIG_8139CP is not set=0A=
CONFIG_8139TOO=3Dm=0A=
CONFIG_8139TOO_PIO=3Dy=0A=
# CONFIG_8139TOO_TUNE_TWISTER is not set=0A=
# CONFIG_8139TOO_8129 is not set=0A=
# CONFIG_8139_OLD_RX_RESET is not set=0A=
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
# CONFIG_VIA_VELOCITY is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
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
# CONFIG_SERIO_PARKBD is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
CONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A=
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
# CONFIG_INPUT_MOUSE is not set=0A=
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
# CONFIG_SERIAL_8250_ACPI is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_LEGACY_PTYS=3Dy=0A=
CONFIG_LEGACY_PTY_COUNT=3D256=0A=
CONFIG_PRINTER=3Dy=0A=
# CONFIG_LP_CONSOLE is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
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
# CONFIG_NVRAM is not set=0A=
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
# CONFIG_AGP_ALI is not set=0A=
# CONFIG_AGP_ATI is not set=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_AMD64 is not set=0A=
# CONFIG_AGP_INTEL is not set=0A=
# CONFIG_AGP_INTEL_MCH is not set=0A=
# CONFIG_AGP_NVIDIA is not set=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_SWORKS is not set=0A=
CONFIG_AGP_VIA=3Dy=0A=
# CONFIG_AGP_EFFICEON is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
# CONFIG_HPET is not set=0A=
CONFIG_HANGCHECK_TIMER=3Dy=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
CONFIG_VIDEO_DEV=3Dm=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
=0A=
#=0A=
# Video Adapters=0A=
#=0A=
# CONFIG_VIDEO_BWQCAM is not set=0A=
# CONFIG_VIDEO_CQCAM is not set=0A=
# CONFIG_VIDEO_W9966 is not set=0A=
# CONFIG_VIDEO_CPIA is not set=0A=
# CONFIG_VIDEO_STRADIS is not set=0A=
# CONFIG_VIDEO_MXB is not set=0A=
# CONFIG_VIDEO_DPC is not set=0A=
# CONFIG_VIDEO_HEXIUM_ORION is not set=0A=
# CONFIG_VIDEO_HEXIUM_GEMINI is not set=0A=
=0A=
#=0A=
# Radio Adapters=0A=
#=0A=
# CONFIG_RADIO_GEMTEK_PCI is not set=0A=
# CONFIG_RADIO_MAXIRADIO is not set=0A=
# CONFIG_RADIO_MAESTRO is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
CONFIG_FB=3Dy=0A=
CONFIG_FB_MODE_HELPERS=3Dy=0A=
# CONFIG_FB_TILEBLITTING is not set=0A=
# CONFIG_FB_CIRRUS is not set=0A=
# CONFIG_FB_PM2 is not set=0A=
# CONFIG_FB_CYBER2000 is not set=0A=
# CONFIG_FB_ASILIANT is not set=0A=
# CONFIG_FB_IMSTT is not set=0A=
CONFIG_FB_VGA16=3Dy=0A=
CONFIG_FB_VESA=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_FB_HGA is not set=0A=
# CONFIG_FB_RIVA is not set=0A=
# CONFIG_FB_I810 is not set=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_RADEON_OLD is not set=0A=
# CONFIG_FB_RADEON is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
# CONFIG_FB_ATY is not set=0A=
# CONFIG_FB_SIS is not set=0A=
# CONFIG_FB_NEOMAGIC is not set=0A=
# CONFIG_FB_KYRO is not set=0A=
# CONFIG_FB_3DFX is not set=0A=
# CONFIG_FB_VOODOO1 is not set=0A=
# CONFIG_FB_TRIDENT is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
# CONFIG_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
=0A=
#=0A=
# Logo configuration=0A=
#=0A=
CONFIG_LOGO=3Dy=0A=
CONFIG_LOGO_LINUX_MONO=3Dy=0A=
CONFIG_LOGO_LINUX_VGA16=3Dy=0A=
CONFIG_LOGO_LINUX_CLUT224=3Dy=0A=
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
CONFIG_SND_TIMER=3Dy=0A=
CONFIG_SND_PCM=3Dy=0A=
CONFIG_SND_HWDEP=3Dm=0A=
CONFIG_SND_RAWMIDI=3Dm=0A=
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
# PCI devices=0A=
#=0A=
CONFIG_SND_AC97_CODEC=3Dm=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_ATIIXP_MODEM is not set=0A=
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
# USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
# CONFIG_SND_USB_USX2Y is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
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
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
# CONFIG_USB_SUSPEND is not set=0A=
# CONFIG_USB_OTG is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_EHCI_HCD=3Dy=0A=
# CONFIG_USB_EHCI_SPLIT_ISO is not set=0A=
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set=0A=
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
# CONFIG_USB_STORAGE_RW_DETECT is not set=0A=
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
CONFIG_USB_HID=3Dy=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_EGALAX is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
# CONFIG_USB_VICAM is not set=0A=
# CONFIG_USB_DSBR is not set=0A=
# CONFIG_USB_IBMCAM is not set=0A=
# CONFIG_USB_KONICAWC is not set=0A=
CONFIG_USB_OV511=3Dm=0A=
# CONFIG_USB_SE401 is not set=0A=
# CONFIG_USB_SN9C102 is not set=0A=
# CONFIG_USB_STV680 is not set=0A=
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
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_PHIDGETSERVO is not set=0A=
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
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
CONFIG_REISER4_FS=3Dy=0A=
CONFIG_REISER4_LARGE_KEY=3Dy=0A=
# CONFIG_REISER4_CHECK is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
CONFIG_MINIX_FS=3Dm=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# Caches=0A=
#=0A=
# CONFIG_FSCACHE is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
CONFIG_UDF_FS=3Dy=0A=
CONFIG_UDF_NLS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_FAT_DEFAULT_CODEPAGE=3D437=0A=
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-15"=0A=
CONFIG_NTFS_FS=3Dm=0A=
# CONFIG_NTFS_DEBUG is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
# CONFIG_DEVFS_MOUNT is not set=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_TMPFS_XATTR is not set=0A=
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
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
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
CONFIG_NLS_DEFAULT=3D"iso8859-15"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
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
# CONFIG_NLS_ASCII is not set=0A=
CONFIG_NLS_ISO8859_1=3Dy=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
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
CONFIG_DEBUG_PREEMPT=3Dy=0A=
# CONFIG_FRAME_POINTER is not set=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
# CONFIG_4KSTACKS is not set=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC_CCITT is not set=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_LIBCRC32C=3Dm=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_PC=3Dy=0A=

------=_NextPart_000_0009_01C4ADEF.E7EDB200--

