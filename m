Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFTHvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFTHvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVFTHvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:51:22 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:39623 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261482AbVFTHrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:47:06 -0400
Message-ID: <42B6746B.4020305@ens-lyon.org>
Date: Mon, 20 Jun 2005 09:46:51 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090003050603050605020801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003050603050605020801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 20.06.2005 08:30, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> 
> - Nothing particularly special here - various fixes and updates.

Hi Andrew,

My laptop (compaq evo n600c) crashes during boot right after this
(copied by hand)

Yenta: CardBus bridge found at 0000:02:03.0 [0e11:004e]
yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: no resource of type 1200 available, trying to
continue...
yenta 0000:02:03.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 3 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 3 busy, reconfiguring...
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta TI: socket 0000:02:03.0 mfunc 0x01001002, devctl 0x64
Yenta: ISA IRQ mask 0x04f0, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: <- stopped here

Even SysRq doesn't work then.

The original dmesg from 2.6.12 (if you want to compare), my config for
this -mm and lspci are attached.

Regards,
Brice

--------------090003050603050605020801
Content-Type: text/plain;
 name="config-2.6.12-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.12-mm1"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-mm1
# Mon Jun 20 08:48:28 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="=LoulousMobile"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
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
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_KEXEC=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda4"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m

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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

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
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_FAKE=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

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
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_FORK_CONNECTOR=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
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
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
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
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_ITERAID is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
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
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
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
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

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
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_SCALABLE=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_IPRANGE is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
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

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_BT is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

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
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
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
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IPW2100=m
CONFIG_IPW2100_PROMISC=y
# CONFIG_IPW_DEBUG is not set
CONFIG_IPW2200=m
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_PCI_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_HOSTAP=m
CONFIG_HOSTAP_WEP=m
CONFIG_HOSTAP_TKIP=m
CONFIG_HOSTAP_CCMP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m

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
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

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
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
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
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_CONFIG_TUNER_MULTI_I2C is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_STRADIS is not set
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
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SOFT_CURSOR=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_7x14=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
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
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
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
CONFIG_SND_MAESTRO3=m
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

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
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_PWC is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=m

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_AIRPRIME is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Distributed Lock Manager
#
CONFIG_DLM=m
CONFIG_DLM_DEVICE=m
# CONFIG_DLM_DEBUG is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
CONFIG_OCFS2_FS=m
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_CACHEFS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=850
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m
CONFIG_RELAYFS_FS=m

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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-15"
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
# CONFIG_NLS_ASCII is not set
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
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------090003050603050605020801
Content-Type: text/plain;
 name="dmesg-2.6.12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.12"

