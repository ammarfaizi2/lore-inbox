Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTBQMm2>; Mon, 17 Feb 2003 07:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTBQMm2>; Mon, 17 Feb 2003 07:42:28 -0500
Received: from barclay.balt.net ([195.14.162.78]:59179 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S267042AbTBQMmV>;
	Mon, 17 Feb 2003 07:42:21 -0500
Subject: Oops on linux 2.5.60, 2.5.61 as well.
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-/7La+E1hYVsvG+Pn5CHa"
Organization: Gemtek Baltic
Message-Id: <1045486335.15969.21.camel@swoop.balt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 14:52:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/7La+E1hYVsvG+Pn5CHa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oopsing during X server restart (in this case, while running KDE 3.1 ,
on Debian unstable during logout)
 
-- 
Zilvinas Valinskas
Best regards

--=-/7La+E1hYVsvG+Pn5CHa
Content-Disposition: attachment; filename=kern.log
Content-Type: text/plain; name=kern.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Feb 16 21:16:18 swoop kernel: Linux version 2.5.61 (root@swoop) (gcc version 3.2.3 20030210 (Debian prerelease)) #1 Sun Feb 16 21:03:23 EET 2003
Feb 16 21:16:18 swoop kernel: Video mode to be used for restore is f00
Feb 16 21:16:18 swoop kernel: BIOS-provided physical RAM map:
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
Feb 16 21:16:18 swoop kernel:  BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
Feb 16 21:16:18 swoop kernel: 255MB LOWMEM available.
Feb 16 21:16:18 swoop kernel: ACPI: have wakeup address 0xc0001000
Feb 16 21:16:18 swoop kernel: On node 0 totalpages: 65488
Feb 16 21:16:18 swoop kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 16 21:16:18 swoop kernel:   Normal zone: 61392 pages, LIFO batch:14
Feb 16 21:16:18 swoop kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 16 21:16:18 swoop kernel: ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
Feb 16 21:16:18 swoop kernel: ACPI: RSDT (v001 COMPAQ CPQ004A  12297.00544) @ 0x0fff0c84
Feb 16 21:16:18 swoop kernel: ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x0fff0c00
Feb 16 21:16:18 swoop kernel: ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x0fff6508
Feb 16 21:16:18 swoop kernel: ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x0fff6616
Feb 16 21:16:18 swoop kernel: ACPI: DSDT (v001 COMPAQ  EVON800 00001.00000) @ 0x00000000
Feb 16 21:16:18 swoop kernel: ACPI: BIOS passes blacklist
Feb 16 21:16:18 swoop kernel: Building zonelist for node : 0
Feb 16 21:16:18 swoop kernel: Kernel command line: root=/dev/hda5 ro
Feb 16 21:16:18 swoop kernel: Initializing CPU#0
Feb 16 21:16:18 swoop kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Feb 16 21:16:18 swoop kernel: Detected 1694.249 MHz processor.
Feb 16 21:16:18 swoop kernel: Console: colour VGA+ 80x25
Feb 16 21:16:18 swoop kernel: Calibrating delay loop... 3342.33 BogoMIPS
Feb 16 21:16:18 swoop kernel: Memory: 256116k/261952k available (1686k kernel code, 5124k reserved, 560k data, 96k init, 0k highmem)
Feb 16 21:16:18 swoop kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Feb 16 21:16:18 swoop kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Feb 16 21:16:18 swoop kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 16 21:16:18 swoop kernel: -> /dev
Feb 16 21:16:18 swoop kernel: -> /dev/console
Feb 16 21:16:18 swoop kernel: -> /root
Feb 16 21:16:18 swoop kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb 16 21:16:18 swoop kernel: CPU: L2 cache: 512K
Feb 16 21:16:18 swoop kernel: CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
Feb 16 21:16:18 swoop kernel: Intel machine check architecture supported.
Feb 16 21:16:18 swoop kernel: Intel machine check reporting enabled on CPU#0.
Feb 16 21:16:18 swoop kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Feb 16 21:16:18 swoop kernel: Machine check exception polling timer started.
Feb 16 21:16:18 swoop kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz stepping 07
Feb 16 21:16:18 swoop kernel: Enabling fast FPU save and restore... done.
Feb 16 21:16:18 swoop kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 16 21:16:18 swoop kernel: Checking 'hlt' instruction... OK.
Feb 16 21:16:18 swoop kernel: POSIX conformance testing by UNIFIX
Feb 16 21:16:18 swoop kernel: Linux NET4.0 for Linux 2.4
Feb 16 21:16:18 swoop kernel: Based upon Swansea University Computer Society NET3.039
Feb 16 21:16:18 swoop kernel: Initializing RT netlink socket
Feb 16 21:16:18 swoop kernel: mtrr: v2.0 (20020519)
Feb 16 21:16:18 swoop kernel: PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
Feb 16 21:16:18 swoop kernel: PCI: Using configuration type 1
Feb 16 21:16:18 swoop kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Feb 16 21:16:18 swoop kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Feb 16 21:16:18 swoop kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Feb 16 21:16:18 swoop kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Feb 16 21:16:18 swoop kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Feb 16 21:16:18 swoop kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Feb 16 21:16:18 swoop kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Feb 16 21:16:18 swoop kernel: ACPI: Subsystem revision 20030122
Feb 16 21:16:18 swoop kernel:     ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
Feb 16 21:16:18 swoop kernel:     ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
Feb 16 21:16:18 swoop kernel: ACPI: Interpreter enabled
Feb 16 21:16:18 swoop kernel: ACPI: Using PIC for interrupt routing
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C140] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C154] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C158] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C15C] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C165] (on)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C0CF] (on)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C1D1] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C1D2] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C1D3] (off)
Feb 16 21:16:18 swoop kernel: ACPI: Power Resource [C1D4] (off)
Feb 16 21:16:18 swoop kernel: Linux Plug and Play Support v0.94 (c) Adam Belay
Feb 16 21:16:18 swoop kernel: pnp: Enabling Plug and Play Card Services.
Feb 16 21:16:18 swoop kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f3d30
Feb 16 21:16:18 swoop kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x3d5e, dseg 0xf0000
Feb 16 21:16:18 swoop kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Feb 16 21:16:18 swoop kernel: isapnp: Scanning for PnP cards...
Feb 16 21:16:18 swoop kernel: isapnp: No Plug & Play device found
Feb 16 21:16:18 swoop kernel: block request queues:
Feb 16 21:16:18 swoop kernel:  128 requests per read queue
Feb 16 21:16:18 swoop kernel:  128 requests per write queue
Feb 16 21:16:18 swoop kernel:  8 requests per batch
Feb 16 21:16:18 swoop kernel:  enter congestion at 15
Feb 16 21:16:18 swoop kernel:  exit congestion at 17
Feb 16 21:16:18 swoop kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb 16 21:16:18 swoop kernel: drivers/usb/core/usb.c: registered new driver hub
Feb 16 21:16:18 swoop kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
Feb 16 21:16:18 swoop kernel: PCI: Invalid ACPI-PCI IRQ routing table
Feb 16 21:16:18 swoop kernel: PCI: Probing PCI hardware
Feb 16 21:16:18 swoop kernel: PCI: Probing PCI hardware (bus 00)
Feb 16 21:16:18 swoop kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
Feb 16 21:16:18 swoop kernel: PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
Feb 16 21:16:18 swoop kernel: PCI: IRQ 0 for device 02:0e.1 doesn't match PIRQ mask - try pci=usepirqmask
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 10 for device 02:0e.1
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 16 21:16:18 swoop kernel: cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Feb 16 21:16:18 swoop kernel: Enabling SEP on CPU 0
Feb 16 21:16:18 swoop kernel: aio_setup: sizeof(struct page) = 40
Feb 16 21:16:18 swoop kernel: VFS: Disk quotas dquot_6.5.1
Feb 16 21:16:18 swoop kernel: Journalled Block Device driver loaded
Feb 16 21:16:18 swoop kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Feb 16 21:16:18 swoop kernel: devfs: boot_options: 0x1
Feb 16 21:16:18 swoop kernel: Initializing Cryptographic API
Feb 16 21:16:18 swoop kernel: ACPI: AC Adapter [C11A] (on-line)
Feb 16 21:16:18 swoop kernel: ACPI: Power Button (FF) [PWRF]
Feb 16 21:16:18 swoop kernel: ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
Feb 16 21:16:18 swoop kernel: ACPI: Thermal Zone [TZ1] (57 C)
Feb 16 21:16:18 swoop kernel: ACPI: Thermal Zone [TZ2] (48 C)
Feb 16 21:16:18 swoop kernel: ACPI: Thermal Zone [TZ3] (16 C)
Feb 16 21:16:18 swoop kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Feb 16 21:16:18 swoop kernel: parport0: irq 7 detected
Feb 16 21:16:18 swoop kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 16 21:16:18 swoop kernel: parport0: assign_addrs: aa5500ff(38)
Feb 16 21:16:18 swoop kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 16 21:16:18 swoop kernel: parport0: assign_addrs: aa5500ff(38)
Feb 16 21:16:18 swoop kernel: pty: 256 Unix98 ptys configured
Feb 16 21:16:18 swoop kernel: lp0: using parport0 (polling).
Feb 16 21:16:18 swoop kernel: Real Time Clock Driver v1.11
Feb 16 21:16:18 swoop kernel: Non-volatile memory driver v1.2
Feb 16 21:16:18 swoop kernel: Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Feb 16 21:16:18 swoop kernel: Copyright (c) 2002 Intel Corporation
Feb 16 21:16:18 swoop kernel: 
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 10 for device 02:08.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 16 21:16:18 swoop kernel: e100: selftest OK.
Feb 16 21:16:18 swoop kernel: Freeing alive device c134a000, eth%%d
Feb 16 21:16:18 swoop kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Feb 16 21:16:18 swoop kernel:   Hardware receive checksums enabled
Feb 16 21:16:18 swoop kernel: 
Feb 16 21:16:18 swoop kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 16 21:16:18 swoop kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 16 21:16:18 swoop kernel: ICH3M: IDE controller at PCI slot 00:1f.1
Feb 16 21:16:18 swoop kernel: PCI: Enabling device 00:1f.1 (0005 -> 0007)
Feb 16 21:16:18 swoop kernel: PCI: Assigned IRQ 11 for device 00:1f.1
Feb 16 21:16:18 swoop kernel: ICH3M: chipset revision 2
Feb 16 21:16:18 swoop kernel: ICH3M: not 100%% native mode: will probe irqs later
Feb 16 21:16:18 swoop kernel:     ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
Feb 16 21:16:18 swoop kernel:     ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
Feb 16 21:16:18 swoop kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Feb 16 21:16:18 swoop kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 16 21:16:18 swoop kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
Feb 16 21:16:18 swoop kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 16 21:16:18 swoop kernel: hda: host protected area => 1
Feb 16 21:16:18 swoop kernel: hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=77520/16/63, UDMA(100)
Feb 16 21:16:18 swoop kernel:  /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 p8 p9 p10 p11 > p2
Feb 16 21:16:18 swoop kernel: Linux Kernel Card Services 3.1.22
Feb 16 21:16:18 swoop kernel:   options:  [pci] [cardbus] [pm]
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 11 for device 02:06.0
Feb 16 21:16:18 swoop kernel: drivers/usb/core/usb.c: registered new driver hiddev
Feb 16 21:16:18 swoop kernel: drivers/usb/core/usb.c: registered new driver hid
Feb 16 21:16:18 swoop kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb 16 21:16:18 swoop kernel: mice: PS/2 mouse device common for all mice
Feb 16 21:16:18 swoop kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Feb 16 21:16:18 swoop kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb 16 21:16:18 swoop kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb 16 21:16:18 swoop kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb 16 21:16:18 swoop kernel: input: PS/2 Synaptics TouchPad on isa0060/serio4
Feb 16 21:16:18 swoop kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb 16 21:16:18 swoop kernel: input: AT Set 2 keyboard on isa0060/serio0
Feb 16 21:16:18 swoop kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 16 21:16:18 swoop kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 16 21:16:18 swoop kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 16 21:16:18 swoop kernel: TCP: Hash tables configured (established 16384 bind 32768)
Feb 16 21:16:18 swoop kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 16 21:16:18 swoop kernel: ACPI: (supports S0 S3 S4 S5)
Feb 16 21:16:18 swoop kernel: Yenta IRQ list 00d8, PCI irq11
Feb 16 21:16:18 swoop kernel: Socket status: 30000006
Feb 16 21:16:18 swoop kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Feb 16 21:16:18 swoop kernel: EXT3-fs: write access will be enabled during recovery.
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3-fs: recovery complete.
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb 16 21:16:18 swoop kernel: Mounted devfs on /dev
Feb 16 21:16:18 swoop kernel: Freeing unused kernel memory: 96k freed
Feb 16 21:16:18 swoop kernel: Adding 997880k swap on /dev/ide/host0/bus0/target0/lun0/part7.  Priority:-1 extents:1
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 5 for device 00:1f.5
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 5 with 02:04.0
Feb 16 21:16:18 swoop kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Feb 16 21:16:18 swoop kernel: intel8x0: clocking to 48000
Feb 16 21:16:18 swoop kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb 16 21:16:18 swoop kernel: agpgart: Detected Intel i845 chipset
Feb 16 21:16:18 swoop kernel: agpgart: Maximum main memory to use for agp memory: 203M
Feb 16 21:16:18 swoop kernel: agpgart: AGP aperture is 256M @ 0x60000000
Feb 16 21:16:18 swoop kernel: [drm] Initialized radeon 1.7.0 20020828 on minor 0
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,11), internal journal
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 16 21:16:18 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
Feb 16 21:16:18 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 16 21:16:18 swoop kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 10 for device 02:0e.2
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 16 21:16:18 swoop kernel: ehci-hcd 02:0e.2: NEC Corporation USB 2.0
Feb 16 21:16:18 swoop kernel: ehci-hcd 02:0e.2: irq 10, pci mem d08bb000
Feb 16 21:16:18 swoop kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Feb 16 21:16:18 swoop kernel: ehci-hcd 02:0e.2: new USB bus registered, assigned bus number 1
Feb 16 21:16:18 swoop kernel: PCI: 02:0e.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW, correcting to 128
Feb 16 21:16:18 swoop kernel: ehci-hcd 02:0e.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jan-22
Feb 16 21:16:18 swoop kernel: hub 1-0:0: USB hub found
Feb 16 21:16:18 swoop kernel: hub 1-0:0: 5 ports detected
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 10 for device 02:0e.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.0: NEC Corporation USB
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.0: irq 10, pci mem d08e4000
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.0: new USB bus registered, assigned bus number 2
Feb 16 21:16:18 swoop kernel: hub 2-0:0: USB hub found
Feb 16 21:16:18 swoop kernel: hub 2-0:0: 3 ports detected
Feb 16 21:16:18 swoop kernel: PCI: Found IRQ 10 for device 02:0e.1
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 16 21:16:18 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.1: NEC Corporation USB (#2)
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.1: irq 10, pci mem d0931000
Feb 16 21:16:18 swoop kernel: ohci-hcd 02:0e.1: new USB bus registered, assigned bus number 3
Feb 16 21:16:18 swoop kernel: hub 3-0:0: USB hub found
Feb 16 21:16:18 swoop kernel: hub 3-0:0: 2 ports detected
Feb 16 21:16:18 swoop kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0800-0x08ff: clean.
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3e8-0x3ff 0x4d0-0x4d7
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 16 21:16:44 swoop kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
Feb 16 21:16:45 swoop kernel: hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Feb 16 21:16:45 swoop kernel: hub 2-0:0: new USB device on port 1, assigned address 2
Feb 16 21:16:45 swoop kernel: drivers/usb/input/hid-core.c: ctrl urb status -75 received
Feb 16 21:16:45 swoop kernel: input: USB HID v1.10 Mouse [Combo Mouse Combo Mouse] on usb-02:0e.0-1
Feb 16 21:17:21 swoop kernel: agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
Feb 16 21:17:21 swoop kernel: agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
Feb 16 21:20:06 swoop kernel: agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
Feb 16 21:20:06 swoop kernel: agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
Feb 16 21:20:06 swoop kernel: Unable to handle kernel paging request at virtual address 1900ff8d
Feb 16 21:20:06 swoop kernel:  printing eip:
Feb 16 21:20:06 swoop kernel: c015e30f
Feb 16 21:20:06 swoop kernel: *pde = 00000000
Feb 16 21:20:06 swoop kernel: Oops: 0000
Feb 16 21:20:06 swoop kernel: CPU:    0
Feb 16 21:20:06 swoop kernel: EIP:    0060:[fasync_helper+57/238]    Not tainted
Feb 16 21:20:06 swoop kernel: EFLAGS: 00013006
Feb 16 21:20:06 swoop kernel: eax: cd1d6000   ebx: 00000000   ecx: ca2a7fac   edx: 1900ff81
Feb 16 21:20:06 swoop kernel: esi: c9008180   edi: ca2a7fac   ebp: 00000000   esp: cd1d7f30
Feb 16 21:20:06 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 21:20:06 swoop kernel: Process X (pid: 1295, threadinfo=cd1d6000 task=cec8ac80)
Feb 16 21:20:06 swoop kernel: Stack: 00030002 00fffffd 00000000 c0804b68 c0804b00 c0804b00 c1bc7580 c01595a3 
Feb 16 21:20:06 swoop kernel:        ffffffff c9008180 00000000 ca2a7fac c9008180 cffca600 c01596c0 ffffffff 
Feb 16 21:20:06 swoop kernel:        c9008180 00000000 c014e76c c0804b00 c9008180 c9008180 00000000 cfc6a680 
Feb 16 21:20:06 swoop kernel: Call Trace: [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 
Feb 16 21:20:06 swoop kernel: Code: 39 72 0c 74 54 8d 4a 08 8b 52 08 85 d2 75 f1 85 ed 74 1f c7 
Feb 16 21:20:06 swoop kernel:  <6>note: X[1295] exited with preempt_count 1
Feb 16 21:20:06 swoop kernel: general protection fault: 0000
Feb 16 21:20:06 swoop kernel: CPU:    0
Feb 16 21:20:06 swoop kernel: EIP:    0060:[page_remove_rmap+190/311]    Not tainted
Feb 16 21:20:06 swoop kernel: EFLAGS: 00013286
Feb 16 21:20:06 swoop kernel: eax: fefdefff   ebx: c11b19a8   ecx: 0000001f   edx: ffffffff
Feb 16 21:20:06 swoop kernel: esi: cd2c0120   edi: 00000000   ebp: ffffffff   esp: cd1d7d10
Feb 16 21:20:06 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 21:20:06 swoop kernel: Process X (pid: 1295, threadinfo=cd1d6000 task=cec8ac80)
Feb 16 21:20:06 swoop kernel: Stack: 39336333 ca2b4c80 cd2c0120 00000000 000d0000 c11b19a8 c013f118 cd1d6000 
Feb 16 21:20:06 swoop kernel:        cd1d6000 00000000 00000000 0ad71025 c7398084 08448000 08118000 c034ce78 
Feb 16 21:20:06 swoop kernel:        c013f1ae c034ce78 c7398080 08048000 000d0000 08048000 c7398084 08118000 
Feb 16 21:20:06 swoop kernel: Call Trace: [zap_pte_range+330/409]  [zap_pmd_range+71/99]  [unmap_page_range+67/105]  [unmap_vmas+197/521]  [exit_mmap+124/399]  [mmput+86/165]  [do_exit+263/752]  [die+135/142]  [do_page_fault+330/1107]  [__alloc_pages+146/686]  [invalidate_vcache+53/186]  [do_wp_page+462/895]  [do_page_fault+0/1107]  [error_code+45/56]  [fasync_helper+57/238]  [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 
Feb 16 21:20:06 swoop kernel: Code: 8b 2a 85 ed 74 04 0f 18 45 00 31 c9 8b 44 8a 04 85 c0 74 0a 
Feb 16 21:20:06 swoop kernel:  <6>note: X[1295] exited with preempt_count 3
Feb 16 21:20:06 swoop kernel: bad: scheduling while atomic!
Feb 16 21:20:06 swoop kernel: Call Trace: [schedule+768/773]  [__down+153/258]  [default_wake_function+0/18]  [__down_failed+8/12]  [.text.lock.pipe+85/200]  [pipe_read_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [put_files_struct+134/235]  [do_exit+314/752]  [do_general_protection+0/158]  [die+135/142]  [do_general_protection+75/158]  [error_code+45/56]  [page_remove_rmap+190/311]  [zap_pte_range+330/409]  [zap_pmd_range+71/99]  [unmap_page_range+67/105]  [unmap_vmas+197/521]  [exit_mmap+124/399]  [mmput+86/165]  [do_exit+263/752]  [die+135/142]  [do_page_fault+330/1107]  [__alloc_pages+146/686]  [invalidate_vcache+53/186]  [do_wp_page+462/895]  [do_page_fault+0/1107]  [error_code+45/56]  [fasync_helper+57/238]  [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 
Feb 16 21:20:48 swoop kernel: SysRq : Emergency Sync
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,5) ... OK
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,11) ... OK
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,6) ... OK
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,8) ... OK
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,9) ... OK
Feb 16 21:20:48 swoop kernel: Syncing device ide0(3,10) ... OK
Feb 16 21:20:48 swoop kernel: Done.
Feb 16 21:20:50 swoop kernel: SysRq : Emergency Remount R/O
Feb 16 21:20:50 swoop kernel: Remounting device ide0(3,5) ... OK
Feb 16 21:20:50 swoop kernel: Remounting device ide0(3,11) ... OK
Feb 16 21:20:50 swoop kernel: Remounting device ide0(3,6) ... OK
Feb 16 21:20:50 swoop kernel: Remounting device ide0(3,8) ... OK

