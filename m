Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTLBVyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTLBVyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:54:39 -0500
Received: from legolas.restena.lu ([158.64.1.34]:18883 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264409AbTLBVxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:53:15 -0500
Subject: Re: IDE-SCSI oops in 2.6.0-test11
From: Craig Bradney <cbradney@zip.com.au>
To: ross.alexander@uk.neceur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com>
References: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com>
Content-Type: text/plain
Message-Id: <1070401986.12502.6.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 22:53:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as an fyi, Im on a 2600, same mobo (well, v2 1007 bios).. 2.6 test
11, acpi on, local apic on, apic on.

Can burn CDs and DVD+RWs without IDE-SCSI just fine.

k3b 0.10.2
cdrdao 1.1.8pre2
cdtools 2.01 alpha 19

Craig



On Tue, 2003-12-02 at 13:40, ross.alexander@uk.neceur.com wrote:
> CPU: Athlon-XP 2700+
> MB: ASUS A7N8X Deluxe
> Memory: 3 x 512MB
> Notes: UP kernel, standard EIDE driver, boot paramters acpi=off 
> nolapic,noapic
> Libc: glibc-2.3.2 with linuxthreads.
> 
> This error occurs while trying to write a DVD+RW to an NEC-1300A DVD 
> writer
> using cdrecord-dvdpro executable (no source available).  This works fine
> on linux-2.4.23.
> 
> Dec  2 11:39:56 mig27 kernel: Linux version 2.6.0-test11 (root@mig27) (gcc 
> version 3.3.2) #9 Tue Dec 2 09:00:15 GMT 2003
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 0000000000000000 - 
> 000000000009fc00 (usable)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 000000000009fc00 - 
> 00000000000a0000 (reserved)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 00000000000f0000 - 
> 0000000000100000 (reserved)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 0000000000100000 - 
> 000000005fff0000 (usable)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 000000005fff0000 - 
> 000000005fff3000 (ACPI NVS)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 000000005fff3000 - 
> 0000000060000000 (ACPI data)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 00000000fec00000 - 
> 00000000fec01000 (reserved)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 00000000fee00000 - 
> 00000000fee01000 (reserved)
> Dec  2 11:39:56 mig27 kernel:  BIOS-e820: 00000000ffff0000 - 
> 0000000100000000 (reserved)
> Dec  2 11:39:56 mig27 kernel:  user: 0000000000000000 - 000000000009fc00 
> (usable)
> Dec  2 11:39:57 mig27 kernel:  user: 000000000009fc00 - 00000000000a0000 
> (reserved)
> Dec  2 11:39:57 mig27 kernel:  user: 00000000000f0000 - 0000000000100000 
> (reserved)
> Dec  2 11:39:57 mig27 kernel:  user: 0000000000100000 - 000000005fff0000 
> (usable)
> Dec  2 11:39:57 mig27 kernel: On node 0 totalpages: 393200
> Dec  2 11:39:57 mig27 kernel:   DMA zone: 4096 pages, LIFO batch:1
> Dec  2 11:39:57 mig27 kernel:   Normal zone: 225280 pages, LIFO batch:16
> Dec  2 11:39:57 mig27 kernel:   HighMem zone: 163824 pages, LIFO batch:16
> Dec  2 11:39:57 mig27 kernel: Building zonelist for node : 0
> Dec  2 11:39:57 mig27 kernel: Kernel command line: root=/dev/hda1 vga=773 
> acpi=off nolapic noapic mem=1572800K
> Dec  2 11:39:57 mig27 kernel: PID hash table entries: 4096 (order 12: 
> 32768 bytes)
> Dec  2 11:39:57 mig27 kernel: Detected 2162.490 MHz processor.
> Dec  2 11:39:57 mig27 kernel: Console: colour dummy device 80x25
> Dec  2 11:39:57 mig27 kernel: Calibrating delay loop... 4276.22 BogoMIPS
> Dec  2 11:39:57 mig27 kernel: Inode-cache hash table entries: 131072 
> (order: 7, 524288 bytes)
> Dec  2 11:39:57 mig27 kernel: Mount-cache hash table entries: 512 (order: 
> 0, 4096 bytes)
> Dec  2 11:39:57 mig27 kernel: CPU: AMD Athlon(tm) XP 2700+ stepping 01
> Dec  2 11:39:57 mig27 kernel: POSIX conformance testing by UNIFIX
> Dec  2 11:39:57 mig27 kernel: ACPI: ACPI tables contain no PCI IRQ routing 
> entries
> Dec  2 11:39:57 mig27 kernel: PCI: Invalid ACPI-PCI IRQ routing table
> Dec  2 11:39:57 mig27 kernel: PCI: Probing PCI hardware
> Dec  2 11:39:57 mig27 kernel: PCI: Probing PCI hardware (bus 00)
> Dec  2 11:39:57 mig27 kernel: highmem bounce pool size: 64 pages
> Dec  2 11:39:57 mig27 kernel: Console: switching to colour frame buffer 
> device 128x48
> Dec  2 11:39:57 mig27 kernel: pty: 256 Unix98 ptys configured
> Dec  2 11:39:57 mig27 kernel: hda: ST380021A, ATA DISK drive
> Dec  2 11:39:57 mig27 kernel: hdc: _NEC CD-ROM CD-3002A, ATAPI CD/DVD-ROM 
> drive
> Dec  2 11:39:57 mig27 kernel: hdd: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM 
> drive
> Dec  2 11:39:57 mig27 kernel: Using anticipatory io scheduler
> Dec  2 11:39:57 mig27 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Dec  2 11:39:57 mig27 kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Dec  2 11:39:57 mig27 kernel: hda: max request size: 128KiB
> Dec  2 11:39:57 mig27 kernel: Console: switching to colour frame buffer 
> device 128x48
> Dec  2 11:39:57 mig27 kernel: VFS: Mounted root (ext2 filesystem) 
> readonly.
> Dec  2 11:39:57 mig27 kernel: 3c59x: Donald Becker and others. 
> www.scyld.com/network/vortex.html
> Dec  2 11:40:28 mig27 kernel: mtrr: 0xd0000000,0x4000000 overlaps existing 
> 0xd0000000,0x1000000
> Dec  2 11:40:33 mig27 kernel: spurious 8259A interrupt: IRQ7.
> Dec  2 11:42:56 mig27 kernel: hdc: ATAPI 52X CD-ROM drive, 128kB Cache
> Dec  2 11:42:56 mig27 kernel: hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 
> 2048kB Cache
> Dec  2 11:51:36 mig27 kernel: ide-scsi is deprecated for cd burning! Use 
> ide-cd and give dev=/dev/hdX as device
> Dec  2 11:51:43 mig27 kernel: ahc_pci:1:10:0: Host Adapter Bios disabled. 
> Using default SCSI device parameters
> Dec  2 11:51:43 mig27 kernel:         <Adaptec 2902/04/10/15/20/30C SCSI 
> adapter>
> Dec  2 11:51:43 mig27 kernel:         aic7850: Single Channel A, SCSI 
> Id=7, 3/253 SCBs
> Dec  2 11:51:43 mig27 kernel: 
> Dec  2 11:51:58 mig27 kernel: (scsi2:A:1): 10.000MB/s transfers 
> (10.000MHz, offset 15)
> Dec  2 11:53:20 mig27 kernel: sr0: scsi3-mmc drive: 1x/52x cd/rw xa/form2 
> cdda tray
> Dec  2 11:53:20 mig27 kernel: sr1: scsi3-mmc drive: 40x/40x writer cd/rw 
> xa/form2 cdda tray
> Dec  2 11:53:20 mig27 kernel: sr2: scsi3-mmc drive: 16x/40x cd/rw xa/form2 
> cdda tray
> Dec  2 12:02:46 mig27 kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Dec  2 12:02:46 mig27 kernel:  printing eip:
> Dec  2 12:02:46 mig27 kernel: 00000000
> Dec  2 12:02:46 mig27 kernel: *pde = 00000000
> Dec  2 12:02:46 mig27 kernel: Oops: 0000 [#1]
> Dec  2 12:02:46 mig27 kernel: CPU:    0
> Dec  2 12:02:46 mig27 kernel: EIP:    0060:[<00000000>]    Not tainted
> Dec  2 12:02:46 mig27 kernel: EFLAGS: 00210202
> Dec  2 12:02:46 mig27 kernel: EIP is at 0x0
> Dec  2 12:02:46 mig27 kernel: eax: c0354f10   ebx: c035516c   ecx: 
> 00000000   edx: 00000170
> Dec  2 12:02:46 mig27 kernel: esi: f623e400   edi: f6ed4fc0   ebp: 
> e4161be0   esp: e4161bb8
> Dec  2 12:02:46 mig27 kernel: ds: 007b   es: 007b   ss: 0068
> Dec  2 12:02:46 mig27 kernel: Process cdrecord-prodvd (pid: 369, 
> threadinfo=e4160000 task=f65d4100)
> Dec  2 12:02:46 mig27 kernel: Stack: f9859b1b c035516c f623e400 0000000c 
> 00000000 0000001e f6ed4fc0 c035516c 
> Dec  2 12:02:46 mig27 kernel:        00000000 f6f9b240 e4161c0c c01ff25a 
> c035516c f623e400 00000000 00000000 
> Dec  2 12:02:46 mig27 kernel:        0000001e 0000000f f6f9b240 c035516c 
> c0354f10 e4161c38 c01ff570 c035516c 
> Dec  2 12:02:46 mig27 kernel: Call Trace:
> Dec  2 12:02:46 mig27 kernel:  [<f9859b1b>] 
> idescsi_transfer_pc+0x11b/0x120 [ide_scsi]
> Dec  2 12:02:46 mig27 kernel:  [<c01ff25a>] start_request+0x16a/0x270
> Dec  2 12:02:46 mig27 kernel:  [<c01ff570>] ide_do_request+0x1e0/0x360
> Dec  2 12:02:46 mig27 kernel:  [<c01f3587>] __elv_add_request+0x27/0x40
> Dec  2 12:02:46 mig27 kernel:  [<c01ffd5e>] ide_do_drive_cmd+0xce/0x170
> Dec  2 12:02:46 mig27 kernel:  [<f985a36b>] idescsi_queue+0x1fb/0x630 
> [ide_scsi]
> Dec  2 12:02:46 mig27 kernel:  [<f993171f>] 
> scsi_init_cmd_from_req+0xcf/0x150 [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<f993159e>] scsi_dispatch_cmd+0x14e/0x200 
> [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<f99317a0>] scsi_done+0x0/0x70 [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<f9933ae0>] scsi_times_out+0x0/0x50 
> [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<f993631d>] scsi_request_fn+0x1cd/0x320 
> [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<c01f5b0c>] blk_insert_request+0x7c/0xd0
> Dec  2 12:02:46 mig27 kernel:  [<f9934ffb>] 
> scsi_insert_special_req+0x3b/0x40 [scsi_mod]
> Dec  2 12:02:46 mig27 kernel:  [<f98c3eb1>] sg_common_write+0x161/0x1d0 
> [sg]
> Dec  2 12:02:46 mig27 kernel:  [<f98c5290>] sg_cmd_done+0x0/0x280 [sg]
> Dec  2 12:02:46 mig27 kernel:  [<f98c3c73>] sg_new_write+0x1c3/0x2a0 [sg]
> Dec  2 12:02:46 mig27 kernel:  [<f98c4c09>] sg_ioctl+0xce9/0xf20 [sg]
> Dec  2 12:02:46 mig27 kernel:  [<c0204812>] pre_task_mulout_intr+0x82/0x90
> Dec  2 12:02:46 mig27 kernel:  [<c01afee4>] __delay+0x14/0x20
> Dec  2 12:02:46 mig27 kernel:  [<c02037fe>] do_rw_taskfile+0x12e/0x2b0
> Dec  2 12:02:46 mig27 kernel:  [<c01faff3>] 
> as_remove_queued_request+0x83/0x120
> Dec  2 12:02:46 mig27 kernel:  [<c020a194>] lba_28_rw_disk+0xa4/0xb0
> Dec  2 12:02:46 mig27 kernel:  [<c01284b6>] update_process_times+0x46/0x50
> Dec  2 12:02:46 mig27 kernel:  [<c012832d>] update_wall_time+0xd/0x40
> Dec  2 12:02:46 mig27 kernel:  [<c012877e>] do_timer+0xde/0xf0
> Dec  2 12:02:46 mig27 kernel:  [<c01284b6>] update_process_times+0x46/0x50
> Dec  2 12:02:46 mig27 kernel:  [<c012832d>] update_wall_time+0xd/0x40
> Dec  2 12:02:46 mig27 kernel:  [<c012877e>] do_timer+0xde/0xf0
> Dec  2 12:02:46 mig27 kernel:  [<c011cbf0>] default_wake_function+0x0/0x20
> Dec  2 12:02:46 mig27 kernel:  [<c01103ea>] do_gettimeofday+0x2a/0xc0
> Dec  2 12:02:46 mig27 kernel:  [<c01666d4>] sys_ioctl+0xf4/0x2a0
> Dec  2 12:02:46 mig27 kernel:  [<c010a36f>] syscall_call+0x7/0xb
> Dec  2 12:02:46 mig27 kernel: 
> Dec  2 12:02:46 mig27 kernel: Code:  Bad EIP value.
> 
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_STANDALONE=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_USE_3DNOW=y
> # CONFIG_HPET_TIMER is not set
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> CONFIG_X86_MCE_P4THERMAL=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_EDD is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_SOFTWARE_SUSPEND is not set
> # CONFIG_PM_DISK is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_RELAXED_AML is not set
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> CONFIG_HOTPLUG=y
> 
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
> CONFIG_PCMCIA_PROBE=y
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> # CONFIG_FW_LOADER is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> # CONFIG_PNPBIOS is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_LBD=y
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=m
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=m
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> CONFIG_SCSI_REPORT_LUNS=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=m
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> # CONFIG_AIC7XXX_PROBE_EISA_VL is not set
> # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> # CONFIG_BLK_DEV_MD is not set
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_IOCTL_V4=y
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> CONFIG_IEEE1394=m
> 
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> # CONFIG_IEEE1394_OUI_DB is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Texas Instruments PCILynx requires I2C bit-banging
> #
> CONFIG_IEEE1394_OHCI1394=m
> 
> #
> # Protocol Drivers
> #
> # CONFIG_IEEE1394_VIDEO1394 is not set
> # CONFIG_IEEE1394_SBP2 is not set
> # CONFIG_IEEE1394_ETH1394 is not set
> # CONFIG_IEEE1394_DV1394 is not set
> # CONFIG_IEEE1394_RAWIO is not set
> # CONFIG_IEEE1394_CMP is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK_DEV is not set
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_IPV6=m
> # CONFIG_IPV6_PRIVACY is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NETFILTER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=m
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=m
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MII is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL1 is not set
> # CONFIG_EL2 is not set
> # CONFIG_ELPLUS is not set
> # CONFIG_EL16 is not set
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> CONFIG_VORTEX=m
> # CONFIG_TYPHOON is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> 
> #
> # Tulip family network device support
> #
> CONFIG_NET_TULIP=y
> # CONFIG_DE2104X is not set
> CONFIG_TULIP=m
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_DM9102 is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> # CONFIG_NET_PCI is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_PS2_SYNAPTICS is not set
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=m
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=m
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # I2C Algorithms
> #
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # I2C Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> CONFIG_HW_RANDOM=m
> CONFIG_NVRAM=m
> CONFIG_RTC=m
> CONFIG_GEN_RTC=m
> CONFIG_GEN_RTC_X=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=m
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> CONFIG_AGP_NVIDIA=m
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=m
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> 
> #
> # Logo configuration
> #
> # CONFIG_LOGO is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=m
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_SEQUENCER=m
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_SEQUENCER_OSS=y
> # CONFIG_SND_RTCTIMER is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> 
> #
> # ISA devices
> #
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> CONFIG_SND_INTEL8X0=m
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
> 
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_OHCI_HCD=m
> CONFIG_USB_UHCI_HCD=m
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_MIDI is not set
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_HP8200e is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_XPAD is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_SCANNER is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
> 
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_BRLVGER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> CONFIG_UDF_FS=m
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> # CONFIG_DEVFS_FS is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_EXPORTFS is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> CONFIG_FRAME_POINTER=y
> CONFIG_X86_EXTRA_IRQS=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> CONFIG_CRC32=m
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_PC=y
> 
> ---------------------------------------------------------------------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