[4294667.296000] Linux version 2.6.12=LoulousMobile (bgoglin@puligny) (version gcc 3.3.5 (Debian 1:3.3.5-13)) #2 Sat Jun 18 18:28:55 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 0000000027fd0000 (usable)
[4294667.296000]  BIOS-e820: 0000000027fd0000 - 0000000027ff0c00 (reserved)
[4294667.296000]  BIOS-e820: 0000000027ff0c00 - 0000000027ffc000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 0000000027ffc000 - 0000000028000000 (reserved)
[4294667.296000] 639MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 163792
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 159696 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f9970
[4294667.296000] ACPI: RSDT (v001 COMPAQ CPQ0030  0x31120320 CPQ  0x00000001) @ 0x27ff0c84
[4294667.296000] ACPI: FADT (v002 COMPAQ CPQ0030  0x00000002 CPQ  0x00000001) @ 0x27ff0c00
[4294667.296000] ACPI: SSDT (v001 COMPAQ   CPQCPU 0x00001001 MSFT 0x0100000e) @ 0x27ff7bcb
[4294667.296000] ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x27ff7c16
[4294667.296000] ACPI: DSDT (v001 COMPAQ EVON600C 0x00010000 MSFT 0x0100000e) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x1008
[4294667.296000] Allocating PCI resources starting at 28000000 (gap: 28000000:d8000000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda2 ro single
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (01502000)
[4294667.296000] Initializing CPU#0
[4294667.296000] CPU 0 irqstacks, hard=c048b000 soft=c048a000
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 730.943 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294669.773000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294669.775000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294669.815000] Memory: 644768k/655168k available (2238k kernel code, 9880k reserved, 1175k data, 184k init, 0k highmem)
[4294669.815000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294669.816000] Calibrating delay loop... 1449.98 BogoMIPS (lpj=724992)
[4294669.838000] Mount-cache hash table entries: 512
[4294669.838000] CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[4294669.838000] CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[4294669.838000] CPU: L1 I cache: 16K, L1 D cache: 16K
[4294669.838000] CPU: L2 cache: 512K
[4294669.838000] CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
[4294669.838000] Intel machine check architecture supported.
[4294669.838000] Intel machine check reporting enabled on CPU#0.
[4294669.838000] CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
[4294669.838000] Enabling fast FPU save and restore... done.
[4294669.838000] Enabling unmasked SIMD FPU exception support... done.
[4294669.838000] Checking 'hlt' instruction... OK.
[4294669.843000]  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
[4294670.009000] Parsing all Control Methods:..........................................................................................................................................................................................................................................................................
[4294670.435000] Table [DSDT](id F006) - 833 Objects with 89 Devices 266 Methods 26 Regions
[4294670.436000] Parsing all Control Methods:.
[4294670.437000] Table [SSDT](id F003) - 3 Objects with 0 Devices 1 Methods 0 Regions
[4294670.439000] Parsing all Control Methods:..
[4294670.442000] Table [SSDT](id F004) - 4 Objects with 0 Devices 2 Methods 0 Regions
[4294670.442000] ACPI Namespace successfully loaded at root c04be5e0
[4294670.442000] ACPI: setting ELCR to 0200 (from 0800)
[4294670.504000] evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
[4294670.505000] NET: Registered protocol family 16
[4294670.506000] PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=4
[4294670.506000] PCI: Using configuration type 1
[4294670.506000] mtrr: v2.0 (20020519)
[4294670.507000] ACPI: Subsystem revision 20050309
[4294670.511000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lxx or _Exx)
[4294670.511000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lxx or _Exx)
[4294670.511000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lxx or _Exx)
[4294670.523000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[4294670.523000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 1 Runtime GPEs in this block
[4294670.524000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lxx or _Exx)
[4294670.524000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lxx or _Exx)
[4294670.524000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lxx or _Exx)
[4294670.529000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
[4294670.529000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 2 Wake, Enabled 5 Runtime GPEs in this block
[4294670.559000] Completing Region/Field/Buffer/Package initialization:..................................................................................................
[4294670.699000] Initialized 25/26 Regions 0/0 Fields 26/26 Buffers 47/56 Packages (849 nodes)
[4294670.699000] Executing all Device _STA and_INI methods:...........................................................................................
[4294671.585000] 91 Devices found containing: 91 _STA, 8 _INI methods
[4294671.585000] ACPI: Interpreter enabled
[4294671.585000] ACPI: Using PIC for interrupt routing
[4294671.590000] ACPI: PCI Root Bridge [C03E] (0000:00)
[4294671.590000] PCI: Probing PCI hardware (bus 00)
[4294671.591000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[4294671.591000] Boot video device is 0000:01:00.0
[4294671.591000] PCI: Transparent bridge - 0000:00:1e.0
[4294671.593000] ACPI: PCI Interrupt Routing Table [\_SB_.C03E._PRT]
[4294671.602000] ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C03F._PRT]
[4294671.609000] ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C052._PRT]
[4294671.721000] ACPI: Power Resource [C14E] (on)
[4294671.808000] ACPI: Power Resource [C167] (on)
[4294671.888000] ACPI: Power Resource [C16B] (on)
[4294671.897000] ACPI: Power Resource [C174] (on)
[4294671.947000] ACPI: PCI Interrupt Link [C0BA] (IRQs 5 10 *11)
[4294671.972000] ACPI: PCI Interrupt Link [C0BB] (IRQs 5 10 *11)
[4294671.996000] ACPI: PCI Interrupt Link [C0BC] (IRQs 5 10 *11)
[4294672.021000] ACPI: PCI Interrupt Link [C0BD] (IRQs 5 10 *11)
[4294672.046000] ACPI: PCI Interrupt Link [C0BE] (IRQs 5 10 *11)
[4294672.071000] ACPI: PCI Interrupt Link [C0BF] (IRQs 5 10 *11)
[4294672.095000] ACPI: PCI Interrupt Link [C0C0] (IRQs 5 10 *11)
[4294672.119000] ACPI: PCI Interrupt Link [C0C1] (IRQs 5 10 11) *0, disabled.
[4294672.188000] ACPI: Power Resource [C1F3] (off)
[4294672.194000] ACPI: Power Resource [C1F4] (off)
[4294672.199000] ACPI: Power Resource [C1F5] (off)
[4294672.205000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294672.205000] pnp: PnP ACPI init
[4294672.803000] pnp: PnP ACPI: found 14 devices
[4294672.803000] PnPBIOS: Disabled by ACPI PNP
[4294672.803000] SCSI subsystem initialized
[4294672.803000] PCI: Using ACPI for IRQ routing
[4294672.803000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294672.919000] pnp: 00:0b: ioport range 0x140-0x14f has been reserved
[4294672.919000] pnp: 00:0c: ioport range 0x4d0-0x4d1 has been reserved
[4294672.919000] pnp: 00:0c: ioport range 0x1000-0x1087 could not be reserved
[4294672.919000] pnp: 00:0c: ioport range 0x1100-0x113f has been reserved
[4294672.919000] pnp: 00:0c: ioport range 0x1200-0x121f has been reserved
[4294672.919000] Machine check exception polling timer started.
[4294672.920000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294672.920000] apm: overridden by ACPI.
[4294672.922000] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[4294672.922000] devfs: boot_options: 0x0
[4294672.922000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[4294672.922000] fakephp: Fake PCI Hot Plug Controller Driver
[4294672.922000] cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
[4294672.937000] ACPI: PCI Interrupt Link [C0BB] enabled at IRQ 11
[4294672.937000] PCI: setting IRQ 11 as level-triggered
[4294672.937000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0BB] -> GSI 11 (level, low) -> IRQ 11
[4294672.943000] radeonfb: Retreived PLL infos from BIOS
[4294672.943000] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=166.00 Mhz, System=166.00 MHz
[4294672.943000] radeonfb: PLL min 12000 max 35000
[4294672.943000] Non-DDC laptop panel detected
[4294672.974000] radeonfb: Monitor 1 type LCD found
[4294672.974000] radeonfb: Monitor 2 type no found
[4294672.974000] radeonfb: panel ID string: 1024x768                
[4294672.974000] radeonfb: detected LVDS panel size from BIOS: 1024x768
[4294672.974000] radeondb: BIOS provided dividers will be used
[4294673.116000] radeonfb: Dynamic Clock Power Management enabled
[4294673.470000] Console: switching to colour frame buffer device 128x48
[4294673.470000] radeonfb (0000:01:00.0): ATI Radeon LY 
[4294673.475000] ACPI: AC Adapter [C1A2] (off-line)
[4294674.663000] ACPI: Battery Slot [C19F] (battery present)
[4294674.669000] ACPI: Battery Slot [C1A0] (battery absent)
[4294674.669000] ACPI: Power Button (FF) [PWRF]
[4294674.669000] ACPI: Sleep Button (CM) [C1A3]
[4294674.669000] ACPI: Lid Switch [C1A4]
[4294674.673000] ACPI: Fan [C1F6] (off)
[4294674.677000] ACPI: Fan [C1F7] (off)
[4294674.680000] ACPI: Fan [C1F8] (off)
[4294674.686000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294675.093000] ACPI: Thermal Zone [TZ1] (71 C)
[4294675.122000] Linux agpgart interface v0.101 (c) Dave Jones
[4294675.122000] agpgart: Detected an Intel 830M Chipset.
[4294675.138000] agpgart: AGP aperture is 256M @ 0x60000000
[4294675.138000] [drm] Initialized drm 1.0.0 20040925
[4294675.138000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0BB] -> GSI 11 (level, low) -> IRQ 11
[4294675.138000] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon Mobility M6 LY
[4294675.141000] PNP: PS/2 Controller [PNP0303:C171,PNP0f0e:C172] at 0x60,0x64 irq 1,12
[4294675.145000] i8042.c: Detected active multiplexing controller, rev 1.1.
[4294675.148000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[4294675.151000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[4294675.154000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[4294675.156000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[4294675.159000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294675.162000] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[4294675.164000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.167000] ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[4294675.171000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.174000] io scheduler noop registered
[4294675.176000] io scheduler anticipatory registered
[4294675.179000] io scheduler deadline registered
[4294675.181000] io scheduler cfq registered
[4294675.183000] e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
[4294675.186000] e100: Copyright(c) 1999-2005 Intel Corporation
[4294675.203000] ACPI: PCI Interrupt Link [C0BE] enabled at IRQ 11
[4294675.205000] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [C0BE] -> GSI 11 (level, low) -> IRQ 11
[4294675.295000] e100: eth0: e100_probe: addr 0x40100000, irq 11, MAC addr 00:02:A5:B5:03:7C
[4294675.297000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294675.300000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294675.303000] ICH3M: IDE controller at PCI slot 0000:00:1f.1
[4294675.305000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[4294675.322000] ACPI: PCI Interrupt Link [C0BC] enabled at IRQ 11
[4294675.325000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0BC] -> GSI 11 (level, low) -> IRQ 11
[4294675.327000] ICH3M: chipset revision 1
[4294675.330000] ICH3M: not 100% native mode: will probe irqs later
[4294675.333000]     ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
[4294675.335000]     ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:DMA, hdd:pio
[4294675.338000] Probing IDE interface ide0...
[4294675.602000] hda: IC25N020ATDA04-0, ATA DISK drive
[4294676.217000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294676.220000] Probing IDE interface ide1...
[4294676.892000] hdc: Compaq DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
[4294677.518000] ide1 at 0x170-0x177,0x376 on irq 15
[4294677.521000] ide2: I/O resource 0x3EE-0x3EE not free.
[4294677.524000] ide2: ports already in use, skipping probe
[4294677.527000] Probing IDE interface ide3...
[4294678.040000] Probing IDE interface ide4...
[4294678.553000] Probing IDE interface ide5...
[4294679.066000] hda: max request size: 128KiB
[4294679.085000] hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(100)
[4294679.088000] hda: cache flushes not supported
[4294679.091000]  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
[4294679.134000] hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, DMA
[4294679.137000] Uniform CD-ROM driver Revision: 3.20
[4294679.145000] mice: PS/2 mouse device common for all mice
[4294679.148000] NET: Registered protocol family 2
[4294679.161000] IP: routing cache hash table of 8192 buckets, 64Kbytes
[4294679.164000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[4294679.170000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294679.175000] TCP: Hash tables configured (established 131072 bind 65536)
[4294679.178000] NET: Registered protocol family 1
[4294679.181000] NET: Registered protocol family 17
[4294679.184000] PM: Checking swsusp image.
[4294679.184000] swsusp: Resume From Partition /dev/hda4
[4294679.206000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294679.216000] swsusp: Suspend partition has wrong signature?
[4294679.219000] swsusp: Error -22 check for resume file
[4294679.219000] PM: Resume from disk failed.
[4294679.220000] ACPI wakeup devices: 
[4294679.223000] C052 C17E C185 C0A4 C0AA C19F C1A0 C1A3 C1A4 
[4294679.226000] ACPI: (supports S0 S1 S3 S4 S4bios S5)
[4294679.256000] EXT3-fs: INFO: recovery required on readonly filesystem.
[4294679.259000] EXT3-fs: write access will be enabled during recovery.
[4294679.886000] EXT3-fs: recovery complete.
[4294679.889000] kjournald starting.  Commit interval 5 seconds
[4294679.896000] EXT3-fs: mounted filesystem with ordered data mode.
[4294679.900000] VFS: Mounted root (ext3 filesystem) readonly.
[4294679.903000] Freeing unused kernel memory: 184k freed
[4294685.573000] Adding 665272k swap on /dev/hda4.  Priority:-1 extents:1
[4294685.759000] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[4294685.772000] EXT3 FS on hda2, internal journal
[4294689.777000] irda_init()
[4294689.777000] NET: Registered protocol family 23
[4294689.811000] found SMC SuperIO Chip (devid=0x0e rev=01 base=0x002e): LPC47N252
[4294689.814000] SMsC IrDA Controller found
[4294689.814000]  IrCC version 2.0, firport 0x100, sirport 0x3e8 dma=1, irq=3
[4294689.820000] smsc_ircc_set_sir_speed(), Setting speed to: 9600
[4294689.820000] No transceiver found. Defaulting to Fast pin select
[4294689.824000] IrDA: Registered device irda0
[4294689.939000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294690.147000] smsc_ircc_change_speed() changing speed to: 9600
[4294690.147000] smsc_ircc_set_sir_speed(), Setting speed to: 9600
[4294690.147000] irlap_change_speed(), setting speed to 9600
[4294702.908000] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[4294702.911000] kjournald starting.  Commit interval 5 seconds
[4294702.913000] EXT3 FS on hda3, internal journal
[4294702.913000] EXT3-fs: mounted filesystem with ordered data mode.
[4294705.396000] usbcore: registered new driver usbfs
[4294705.417000] usbcore: registered new driver hub
[4294705.481000] USB Universal Host Controller Interface driver v2.2
[4294705.517000] ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 11
[4294705.520000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0BA] -> GSI 11 (level, low) -> IRQ 11
[4294705.523000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294705.523000] uhci_hcd 0000:00:1d.0: Intel Corporation 82801CA/CAM USB (Hub #1)
[4294705.589000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[4294705.592000] uhci_hcd 0000:00:1d.0: irq 11, io base 0x00004000
[4294705.597000] hub 1-0:1.0: USB hub found
[4294705.600000] hub 1-0:1.0: 2 ports detected
[4294705.652000] ACPI: PCI Interrupt Link [C0BD] enabled at IRQ 11
[4294705.655000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0BD] -> GSI 11 (level, low) -> IRQ 11
[4294705.658000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294705.658000] uhci_hcd 0000:00:1d.1: Intel Corporation 82801CA/CAM USB (Hub #2)
[4294705.724000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[4294705.744000] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00004020
[4294705.749000] hub 2-0:1.0: USB hub found
[4294705.752000] hub 2-0:1.0: 2 ports detected
[4294705.795000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0BC] -> GSI 11 (level, low) -> IRQ 11
[4294705.798000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294705.798000] uhci_hcd 0000:00:1d.2: Intel Corporation 82801CA/CAM USB (Hub #3)
[4294705.864000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[4294705.867000] uhci_hcd 0000:00:1d.2: irq 11, io base 0x00004040
[4294705.872000] hub 3-0:1.0: USB hub found
[4294705.877000] hub 3-0:1.0: 2 ports detected
[4294708.481000] hw_random hardware driver 1.0.0 loaded
[4294708.860000] Linux Kernel Card Services
[4294708.863000]   options:  [pci] [cardbus] [pm]
[4294708.935000] ACPI: PCI Interrupt Link [C0C0] enabled at IRQ 11
[4294708.938000] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [C0C0] -> GSI 11 (level, low) -> IRQ 11
[4294708.941000] Yenta: CardBus bridge found at 0000:02:03.0 [0e11:004e]
[4294708.944000] Yenta: Enabling burst memory read transactions
[4294708.947000] Yenta: Using CSCINT to route CSC interrupts to PCI
[4294708.950000] Yenta: Routing CardBus interrupts to PCI
[4294708.952000] Yenta TI: socket 0000:02:03.0, mfunc 0x01001002, devctl 0x64
[4294709.176000] Yenta: ISA IRQ mask 0x04f0, PCI irq 11
[4294709.179000] Socket status: 30000006
[4294709.200000] ACPI: PCI Interrupt 0000:02:03.1[A] -> Link [C0C0] -> GSI 11 (level, low) -> IRQ 11
[4294709.203000] Yenta: CardBus bridge found at 0000:02:03.1 [0e11:004e]
[4294709.206000] Yenta: Using CSCINT to route CSC interrupts to PCI
[4294709.209000] Yenta: Routing CardBus interrupts to PCI
[4294709.213000] Yenta TI: socket 0000:02:03.1, mfunc 0x01001002, devctl 0x64
[4294709.437000] Yenta: ISA IRQ mask 0x04f0, PCI irq 11
[4294709.440000] Socket status: 30000006
[4294710.260000] ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [C0BA] -> GSI 11 (level, low) -> IRQ 11
[4294712.909000] parport: PnPBIOS parport detected.
[4294712.912000] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[4294713.007000] input: PC Speaker
[4294713.123000] Real Time Clock Driver v1.12
[4294713.889000] Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9b48b1, caps: 0x884793/0x0
[4294713.891000] serio: Synaptics pass-through port at isa0060/serio4/input0
[4294713.896000] input: SynPS/2 Synaptics TouchPad on isa0060/serio4
[4294719.242000] input: PS/2 Generic Mouse on synaptics-pt/serio0

--------------090003050603050605020801
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

0000:00:00.0 Host bridge: Intel Corporation 82830 830 Chipset Host Bridge (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 60000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] #09 [0105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW+ Rate=x1

0000:00:01.0 PCI bridge: Intel Corporation 82830 830 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 40200000-402fffff
	Prefetchable memory behind bridge: 48000000-4fffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 4000 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 4020 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 4040 [size=32]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 41) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 40000000-401fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801CAM ISA Bridge (LPC) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 4060 [size=16]
	Region 5: Memory at 28000000 (32-bit, non-prefetchable) [size=1K]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device b111
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 48000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at 40200000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:03.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Compaq Computer Corporation: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 28400000-287ff000 (prefetchable)
	Memory window 1: 28800000-28bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:03.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Compaq Computer Corporation: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40080000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 28c00000-28fff000 (prefetchable)
	Memory window 1: 29000000-293ff000
	I/O window 0: 00004c00-00004cff
	I/O window 1: 00005000-000050ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:04.0 Communication controller: Agere Systems (former Lucent Microelectronics) LT WinModem (rev 02)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0450
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40180000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 2840 [size=8]
	Region 2: I/O ports at 2000 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3) PRO/100 VM (KM) Ethernet Controller (rev 41)
	Subsystem: Compaq Computer Corporation: Unknown device 0098
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2800 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device 0094
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 2400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------090003050603050605020801--
