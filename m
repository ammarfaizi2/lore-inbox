Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSH1MbY>; Wed, 28 Aug 2002 08:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSH1MbY>; Wed, 28 Aug 2002 08:31:24 -0400
Received: from uni-sb.de ([134.96.252.33]:7899 "EHLO uni-sb.de")
	by vger.kernel.org with ESMTP id <S318794AbSH1MbU>;
	Wed, 28 Aug 2002 08:31:20 -0400
Date: Wed, 28 Aug 2002 14:35:35 +0200
Message-Id: <200208281235.g7SCZZ9H001715@pixel.cs.uni-sb.de>
From: Georg Demme <gdemme@graphics.cs.uni-sb.de>
To: Alexander.Riesen@synopsys.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <20020828111240.GC16092@riesen-pc.gr05.synopsys.com> (message
	from Alex Riesen on Wed, 28 Aug 2002 13:12:40 +0200)
Subject: Re: Server Hangups
References: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de> <20020828111240.GC16092@riesen-pc.gr05.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> syslog, dmesg output would be useful
> 

Syslog is not very helpful. Only normal log output there. kernel.log
may be more interessting. Here it comes:

Aug 27 19:48:15 graphics kernel: klogd 1.4.1#8, log source = /proc/kmsg started.
Aug 27 19:48:15 graphics kernel: Inspecting /boot/System.map-2.4.19
Aug 27 19:48:16 graphics kernel: Loaded 21707 symbols from /boot/System.map-2.4.19.
Aug 27 19:48:16 graphics kernel: Symbols match kernel version 2.4.19.
Aug 27 19:48:16 graphics kernel: Loaded 2696 symbols from 6 modules.
Aug 27 19:48:16 graphics kernel: Linux version 2.4.19 (root@pixel) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 SMP Fri Aug 16 12:15:23 CEST 2002
Aug 27 19:48:16 graphics kernel: BIOS-provided physical RAM map:
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 27 19:48:16 graphics kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 27 19:48:16 graphics kernel: 127MB HIGHMEM available.
Aug 27 19:48:16 graphics kernel: 896MB LOWMEM available.
Aug 27 19:48:16 graphics kernel: found SMP MP-table at 000fb110
Aug 27 19:48:16 graphics kernel: hm, page 000fb000 reserved twice.
Aug 27 19:48:16 graphics kernel: hm, page 000fc000 reserved twice.
Aug 27 19:48:16 graphics kernel: hm, page 000f5000 reserved twice.
Aug 27 19:48:16 graphics kernel: hm, page 000f6000 reserved twice.
Aug 27 19:48:16 graphics kernel: Advanced speculative caching feature not present
Aug 27 19:48:16 graphics kernel: On node 0 totalpages: 262128
Aug 27 19:48:16 graphics kernel: zone(0): 4096 pages.
Aug 27 19:48:16 graphics kernel: zone(1): 225280 pages.
Aug 27 19:48:16 graphics kernel: zone(2): 32752 pages.
Aug 27 19:48:16 graphics kernel: Intel MultiProcessor Specification v1.1
Aug 27 19:48:16 graphics kernel:     Virtual Wire compatibility mode.
Aug 27 19:48:16 graphics kernel: OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
Aug 27 19:48:16 graphics kernel: Processor #0 Pentium(tm) Pro APIC version 17
Aug 27 19:48:16 graphics kernel: Processor #1 Pentium(tm) Pro APIC version 17
Aug 27 19:48:16 graphics kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Aug 27 19:48:16 graphics kernel: Processors: 2
Aug 27 19:48:16 graphics kernel: Kernel command line: BOOT_IMAGE=Linux ro root=301
Aug 27 19:48:16 graphics kernel: Initializing CPU#0
Aug 27 19:48:16 graphics kernel: Detected 1129.454 MHz processor.
Aug 27 19:48:16 graphics kernel: Console: colour VGA+ 80x25
Aug 27 19:48:16 graphics kernel: Calibrating delay loop... 2254.43 BogoMIPS
Aug 27 19:48:16 graphics kernel: Memory: 1032092k/1048512k available (2162k kernel code, 16032k reserved, 755k data, 260k init, 131008k highmem)
Aug 27 19:48:16 graphics kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 27 19:48:16 graphics kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug 27 19:48:16 graphics kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Aug 27 19:48:16 graphics kernel: Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 27 19:48:16 graphics kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Aug 27 19:48:16 graphics kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Aug 27 19:48:16 graphics kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 27 19:48:16 graphics kernel: CPU: L2 cache: 512K
Aug 27 19:48:16 graphics kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: Intel machine check architecture supported.
Aug 27 19:48:16 graphics kernel: Intel machine check reporting enabled on CPU#0.
Aug 27 19:48:16 graphics kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: Enabling fast FPU save and restore... done.
Aug 27 19:48:16 graphics kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 27 19:48:16 graphics kernel: Checking 'hlt' instruction... OK.
Aug 27 19:48:16 graphics kernel: POSIX conformance testing by UNIFIX
Aug 27 19:48:16 graphics kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Aug 27 19:48:16 graphics kernel: mtrr: detected mtrr type: Intel
Aug 27 19:48:16 graphics kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Aug 27 19:48:16 graphics kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 27 19:48:16 graphics kernel: CPU: L2 cache: 512K
Aug 27 19:48:16 graphics kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: Intel machine check reporting enabled on CPU#0.
Aug 27 19:48:16 graphics kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Aug 27 19:48:16 graphics kernel: per-CPU timeslice cutoff: 1462.14 usecs.
Aug 27 19:48:16 graphics kernel: enabled ExtINT on CPU#0
Aug 27 19:48:16 graphics kernel: ESR value before enabling vector: 00000004
Aug 27 19:48:16 graphics kernel: ESR value after enabling vector: 00000000
Aug 27 19:48:16 graphics kernel: Booting processor 1/1 eip 2000
Aug 27 19:48:16 graphics kernel: Initializing CPU#1
Aug 27 19:48:16 graphics kernel: masked ExtINT on CPU#1
Aug 27 19:48:16 graphics kernel: ESR value before enabling vector: 00000000
Aug 27 19:48:16 graphics kernel: ESR value after enabling vector: 00000000
Aug 27 19:48:16 graphics kernel: Calibrating delay loop... 2254.43 BogoMIPS
Aug 27 19:48:16 graphics kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Aug 27 19:48:16 graphics kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 27 19:48:16 graphics kernel: CPU: L2 cache: 512K
Aug 27 19:48:16 graphics kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: Intel machine check reporting enabled on CPU#1.
Aug 27 19:48:16 graphics kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Aug 27 19:48:16 graphics kernel: CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Aug 27 19:48:16 graphics kernel: Total of 2 processors activated (4508.87 BogoMIPS).
Aug 27 19:48:16 graphics kernel: ENABLING IO-APIC IRQs
Aug 27 19:48:16 graphics kernel: Setting 2 in the phys_id_present_map
Aug 27 19:48:16 graphics kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Aug 27 19:48:16 graphics kernel: init IO_APIC IRQs
Aug 27 19:48:16 graphics kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Aug 27 19:48:16 graphics kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Aug 27 19:48:16 graphics kernel: number of MP IRQ sources: 16.
Aug 27 19:48:16 graphics kernel: number of IO-APIC #2 registers: 24.
Aug 27 19:48:16 graphics kernel: testing the IO APIC.......................
Aug 27 19:48:16 graphics kernel: 
Aug 27 19:48:16 graphics kernel: IO APIC #2......
Aug 27 19:48:16 graphics kernel: .... register #00: 02000000
Aug 27 19:48:16 graphics kernel: .......    : physical APIC id: 02
Aug 27 19:48:16 graphics kernel: .... register #01: 00178011
Aug 27 19:48:16 graphics kernel: .......     : max redirection entries: 0017
Aug 27 19:48:16 graphics kernel: .......     : PRQ implemented: 1
Aug 27 19:48:16 graphics kernel: .......     : IO APIC version: 0011
Aug 27 19:48:16 graphics kernel: .... register #02: 00000000
Aug 27 19:48:16 graphics kernel: .......     : arbitration: 00
Aug 27 19:48:16 graphics kernel: .... IRQ redirection table:
Aug 27 19:48:16 graphics kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Aug 27 19:48:16 graphics kernel:  00 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  01 003 03  0    0    0   0   0    1    1    39
Aug 27 19:48:16 graphics kernel:  02 003 03  0    0    0   0   0    1    1    31
Aug 27 19:48:16 graphics kernel:  03 003 03  0    0    0   0   0    1    1    41
Aug 27 19:48:16 graphics kernel:  04 003 03  0    0    0   0   0    1    1    49
Aug 27 19:48:16 graphics kernel:  05 003 03  0    0    0   0   0    1    1    51
Aug 27 19:48:16 graphics kernel:  06 003 03  0    0    0   0   0    1    1    59
Aug 27 19:48:16 graphics kernel:  07 003 03  0    0    0   0   0    1    1    61
Aug 27 19:48:16 graphics kernel:  08 003 03  0    0    0   0   0    1    1    69
Aug 27 19:48:16 graphics kernel:  09 003 03  1    1    0   1   0    1    1    71
Aug 27 19:48:16 graphics kernel:  0a 003 03  1    1    0   1   0    1    1    79
Aug 27 19:48:16 graphics kernel:  0b 003 03  1    1    0   1   0    1    1    81
Aug 27 19:48:16 graphics kernel:  0c 003 03  1    1    0   1   0    1    1    89
Aug 27 19:48:16 graphics kernel:  0d 003 03  0    0    0   0   0    1    1    91
Aug 27 19:48:16 graphics kernel:  0e 003 03  0    0    0   0   0    1    1    99
Aug 27 19:48:16 graphics kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Aug 27 19:48:16 graphics kernel:  10 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  11 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  12 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  13 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  14 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  15 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  16 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel:  17 000 00  1    0    0   0   0    0    0    00
Aug 27 19:48:16 graphics kernel: IRQ to pin mappings:
Aug 27 19:48:16 graphics kernel: IRQ0 -> 0:2
Aug 27 19:48:16 graphics kernel: IRQ1 -> 0:1
Aug 27 19:48:16 graphics kernel: IRQ3 -> 0:3
Aug 27 19:48:16 graphics kernel: IRQ4 -> 0:4
Aug 27 19:48:16 graphics kernel: IRQ5 -> 0:5
Aug 27 19:48:16 graphics kernel: IRQ6 -> 0:6
Aug 27 19:48:16 graphics kernel: IRQ7 -> 0:7
Aug 27 19:48:16 graphics kernel: IRQ8 -> 0:8
Aug 27 19:48:16 graphics kernel: IRQ9 -> 0:9
Aug 27 19:48:16 graphics kernel: IRQ10 -> 0:10
Aug 27 19:48:16 graphics kernel: IRQ11 -> 0:11
Aug 27 19:48:16 graphics kernel: IRQ12 -> 0:12
Aug 27 19:48:16 graphics kernel: IRQ13 -> 0:13
Aug 27 19:48:16 graphics kernel: IRQ14 -> 0:14
Aug 27 19:48:16 graphics kernel: IRQ15 -> 0:15
Aug 27 19:48:16 graphics kernel: .................................... done.
Aug 27 19:48:16 graphics kernel: Using local APIC timer interrupts.
Aug 27 19:48:16 graphics kernel: calibrating APIC timer ...
Aug 27 19:48:16 graphics kernel: ..... CPU clock speed is 1129.4521 MHz.
Aug 27 19:48:16 graphics kernel: ..... host bus clock speed is 132.8764 MHz.
Aug 27 19:48:16 graphics kernel: cpu: 0, clocks: 1328764, slice: 442921
Aug 27 19:48:16 graphics kernel: CPU0<T0:1328752,T1:885824,D:7,S:442921,C:1328764>
Aug 27 19:48:16 graphics kernel: cpu: 1, clocks: 1328764, slice: 442921
Aug 27 19:48:16 graphics kernel: CPU1<T0:1328752,T1:442896,D:14,S:442921,C:1328764>
Aug 27 19:48:16 graphics kernel: checking TSC synchronization across CPUs: passed.
Aug 27 19:48:16 graphics kernel: Waiting on wait_init_idle (map = 0x2)
Aug 27 19:48:16 graphics kernel: All processors have done init_idle
Aug 27 19:48:16 graphics kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Aug 27 19:48:16 graphics kernel: mtrr: probably your BIOS does not setup all CPUs
Aug 27 19:48:16 graphics kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
Aug 27 19:48:16 graphics kernel: PCI: Using configuration type 1
Aug 27 19:48:16 graphics kernel: PCI: Probing PCI hardware
Aug 27 19:48:16 graphics kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Aug 27 19:48:16 graphics kernel: PCI: Enabling Via external APIC routing
Aug 27 19:48:16 graphics kernel: isapnp: Scanning for PnP cards...
Aug 27 19:48:16 graphics kernel: isapnp: No Plug & Play device found
Aug 27 19:48:16 graphics kernel: Linux NET4.0 for Linux 2.4
Aug 27 19:48:16 graphics kernel: Based upon Swansea University Computer Society NET3.039
Aug 27 19:48:16 graphics kernel: Initializing RT netlink socket
Aug 27 19:48:16 graphics kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Aug 27 19:48:16 graphics kernel: apm: disabled - APM is not SMP safe.
Aug 27 19:48:16 graphics kernel: Starting kswapd
Aug 27 19:48:16 graphics kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Aug 27 19:48:16 graphics kernel: Journalled Block Device driver loaded
Aug 27 19:48:16 graphics kernel: devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
Aug 27 19:48:16 graphics kernel: devfs: boot_options: 0x1
Aug 27 19:48:16 graphics kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 27 19:48:16 graphics kernel: NTFS driver v1.1.22 [Flags: R/O]
Aug 27 19:48:16 graphics kernel: udf: registering filesystem
Aug 27 19:48:16 graphics kernel: Detected PS/2 Mouse Port.
Aug 27 19:48:16 graphics kernel: pty: 256 Unix98 ptys configured
Aug 27 19:48:16 graphics kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Aug 27 19:48:16 graphics kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Aug 27 19:48:16 graphics kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Aug 27 19:48:16 graphics kernel: Real Time Clock Driver v1.10e
Aug 27 19:48:16 graphics kernel: Non-volatile memory driver v1.1
Aug 27 19:48:16 graphics kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Aug 27 19:48:16 graphics kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 27 19:48:16 graphics kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Aug 27 19:48:16 graphics kernel: VP_IDE: detected chipset, but driver not compiled in!
Aug 27 19:48:16 graphics kernel: VP_IDE: chipset revision 6
Aug 27 19:48:16 graphics kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 27 19:48:16 graphics kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Aug 27 19:48:16 graphics kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Aug 27 19:48:16 graphics kernel: hda: IC35L020AVER07-0, ATA DISK drive
Aug 27 19:48:16 graphics kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 27 19:48:16 graphics kernel: hda: 39102336 sectors (20020 MB) w/1916KiB Cache, CHS=2434/255/63
Aug 27 19:48:16 graphics kernel: ide-floppy driver 0.99.newide
Aug 27 19:48:16 graphics kernel: Partition check:
Aug 27 19:48:16 graphics kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Aug 27 19:48:16 graphics kernel: floppy0: no floppy controllers found
Aug 27 19:48:16 graphics kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug 27 19:48:16 graphics kernel: loop: loaded (max 8 devices)
Aug 27 19:48:16 graphics kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Aug 27 19:48:16 graphics kernel: agpgart: Maximum main memory to use for agp memory: 816M
Aug 27 19:48:16 graphics kernel: agpgart: Detected Via Apollo Pro chipset
Aug 27 19:48:16 graphics kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Aug 27 19:48:16 graphics kernel: ide-floppy driver 0.99.newide
Aug 27 19:48:16 graphics kernel: SCSI subsystem driver Revision: 1.00
Aug 27 19:48:16 graphics kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Aug 27 19:48:16 graphics kernel:         <Adaptec 29160N Ultra160 SCSI adapter>
Aug 27 19:48:16 graphics kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Aug 27 19:48:16 graphics kernel: 
Aug 27 19:48:16 graphics kernel:   Vendor: Quantum   Model: DLT4000           Rev: D782
Aug 27 19:48:16 graphics kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Aug 27 19:48:16 graphics kernel: (scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
Aug 27 19:48:16 graphics kernel:   Vendor: OVERLAND  Model: LXB               Rev: 0422
Aug 27 19:48:16 graphics kernel:   Type:   Medium Changer                     ANSI SCSI revision: 02
Aug 27 19:48:16 graphics kernel: (scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
Aug 27 19:48:16 graphics kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Aug 27 19:48:16 graphics kernel: 3ware Storage Controller device driver for Linux v1.02.00.025.
Aug 27 19:48:16 graphics kernel: scsi2 : Found a 3ware Storage Controller at 0xdc00, IRQ: 10, P-chip: 1.3
Aug 27 19:48:16 graphics kernel: scsi2 : 3ware Storage Controller
Aug 27 19:48:16 graphics kernel: 3w-xxxx: scsi2: AEN: WARNING: Unclean shutdown detected: Unit #0.
Aug 27 19:48:16 graphics kernel:   Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0 
Aug 27 19:48:16 graphics kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Aug 27 19:48:16 graphics kernel: st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Aug 27 19:48:16 graphics kernel: Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Aug 27 19:48:16 graphics kernel: Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Aug 27 19:48:16 graphics kernel: SCSI device sda: 360303360 512-byte hdwr sectors (184475 MB)
Aug 27 19:48:16 graphics kernel:  /dev/scsi/host2/bus0/target0/lun0: p1
Aug 27 19:48:16 graphics kernel: Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 8
Aug 27 19:48:16 graphics kernel: Linux Kernel Card Services 3.1.22
Aug 27 19:48:16 graphics kernel:   options:  [pci] [cardbus] [pm]
Aug 27 19:48:16 graphics kernel: Intel PCIC probe: not found.
Aug 27 19:48:16 graphics kernel: usb.c: registered new driver usbdevfs
Aug 27 19:48:16 graphics kernel: usb.c: registered new driver hub
Aug 27 19:48:16 graphics kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Aug 27 19:48:16 graphics kernel: uhci.c: USB UHCI at I/O 0xd800, IRQ 12
Aug 27 19:48:16 graphics kernel: usb.c: new USB bus registered, assigned bus number 1
Aug 27 19:48:16 graphics kernel: hub.c: USB hub found
Aug 27 19:48:16 graphics kernel: hub.c: 2 ports detected
Aug 27 19:48:16 graphics kernel: uhci.c: USB UHCI at I/O 0xd400, IRQ 12
Aug 27 19:48:16 graphics kernel: usb.c: new USB bus registered, assigned bus number 2
Aug 27 19:48:16 graphics kernel: hub.c: USB hub found
Aug 27 19:48:16 graphics kernel: hub.c: 2 ports detected
Aug 27 19:48:16 graphics kernel: usb.c: registered new driver hid
Aug 27 19:48:16 graphics kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Aug 27 19:48:16 graphics kernel: hid-core.c: USB HID support drivers
Aug 27 19:48:16 graphics kernel: usb.c: registered new driver wacom
Aug 27 19:48:16 graphics kernel: wacom.c: v1.21.3 Vojtech Pavlik <vojtech@suse.cz>
Aug 27 19:48:16 graphics kernel: wacom.c: USB Wacom Graphire and Wacom Intuos tablet driver
Aug 27 19:48:16 graphics kernel: Initializing USB Mass Storage driver...
Aug 27 19:48:16 graphics kernel: usb.c: registered new driver usb-storage
Aug 27 19:48:16 graphics kernel: USB Mass Storage support registered.
Aug 27 19:48:16 graphics kernel: md: linear personality registered as nr 1
Aug 27 19:48:16 graphics kernel: md: raid0 personality registered as nr 2
Aug 27 19:48:16 graphics kernel: md: raid5 personality registered as nr 4
Aug 27 19:48:16 graphics kernel: raid5: measuring checksumming speed
Aug 27 19:48:16 graphics kernel:    8regs     :  1972.800 MB/sec
Aug 27 19:48:16 graphics kernel:    32regs    :  1389.600 MB/sec
Aug 27 19:48:16 graphics kernel:    pIII_sse  :  2503.200 MB/sec
Aug 27 19:48:16 graphics kernel:    pII_mmx   :  2491.600 MB/sec
Aug 27 19:48:16 graphics kernel:    p5_mmx    :  2634.400 MB/sec
Aug 27 19:48:16 graphics kernel: raid5: using function: pIII_sse (2503.200 MB/sec)
Aug 27 19:48:16 graphics kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 27 19:48:16 graphics kernel: md: Autodetecting RAID arrays.
Aug 27 19:48:16 graphics kernel: md: autorun ...
Aug 27 19:48:16 graphics kernel: md: ... autorun DONE.
Aug 27 19:48:16 graphics kernel: LVM version 1.0.3(19/02/2002)
Aug 27 19:48:16 graphics kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 27 19:48:16 graphics kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Aug 27 19:48:16 graphics kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Aug 27 19:48:16 graphics kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 27 19:48:16 graphics kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 27 19:48:16 graphics kernel: IPv6 v0.8 for NET4.0
Aug 27 19:48:16 graphics kernel: IPv6 over IPv4 tunneling driver
Aug 27 19:48:16 graphics kernel: ds: no socket drivers loaded!
Aug 27 19:48:16 graphics kernel: kjournald starting.  Commit interval 5 seconds
Aug 27 19:48:16 graphics kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 27 19:48:16 graphics kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 27 19:48:16 graphics kernel: Mounted devfs on /dev
Aug 27 19:48:16 graphics kernel: Freeing unused kernel memory: 260k freed
Aug 27 19:48:16 graphics kernel: Adding Swap: 1951888k swap-space (priority -1)
Aug 27 19:48:16 graphics kernel: 3w-xxxx: scsi2: AEN: INFO: Initialization started: Unit #0.
Aug 27 19:48:16 graphics kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
Aug 27 19:48:16 graphics kernel: Intel(R) PRO/1000 Network Driver - version 3.0.16
Aug 27 19:48:16 graphics kernel: Copyright (c) 1999-2001 Intel Corporation.
Aug 27 19:48:16 graphics kernel: 
Aug 27 19:48:16 graphics kernel: Intel(R) PRO/1000 Network Connection
Aug 27 19:48:16 graphics kernel: eth0:  Mem:0xdffa0000  IRQ:9  Speed:1000 Mbps  Duplex:Full
Aug 27 19:48:16 graphics kernel: nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
Aug 27 19:48:16 graphics kernel: devfs_register(nvidiactl): could not append to parent, err: -17
Aug 27 19:48:16 graphics kernel: devfs_register(nvidia0): could not append to parent, err: -17
Aug 27 19:48:16 graphics kernel: i2c-core.o: i2c core module
Aug 27 19:48:16 graphics kernel: i2c-viapro.o version 2.6.4 (20020719)
Aug 27 19:48:16 graphics kernel: i2c-viapro.o: Found Via VT82C686A/B device
Aug 27 19:48:16 graphics kernel: i2c-core.o: adapter SMBus Via Pro adapter at 0400 registered as adapter 0.
Aug 27 19:48:16 graphics kernel: i2c-viapro.o: Via Pro SMBus detected and initialized
Aug 27 19:48:16 graphics kernel: i2c-proc.o version 2.6.1 (20010825)
Aug 27 19:48:16 graphics kernel: w83781d.o version 2.6.4 (20020719)
Aug 27 19:48:16 graphics kernel: i2c-core.o: driver W83781D sensor driver registered.
Aug 27 19:48:16 graphics kernel: kjournald starting.  Commit interval 5 seconds
Aug 27 19:48:16 graphics kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
Aug 27 19:48:16 graphics kernel: EXT3-fs: mounted filesystem with writeback data mode.
Aug 27 19:48:16 graphics kernel: kjournald starting.  Commit interval 5 seconds
Aug 27 19:48:16 graphics kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
Aug 27 19:48:16 graphics kernel: EXT3-fs: mounted filesystem with writeback data mode.
Aug 27 19:48:18 graphics kernel: snd: EMU10K1 soundcard #1 not found or device busy
Aug 27 19:48:22 graphics kernel: parport_pc: Via 686A parallel port disabled in BIOS
Aug 27 19:48:22 graphics kernel: lp: driver loaded but no devices found
Aug 27 19:48:24 graphics kernel: eth0: no IPv6 routers present
Aug 27 19:49:30 graphics kernel: 3w-xxxx: scsi2: AEN: INFO: Initialization started: Unit #0.
Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x1a
Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x4d
Aug 27 19:51:03 graphics kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 27 19:51:03 graphics kernel: hda: drive_cmd: error=0x04 { DriveStatusError }

As you may notice:
> Aug 27 19:49:30 graphics kernel: 3w-xxxx: scsi2: AEN: INFO: Initialization started: Unit #0.

That was an exception due to power failure before that boot.

> Aug 27 19:51:03 graphics kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 27 19:51:03 graphics kernel: hda: drive_cmd: error=0x04 { DriveStatusError }

That comes from smartsuite. Seems to be an bug in IBM-IDE drives, but
it seems to indicate no error. I will switch of smartd and check if
the errors persist (yet another idea)...

> Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x1a
> Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x4d
 
Well this is very strange. 3w-xxxx is the driver for the 3ware
raid. It's the up-to-date version. Where these errors come from I
don't know. Nothing found about that. 

Regards 
  Georg

-- 
______________________________________________________________
sent by gdemme@cs.uni-sb.de                    - Georg Demme - 
http://graphics.cs.uni-sb.de/~gdemme/    Tel: +49 681/302-3834
Universität des Saarlandes       -      Gebäude 36.1, Raum E15