--=-/7La+E1hYVsvG+Pn5CHa
Content-Disposition: attachment; filename=ksyms_kern.log
Content-Type: text/plain; name=ksyms_kern.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.8 on i686 2.5.61.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.61/ (default)
     -m /boot/System.map-2.5.61 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb 16 21:16:18 swoop kernel: Machine check exception polling timer started.
Feb 16 21:16:18 swoop kernel: e100: selftest OK.
Feb 16 21:16:18 swoop kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0800-0x08ff: clean.
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3e8-0x3ff 0x4d0-0x4d7
Feb 16 21:16:25 swoop kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 16 21:20:06 swoop kernel: Unable to handle kernel paging request at virtual address 1900ff8d
Feb 16 21:20:06 swoop kernel: c015e30f
Feb 16 21:20:06 swoop kernel: *pde = 00000000
Feb 16 21:20:06 swoop kernel: Oops: 0000
Feb 16 21:20:06 swoop kernel: CPU:    0
Feb 16 21:20:06 swoop kernel: EIP:    0060:[fasync_helper+57/238]    Not tainted
Feb 16 21:20:06 swoop kernel: EFLAGS: 00013006
Feb 16 21:20:06 swoop kernel: eax: cd1d6000   ebx: 00000000   ecx: ca2a7fac   edx: 1900ff81
Feb 16 21:20:06 swoop kernel: esi: c9008180   edi: ca2a7fac   ebp: 00000000   esp: cd1d7f30
Feb 16 21:20:06 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 21:20:06 swoop kernel: Stack: 00030002 00fffffd 00000000 c0804b68 c0804b00 c0804b00 c1bc7580 c01595a3 
Feb 16 21:20:06 swoop kernel:        ffffffff c9008180 00000000 ca2a7fac c9008180 cffca600 c01596c0 ffffffff 
Feb 16 21:20:06 swoop kernel:        c9008180 00000000 c014e76c c0804b00 c9008180 c9008180 00000000 cfc6a680 
Feb 16 21:20:06 swoop kernel: Call Trace: [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 
Feb 16 21:20:06 swoop kernel: Code: 39 72 0c 74 54 8d 4a 08 8b 52 08 85 d2 75 f1 85 ed 74 1f c7 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 72 0c                  cmp    %esi,0xc(%edx)
Code;  00000003 Before first symbol
   3:   74 54                     je     59 <_EIP+0x59>
Code;  00000005 Before first symbol
   5:   8d 4a 08                  lea    0x8(%edx),%ecx
Code;  00000008 Before first symbol
   8:   8b 52 08                  mov    0x8(%edx),%edx
Code;  0000000b Before first symbol
   b:   85 d2                     test   %edx,%edx
Code;  0000000d Before first symbol
   d:   75 f1                     jne    0 <_EIP>
Code;  0000000f Before first symbol
   f:   85 ed                     test   %ebp,%ebp
Code;  00000011 Before first symbol
  11:   74 1f                     je     32 <_EIP+0x32>
Code;  00000013 Before first symbol
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)

