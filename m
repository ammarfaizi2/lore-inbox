Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319253AbSIEWw3>; Thu, 5 Sep 2002 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319259AbSIEWw2>; Thu, 5 Sep 2002 18:52:28 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:58704 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S319253AbSIEWwJ>;
	Thu, 5 Sep 2002 18:52:09 -0400
From: <Hell.Surfers@cwctv.net>
To: kirk@braille.uwo.ca, linux-kernel@vger.kernel.org
Date: Thu, 5 Sep 2002 23:56:04 +0100
Subject: RE:2.5.xx kernels won't run on my Athlon boxes
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1031266564247"
Message-ID: <093d71655220592DTVMAIL10@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1031266564247
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Suppose its either PIO/DMA IDE stuff or your kernel had a flea problem, [irony] because it is itchy [/irony].



On 	05 Sep 2002 16:14:44 -0400 	Kirk Reiser <kirk@braille.uwo.ca> wrote:

--1031266564247
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 5 Sep 2002 21:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSIEUKV>; Thu, 5 Sep 2002 16:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSIEUKV>; Thu, 5 Sep 2002 16:10:21 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:56254 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S318134AbSIEUKL>; Thu, 5 Sep 2002 16:10:11 -0400
Received: from kirk by speech.braille.uwo.ca with local (Exim 3.35 #1 (Debian))
	id 17n31Y-0007kO-00
	for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2002 16:14:44 -0400
To: Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: 2.5.xx kernels won't run on my Athlon boxes
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 05 Sep 2002 16:14:44 -0400
In-Reply-To: <3D77B216.8070205@fl.priv.at>
Message-ID: <x7elc8b3d7.fsf@speech.braille.uwo.ca>
Lines: 809
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

Hi Folks:  I'm not even sure where to start outlining this problem.  I
have two Athlon 2100+ xp systems using Epoch EP8K3A mother boards.  I
don't seem to be able to get any 2.5.xx kernels to run on them for
more than a few minutes.  I have tried compiling kernels without
specifying K7 or K6 I've tried with and without the via chip set
options.  The boxes have the via 82C586 chip set.

The 2.4.19 kernels seem to be a bit more stable on them than the
2.5.xx are.  If anyone has any ideas what I can check I'd certainly
appreciate it.  I'll include my .config and output from dmesg below.


  Kirk

Sep  5 14:51:55 itchy kernel: Linux version 2.5.33 (kirk@itchy) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Sep 5 14:41:01 EDT 2002
Sep  5 14:51:55 itchy kernel: Video mode to be used for restore is f01
Sep  5 14:51:55 itchy kernel: BIOS-provided physical RAM map:
Sep  5 14:51:55 itchy kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Sep  5 14:51:55 itchy kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep  5 14:51:55 itchy kernel:  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
Sep  5 14:51:55 itchy kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep  5 14:51:55 itchy kernel: 512MB LOWMEM available.
Sep  5 14:51:55 itchy kernel: On node 0 totalpages: 131072
Sep  5 14:51:55 itchy kernel: zone(0): 4096 pages.
Sep  5 14:51:55 itchy kernel: zone(1): 126976 pages.
Sep  5 14:51:55 itchy kernel: zone(2): 0 pages.
Sep  5 14:51:55 itchy kernel: Kernel command line: BOOT_IMAGE=old ro root=301
Sep  5 14:51:55 itchy kernel: Initializing CPU#0
Sep  5 14:51:55 itchy kernel: Detected 1737.649 MHz processor.
Sep  5 14:51:55 itchy kernel: Console: colour VGA+ 80x50
Sep  5 14:51:55 itchy kernel: Calibrating delay loop... 3424.25 BogoMIPS
Sep  5 14:51:55 itchy kernel: Memory: 516872k/524288k available (1081k kernel code, 7032k reserved, 368k data, 228k init, 0k highmem)
Sep  5 14:51:55 itchy kernel: Security Scaffold v1.0.0 initialized
Sep  5 14:51:55 itchy kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Sep  5 14:51:55 itchy kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Sep  5 14:51:55 itchy kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep  5 14:51:55 itchy kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep  5 14:51:55 itchy kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep  5 14:51:55 itchy kernel: Intel machine check architecture supported.
Sep  5 14:51:55 itchy kernel: Intel machine check reporting enabled on CPU#0.
Sep  5 14:51:55 itchy kernel: Machine check exception polling timer started.
Sep  5 14:51:55 itchy kernel: CPU: AMD Athlon(tm) XP 2100+ stepping 02
Sep  5 14:51:55 itchy kernel: Enabling fast FPU save and restore... done.
Sep  5 14:51:55 itchy kernel: Enabling unmasked SIMD FPU exception support... done.
Sep  5 14:51:55 itchy kernel: Checking 'hlt' instruction... OK.
Sep  5 14:51:55 itchy kernel: POSIX conformance testing by UNIFIX
Sep  5 14:51:55 itchy kernel: Linux NET4.0 for Linux 2.4
Sep  5 14:51:55 itchy kernel: Based upon Swansea University Computer Society NET3.039
Sep  5 14:51:55 itchy kernel: Initializing RT netlink socket
Sep  5 14:51:55 itchy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
Sep  5 14:51:55 itchy kernel: PCI: Using configuration type 1
Sep  5 14:51:55 itchy kernel: PCI: Probing PCI hardware
Sep  5 14:51:55 itchy kernel: PCI: Probing PCI hardware (bus 00)
Sep  5 14:51:55 itchy kernel: PCI: Using IRQ router default [1106/3099] at 00:00.0
Sep  5 14:51:55 itchy kernel: Starting kswapd
Sep  5 14:51:55 itchy kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Sep  5 14:51:55 itchy kernel: biovec: init pool 0, 1 entries, 12 bytes
Sep  5 14:51:55 itchy kernel: biovec: init pool 1, 4 entries, 48 bytes
Sep  5 14:51:55 itchy kernel: biovec: init pool 2, 16 entries, 192 bytes
Sep  5 14:51:55 itchy kernel: biovec: init pool 3, 64 entries, 768 bytes
Sep  5 14:51:55 itchy kernel: biovec: init pool 4, 128 entries, 1536 bytes
Sep  5 14:51:55 itchy kernel: biovec: init pool 5, 256 entries, 3072 bytes
Sep  5 14:51:55 itchy kernel: aio_setup: sizeof(struct page) = 40
Sep  5 14:51:55 itchy kernel: Journalled Block Device driver loaded
Sep  5 14:51:55 itchy kernel: Capability LSM initialized
Sep  5 14:51:55 itchy kernel: block: 256 slots per queue, batch=32
Sep  5 14:51:55 itchy kernel: Floppy drive(s): fd0 is 1.44M
Sep  5 14:51:55 itchy kernel: FDC 0 is a post-1991 82077
Sep  5 14:51:55 itchy kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Sep  5 14:51:55 itchy kernel: 00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.18
Sep  5 14:51:55 itchy kernel: phy=0, phyx=24, mii_status=0x782d
Sep  5 14:51:55 itchy kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Sep  5 14:51:55 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  5 14:51:55 itchy kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Sep  5 14:51:55 itchy kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
Sep  5 14:51:55 itchy kernel: VP_IDE: chipset revision 6
Sep  5 14:51:55 itchy kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep  5 14:51:55 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  5 14:51:55 itchy kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep  5 14:51:55 itchy kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
Sep  5 14:51:55 itchy kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
Sep  5 14:51:55 itchy kernel: hda: MAXTOR 6L080J4, ATA DISK drive
Sep  5 14:51:55 itchy kernel: blk: queue c02cb0e4, I/O limit 4095Mb (mask 0xffffffff)
Sep  5 14:51:55 itchy kernel: hdc: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
Sep  5 14:51:55 itchy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  5 14:51:55 itchy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  5 14:51:55 itchy kernel: hda: host protected area => 1
Sep  5 14:51:55 itchy kernel: hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(133)
Sep  5 14:51:55 itchy kernel:  hda: hda1 hda2 hda3 hda4
Sep  5 14:51:55 itchy kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Sep  5 14:51:55 itchy kernel: Uniform CD-ROM driver Revision: 3.12
Sep  5 14:51:55 itchy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  5 14:51:55 itchy kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  5 14:51:55 itchy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  5 14:51:55 itchy kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  5 14:51:55 itchy kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Sep  5 14:51:55 itchy kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Sep  5 14:51:55 itchy kernel: TCP: Hash tables configured (established 131072 bind 65536)
Sep  5 14:51:55 itchy kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep  5 14:51:55 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep  5 14:51:55 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  5 14:51:55 itchy kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep  5 14:51:55 itchy kernel: Freeing unused kernel memory: 228k freed
Sep  5 14:51:55 itchy kernel: Adding 634556k swap on /dev/hda2.  Priority:-1 extents:1
Sep  5 14:51:55 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Sep  5 14:51:55 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep  5 14:51:55 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Sep  5 14:51:55 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  5 14:51:55 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep  5 14:51:55 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
Sep  5 14:51:55 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061



#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

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
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
# CONFIG_ACPI is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old non-SCSI/ATAPI CD-ROM drives
#
# CONFIG_CD_NO_IDESCSI is not set

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
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000_NAPI is not set
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
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

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
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
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
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
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
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

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
# CONFIG_SERIAL_8250 is not set
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
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
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Sound
#
# CONFIG_SOUND is not set

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
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1031266564247--