Feb 16 21:20:06 swoop kernel: CPU:    0
Feb 16 21:20:06 swoop kernel: EIP:    0060:[page_remove_rmap+190/311]    Not tainted
Feb 16 21:20:06 swoop kernel: EFLAGS: 00013286
Feb 16 21:20:06 swoop kernel: eax: fefdefff   ebx: c11b19a8   ecx: 0000001f   edx: ffffffff
Feb 16 21:20:06 swoop kernel: esi: cd2c0120   edi: 00000000   ebp: ffffffff   esp: cd1d7d10
Feb 16 21:20:06 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 21:20:06 swoop kernel: Stack: 39336333 ca2b4c80 cd2c0120 00000000 000d0000 c11b19a8 c013f118 cd1d6000 
Feb 16 21:20:06 swoop kernel:        cd1d6000 00000000 00000000 0ad71025 c7398084 08448000 08118000 c034ce78 
Feb 16 21:20:06 swoop kernel:        c013f1ae c034ce78 c7398080 08048000 000d0000 08048000 c7398084 08118000 
Feb 16 21:20:06 swoop kernel: Call Trace: [zap_pte_range+330/409]  [zap_pmd_range+71/99]  [unmap_page_range+67/105]  [unmap_vmas+197/521]  [exit_mmap+124/399]  [mmput+86/165]  [do_exit+263/752]  [die+135/142]  [do_page_fault+330/1107]  [__alloc_pages+146/686]  [invalidate_vcache+53/186]  [do_wp_page+462/895]  [do_page_fault+0/1107]  [error_code+45/56]  [fasync_helper+57/238]  [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 
Feb 16 21:20:06 swoop kernel: Code: 8b 2a 85 ed 74 04 0f 18 45 00 31 c9 8b 44 8a 04 85 c0 74 0a 


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 2a                     mov    (%edx),%ebp
Code;  00000002 Before first symbol
   2:   85 ed                     test   %ebp,%ebp
Code;  00000004 Before first symbol
   4:   74 04                     je     a <_EIP+0xa>
Code;  00000006 Before first symbol
   6:   0f 18 45 00               prefetchnta 0x0(%ebp)
Code;  0000000a Before first symbol
   a:   31 c9                     xor    %ecx,%ecx
Code;  0000000c Before first symbol
   c:   8b 44 8a 04               mov    0x4(%edx,%ecx,4),%eax
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   74 0a                     je     1e <_EIP+0x1e>

Feb 16 21:20:06 swoop kernel: Call Trace: [schedule+768/773]  [__down+153/258]  [default_wake_function+0/18]  [__down_failed+8/12]  [.text.lock.pipe+85/200]  [pipe_read_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [put_files_struct+134/235]  [do_exit+314/752]  [do_general_protection+0/158]  [die+135/142]  [do_general_protection+75/158]  [error_code+45/56]  [page_remove_rmap+190/311]  [zap_pte_range+330/409]  [zap_pmd_range+71/99]  [unmap_page_range+67/105]  [unmap_vmas+197/521]  [exit_mmap+124/399]  [mmput+86/165]  [do_exit+263/752]  [die+135/142]  [do_page_fault+330/1107]  [__alloc_pages+146/686]  [invalidate_vcache+53/186]  [do_wp_page+462/895]  [do_page_fault+0/1107]  [error_code+45/56]  [fasync_helper+57/238]  [pipe_write_fasync+72/104]  [pipe_write_release+31/63]  [__fput+227/235]  [filp_close+119/153]  [sys_close+100/152]  [syscall_call+7/11] 

1 warning and 1 error issued.  Results may not be reliable.

--=-/7La+E1hYVsvG+Pn5CHa--

