Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTBYJgy>; Tue, 25 Feb 2003 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTBYJgy>; Tue, 25 Feb 2003 04:36:54 -0500
Received: from barclay.balt.net ([195.14.162.78]:6137 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S267869AbTBYJgp>;
	Tue, 25 Feb 2003 04:36:45 -0500
Date: Tue, 25 Feb 2003 11:45:26 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Andrew Morton <akpm@digeo.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.62-mm3 - no X for me
Message-ID: <20030225094526.GA18857@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20030223230023.365782f3.akpm@digeo.com> <3E5A0F8D.4010202@aitel.hist.no> <20030224121601.2c998cc5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20030224121601.2c998cc5.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2003 at 12:16:01PM -0800, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> > 2.5.62-mm3 boots up fine, but won't run X.  Something goes
> > wrong switching to graphics so my monitor says "no signal"
> > 
>
This is the boot messages and decoded ksymoops which happens when I try
to log off and login as a different user in KDE3.1 (debian/unstable).


> Does 2.5.63 do the same thing?
I haven't tried this yet.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.62-mm3"

Feb 24 10:42:11 swoop kernel: Linux version 2.5.62-mm3 (root@swoop) (gcc version 3.2.3 20030221 (Debian prerelease)) #1 Mon Feb 24 10:19:49 EET 2003
Feb 24 10:42:11 swoop kernel: Video mode to be used for restore is f00
Feb 24 10:42:11 swoop kernel: BIOS-provided physical RAM map:
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
Feb 24 10:42:11 swoop kernel:  BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
Feb 24 10:42:11 swoop kernel: 255MB LOWMEM available.
Feb 24 10:42:11 swoop kernel: On node 0 totalpages: 65488
Feb 24 10:42:11 swoop kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 24 10:42:11 swoop kernel:   Normal zone: 61392 pages, LIFO batch:14
Feb 24 10:42:11 swoop kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 24 10:42:11 swoop kernel: ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
Feb 24 10:42:11 swoop kernel: ACPI: RSDT (v001 COMPAQ CPQ004A  08721.00544) @ 0x0fff0c84
Feb 24 10:42:11 swoop kernel: ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x0fff0c00
Feb 24 10:42:11 swoop kernel: ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x0fff65d4
Feb 24 10:42:11 swoop kernel: ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x0fff66e2
Feb 24 10:42:11 swoop kernel: ACPI: DSDT (v001 COMPAQ  EVON800 00001.00000) @ 0x00000000
Feb 24 10:42:11 swoop kernel: ACPI: BIOS passes blacklist
Feb 24 10:42:11 swoop kernel: Building zonelist for node : 0
Feb 24 10:42:11 swoop kernel: Kernel command line: root=/dev/hda5 ro single
Feb 24 10:42:11 swoop kernel: Initializing CPU#0
Feb 24 10:42:11 swoop kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Feb 24 10:42:11 swoop kernel: Detected 1694.314 MHz processor.
Feb 24 10:42:11 swoop kernel: Console: colour VGA+ 80x25
Feb 24 10:42:11 swoop kernel: Calibrating delay loop... 3342.33 BogoMIPS
Feb 24 10:42:11 swoop kernel: Memory: 256188k/261952k available (1606k kernel code, 5052k reserved, 553k data, 112k init, 0k highmem)
Feb 24 10:42:11 swoop kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Feb 24 10:42:11 swoop kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Feb 24 10:42:11 swoop kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 24 10:42:11 swoop kernel: -> /dev
Feb 24 10:42:11 swoop kernel: -> /dev/console
Feb 24 10:42:11 swoop kernel: -> /root
Feb 24 10:42:11 swoop kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb 24 10:42:11 swoop kernel: CPU: L2 cache: 512K
Feb 24 10:42:11 swoop kernel: CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
Feb 24 10:42:11 swoop kernel: Intel machine check architecture supported.
Feb 24 10:42:11 swoop kernel: Intel machine check reporting enabled on CPU#0.
Feb 24 10:42:11 swoop kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Feb 24 10:42:11 swoop kernel: Machine check exception polling timer started.
Feb 24 10:42:11 swoop kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz stepping 07
Feb 24 10:42:11 swoop kernel: Enabling fast FPU save and restore... done.
Feb 24 10:42:11 swoop kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 24 10:42:11 swoop kernel: Checking 'hlt' instruction... OK.
Feb 24 10:42:11 swoop kernel: POSIX conformance testing by UNIFIX
Feb 24 10:42:11 swoop kernel: Linux NET4.0 for Linux 2.4
Feb 24 10:42:11 swoop kernel: Based upon Swansea University Computer Society NET3.039
Feb 24 10:42:11 swoop kernel: Initializing RT netlink socket
Feb 24 10:42:11 swoop kernel: mtrr: v2.0 (20020519)
Feb 24 10:42:11 swoop kernel: PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
Feb 24 10:42:11 swoop kernel: PCI: Using configuration type 1
Feb 24 10:42:11 swoop kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Feb 24 10:42:11 swoop kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Feb 24 10:42:11 swoop kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Feb 24 10:42:11 swoop kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Feb 24 10:42:11 swoop kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Feb 24 10:42:11 swoop kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Feb 24 10:42:11 swoop kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Feb 24 10:42:11 swoop kernel: ACPI: Subsystem revision 20030122
Feb 24 10:42:11 swoop kernel: ACPI: Interpreter enabled
Feb 24 10:42:11 swoop kernel: ACPI: Using PIC for interrupt routing
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C141] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C155] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C159] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C15D] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C166] (on)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C0CF] (on)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C1D5] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C1D6] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C1D7] (off)
Feb 24 10:42:11 swoop kernel: ACPI: Power Resource [C1D8] (off)
Feb 24 10:42:11 swoop kernel: Linux Plug and Play Support v0.95 (c) Adam Belay
Feb 24 10:42:11 swoop kernel: pnp: Enabling Plug and Play Card Services.
Feb 24 10:42:11 swoop kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f3d30
Feb 24 10:42:11 swoop kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x3d5e, dseg 0xf0000
Feb 24 10:42:11 swoop kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Feb 24 10:42:11 swoop kernel: block request queues:
Feb 24 10:42:11 swoop kernel:  128 requests per read queue
Feb 24 10:42:11 swoop kernel:  128 requests per write queue
Feb 24 10:42:11 swoop kernel:  8 requests per batch
Feb 24 10:42:11 swoop kernel:  enter congestion at 15
Feb 24 10:42:11 swoop kernel:  exit congestion at 17
Feb 24 10:42:11 swoop kernel: Linux Kernel Card Services 3.1.22
Feb 24 10:42:11 swoop kernel:   options:  [pci] [cardbus] [pm]
Feb 24 10:42:11 swoop kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb 24 10:42:11 swoop kernel: drivers/usb/core/usb.c: registered new driver hub
Feb 24 10:42:11 swoop kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
Feb 24 10:42:11 swoop kernel: PCI: Invalid ACPI-PCI IRQ routing table
Feb 24 10:42:11 swoop kernel: PCI: Probing PCI hardware
Feb 24 10:42:11 swoop kernel: PCI: Probing PCI hardware (bus 00)
Feb 24 10:42:11 swoop kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
Feb 24 10:42:11 swoop kernel: PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
Feb 24 10:42:11 swoop kernel: PCI: IRQ 0 for device 02:0e.1 doesn't match PIRQ mask - try pci=usepirqmask
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 10 for device 02:0e.1
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 24 10:42:11 swoop kernel: PCI: Cannot allocate resource region 0 of device 02:0e.2
Feb 24 10:42:11 swoop kernel: cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Feb 24 10:42:11 swoop kernel: Enabling SEP on CPU 0
Feb 24 10:42:11 swoop kernel: aio_setup: sizeof(struct page) = 40
Feb 24 10:42:11 swoop kernel: VFS: Disk quotas dquot_6.5.1
Feb 24 10:42:11 swoop kernel: Journalled Block Device driver loaded
Feb 24 10:42:11 swoop kernel: Initializing Cryptographic API
Feb 24 10:42:11 swoop kernel: ACPI: AC Adapter [C11B] (on-line)
Feb 24 10:42:11 swoop kernel: ACPI: Power Button (FF) [PWRF]
Feb 24 10:42:11 swoop kernel: ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
Feb 24 10:42:11 swoop kernel: ACPI: Thermal Zone [TZ1] (46 C)
Feb 24 10:42:11 swoop kernel: ACPI: Thermal Zone [TZ2] (40 C)
Feb 24 10:42:11 swoop kernel: ACPI: Thermal Zone [TZ3] (16 C)
Feb 24 10:42:11 swoop kernel: isapnp: Scanning for PnP cards...
Feb 24 10:42:11 swoop kernel: isapnp: No Plug & Play device found
Feb 24 10:42:11 swoop kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Feb 24 10:42:11 swoop kernel: parport0: irq 7 detected
Feb 24 10:42:11 swoop kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 24 10:42:11 swoop kernel: parport0: assign_addrs: aa5500ff(38)
Feb 24 10:42:11 swoop kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 24 10:42:11 swoop kernel: parport0: assign_addrs: aa5500ff(38)
Feb 24 10:42:11 swoop kernel: pty: 256 Unix98 ptys configured
Feb 24 10:42:11 swoop kernel: lp0: using parport0 (polling).
Feb 24 10:42:11 swoop kernel: Real Time Clock Driver v1.11
Feb 24 10:42:11 swoop kernel: Non-volatile memory driver v1.2
Feb 24 10:42:11 swoop kernel: Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Feb 24 10:42:11 swoop kernel: Copyright (c) 2002 Intel Corporation
Feb 24 10:42:11 swoop kernel: 
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 10 for device 02:08.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 24 10:42:11 swoop kernel: e100: selftest OK.
Feb 24 10:42:11 swoop kernel: Freeing alive device c1336000, eth%%d
Feb 24 10:42:11 swoop kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Feb 24 10:42:11 swoop kernel:   Hardware receive checksums enabled
Feb 24 10:42:11 swoop kernel: 
Feb 24 10:42:11 swoop kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 24 10:42:11 swoop kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 24 10:42:11 swoop kernel: ICH3M: IDE controller at PCI slot 00:1f.1
Feb 24 10:42:11 swoop kernel: PCI: Enabling device 00:1f.1 (0005 -> 0007)
Feb 24 10:42:11 swoop kernel: PCI: Assigned IRQ 11 for device 00:1f.1
Feb 24 10:42:11 swoop kernel: ICH3M: chipset revision 2
Feb 24 10:42:11 swoop kernel: ICH3M: not 100%% native mode: will probe irqs later
Feb 24 10:42:11 swoop kernel:     ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
Feb 24 10:42:11 swoop kernel:     ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
Feb 24 10:42:11 swoop kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Feb 24 10:42:11 swoop kernel: anticipatory scheduling elevator
Feb 24 10:42:11 swoop kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 24 10:42:11 swoop kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
Feb 24 10:42:11 swoop kernel: anticipatory scheduling elevator
Feb 24 10:42:11 swoop kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 24 10:42:11 swoop kernel: hda: host protected area => 1
Feb 24 10:42:11 swoop kernel: hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=77520/16/63, UDMA(100)
Feb 24 10:42:11 swoop kernel:  /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 p8 p9 p10 p11 > p2
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 11 for device 02:06.0
Feb 24 10:42:11 swoop kernel: Yenta IRQ list 00d8, PCI irq11
Feb 24 10:42:11 swoop kernel: Socket status: 30000006
Feb 24 10:42:11 swoop kernel: drivers/usb/core/usb.c: registered new driver hiddev
Feb 24 10:42:11 swoop kernel: drivers/usb/core/usb.c: registered new driver hid
Feb 24 10:42:11 swoop kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb 24 10:42:11 swoop kernel: mice: PS/2 mouse device common for all mice
Feb 24 10:42:11 swoop kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Feb 24 10:42:11 swoop kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb 24 10:42:11 swoop kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb 24 10:42:11 swoop kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb 24 10:42:11 swoop kernel: input: PS/2 Synaptics TouchPad on isa0060/serio4
Feb 24 10:42:11 swoop kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb 24 10:42:11 swoop kernel: input: AT Set 2 keyboard on isa0060/serio0
Feb 24 10:42:11 swoop kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 24 10:42:11 swoop kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 24 10:42:11 swoop kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 24 10:42:11 swoop kernel: TCP: Hash tables configured (established 16384 bind 32768)
Feb 24 10:42:11 swoop kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb 24 10:42:11 swoop kernel: Mounted devfs on /dev
Feb 24 10:42:11 swoop kernel: Freeing unused kernel memory: 112k freed
Feb 24 10:42:11 swoop kernel: Adding 997880k swap on /dev/ide/host0/bus0/target0/lun0/part7.  Priority:-1 extents:1
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 5 for device 00:1f.5
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 5 with 02:04.0
Feb 24 10:42:11 swoop kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Feb 24 10:42:11 swoop kernel: intel8x0: clocking to 48000
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,11), internal journal
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 10:42:11 swoop kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
Feb 24 10:42:11 swoop kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 24 10:42:11 swoop kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 10 for device 02:0e.2
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 24 10:42:11 swoop kernel: ehci-hcd 02:0e.2: NEC Corporation USB 2.0
Feb 24 10:42:11 swoop kernel: ehci-hcd 02:0e.2: irq 10, pci mem d08dd400
Feb 24 10:42:11 swoop kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Feb 24 10:42:11 swoop kernel: ehci-hcd 02:0e.2: new USB bus registered, assigned bus number 1
Feb 24 10:42:11 swoop kernel: PCI: 02:0e.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW, correcting to 128
Feb 24 10:42:11 swoop kernel: ehci-hcd 02:0e.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jan-22
Feb 24 10:42:11 swoop kernel: hub 1-0:0: USB hub found
Feb 24 10:42:11 swoop kernel: hub 1-0:0: 5 ports detected
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 10 for device 02:0e.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.1
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.0: NEC Corporation USB
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.0: irq 10, pci mem d08ea000
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.0: new USB bus registered, assigned bus number 2
Feb 24 10:42:11 swoop kernel: hub 2-0:0: USB hub found
Feb 24 10:42:11 swoop kernel: hub 2-0:0: 3 ports detected
Feb 24 10:42:11 swoop kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
Feb 24 10:42:11 swoop kernel: hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Feb 24 10:42:11 swoop kernel: hub 2-0:0: new USB device on port 1, assigned address 2
Feb 24 10:42:11 swoop kernel: usb 2-1: failed to set device 2 default configuration (error=-32)
Feb 24 10:42:11 swoop kernel: PCI: Found IRQ 10 for device 02:0e.1
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:08.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.0
Feb 24 10:42:11 swoop kernel: PCI: Sharing IRQ 10 with 02:0e.2
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.1: NEC Corporation USB (#2)
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.1: irq 10, pci mem d08ec000
Feb 24 10:42:11 swoop kernel: ohci-hcd 02:0e.1: new USB bus registered, assigned bus number 3
Feb 24 10:42:11 swoop kernel: hub 2-0:0: new USB device on port 1, assigned address 3
Feb 24 10:42:11 swoop kernel: drivers/usb/core/config.c: unable to get descriptor
Feb 24 10:42:11 swoop kernel: usb 2-1: unable to get device 3 configuration (error=-32)
Feb 24 10:42:11 swoop kernel: hub 3-0:0: USB hub found
Feb 24 10:42:11 swoop kernel: hub 3-0:0: 2 ports detected
Feb 24 10:42:11 swoop kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Feb 24 10:42:11 swoop kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0800-0x08ff: clean.
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3e8-0x3ff 0x4d0-0x4d7
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 24 10:42:34 swoop kernel: [drm] Initialized radeon 1.7.0 20020828 on minor 0
Feb 24 10:42:34 swoop kernel: ------------[ cut here ]------------
Feb 24 10:42:34 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:34 swoop kernel: invalid operand: 0000
Feb 24 10:42:34 swoop kernel: CPU:    0
Feb 24 10:42:34 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:34 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:34 swoop kernel: eax: 00000000   ebx: c119ae38   ecx: ca476400   edx: cb0a2048
Feb 24 10:42:34 swoop kernel: esi: cb0a2048   edi: cb9dfa80   ebp: c119ae38   esp: cb06fea0
Feb 24 10:42:34 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:34 swoop kernel: Process X (pid: 1438, threadinfo=cb06e000 task=cb119380)
Feb 24 10:42:34 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cb9dfa80 
Feb 24 10:42:34 swoop kernel:        cb9dfa80 ca476400 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:34 swoop kernel:        40012000 c0138fc7 cb5e1080 cb9dfa80 40012000 00000001 cb0a2048 cb0eb400 
Feb 24 10:42:34 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:34 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 
Feb 24 10:42:36 swoop kernel:  ------------[ cut here ]------------
Feb 24 10:42:36 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:36 swoop kernel: invalid operand: 0000
Feb 24 10:42:36 swoop kernel: CPU:    0
Feb 24 10:42:36 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:36 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:36 swoop kernel: eax: 00000000   ebx: c11a6b70   ecx: ca476580   edx: cad50048
Feb 24 10:42:36 swoop kernel: esi: cad50048   edi: cb9df900   ebp: c11a6b70   esp: cad19ea0
Feb 24 10:42:36 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:36 swoop kernel: Process X (pid: 1474, threadinfo=cad18000 task=caea4c80)
Feb 24 10:42:36 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cb9df900 
Feb 24 10:42:36 swoop kernel:        cb9df900 ca476580 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:36 swoop kernel:        40012000 c0138fc7 cb5e1080 cb9df900 40012000 00000001 cad50048 cb0eb400 
Feb 24 10:42:36 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:36 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 
Feb 24 10:42:38 swoop kernel:  ------------[ cut here ]------------
Feb 24 10:42:38 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:38 swoop kernel: invalid operand: 0000
Feb 24 10:42:38 swoop kernel: CPU:    0
Feb 24 10:42:38 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:38 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:38 swoop kernel: eax: 00000000   ebx: c11a95a0   ecx: ca476600   edx: cac1b048
Feb 24 10:42:38 swoop kernel: esi: cac1b048   edi: cbd73a80   ebp: c11a95a0   esp: cb091ea0
Feb 24 10:42:38 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:38 swoop kernel: Process X (pid: 1484, threadinfo=cb090000 task=cb119380)
Feb 24 10:42:38 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cbd73a80 
Feb 24 10:42:38 swoop kernel:        cbd73a80 ca476600 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:38 swoop kernel:        40012000 c0138fc7 cb5e1080 cbd73a80 40012000 00000001 cac1b048 cb0eb400 
Feb 24 10:42:38 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:38 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 
Feb 24 10:42:40 swoop kernel:  ------------[ cut here ]------------
Feb 24 10:42:40 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:40 swoop kernel: invalid operand: 0000
Feb 24 10:42:40 swoop kernel: CPU:    0
Feb 24 10:42:40 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:40 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:40 swoop kernel: eax: 00000000   ebx: c119db38   ecx: ca476680   edx: cac62048
Feb 24 10:42:40 swoop kernel: esi: cac62048   edi: cd3fa5c0   ebp: c119db38   esp: cad43ea0
Feb 24 10:42:40 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:40 swoop kernel: Process X (pid: 1494, threadinfo=cad42000 task=caea4c80)
Feb 24 10:42:40 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cd3fa5c0 
Feb 24 10:42:40 swoop kernel:        cd3fa5c0 ca476680 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:40 swoop kernel:        40012000 c0138fc7 cb5e1080 cd3fa5c0 40012000 00000001 cac62048 cb0eb400 
Feb 24 10:42:40 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:40 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 
Feb 24 10:43:13 swoop kernel:  <6>SysRq : Emergency Sync
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,5) ... OK
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,11) ... OK
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,6) ... OK
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,8) ... OK
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,9) ... OK
Feb 24 10:43:13 swoop kernel: Syncing device ide0(3,10) ... OK
Feb 24 10:43:13 swoop kernel: Done.
Feb 24 10:43:14 swoop kernel: SysRq : Emergency Remount R/O
Feb 24 10:43:14 swoop kernel: Remounting device ide0(3,5) ... OK
Feb 24 10:43:14 swoop kernel: Remounting device ide0(3,11) ... OK
Feb 24 10:43:14 swoop kernel: Remounting device ide0(3,6) ... OK
Feb 24 10:43:14 swoop kernel: Remounting device ide0(3,8) ... OK

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.62-mm3-ksymoops"

ksymoops 2.4.8 on i686 2.4.20-rc4-rmap15d.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc4-rmap15d/ (default)
     -m /boot/System.map-2.4.20-rc4-rmap15d (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb 24 10:42:11 swoop kernel: Machine check exception polling timer started.
Feb 24 10:42:11 swoop kernel: e100: selftest OK.
Feb 24 10:42:11 swoop kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Feb 24 10:42:11 swoop kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0800-0x08ff: clean.
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3e8-0x3ff 0x4d0-0x4d7
Feb 24 10:42:17 swoop kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 24 10:42:34 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:34 swoop kernel: invalid operand: 0000
Feb 24 10:42:34 swoop kernel: CPU:    0
Feb 24 10:42:34 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:34 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:34 swoop kernel: eax: 00000000   ebx: c119ae38   ecx: ca476400   edx: cb0a2048
Feb 24 10:42:34 swoop kernel: esi: cb0a2048   edi: cb9dfa80   ebp: c119ae38   esp: cb06fea0
Feb 24 10:42:34 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:34 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cb9dfa80 
Feb 24 10:42:34 swoop kernel:        cb9dfa80 ca476400 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:34 swoop kernel:        40012000 c0138fc7 cb5e1080 cb9dfa80 40012000 00000001 cb0a2048 cb0eb400 
Feb 24 10:42:34 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:34 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c119ae38 <_end+e86560/1057d788>
>>ecx; ca476400 <_end+a161b28/1057d788>
>>edx; cb0a2048 <_end+ad8d770/1057d788>
>>esi; cb0a2048 <_end+ad8d770/1057d788>
>>edi; cb9dfa80 <_end+b6cb1a8/1057d788>
>>ebp; c119ae38 <_end+e86560/1057d788>
>>esp; cb06fea0 <_end+ad5b5c8/1057d788>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f8                        clc    
Code;  00000003 Before first symbol
   3:   00 57 39                  add    %dl,0x39(%edi)
Code;  00000006 Before first symbol
   6:   2a c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   3d 60 a9 2d c0            cmp    $0xc02da960,%eax
Code;  0000000d Before first symbol
   d:   74 10                     je     1f <_EIP+0x1f>
Code;  0000000f Before first symbol
   f:   ff 43 20                  incl   0x20(%ebx)
Code;  00000012 Before first symbol
  12:   89 c8                     mov    %ecx,%eax

Feb 24 10:42:36 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:36 swoop kernel: invalid operand: 0000
Feb 24 10:42:36 swoop kernel: CPU:    0
Feb 24 10:42:36 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:36 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:36 swoop kernel: eax: 00000000   ebx: c11a6b70   ecx: ca476580   edx: cad50048
Feb 24 10:42:36 swoop kernel: esi: cad50048   edi: cb9df900   ebp: c11a6b70   esp: cad19ea0
Feb 24 10:42:36 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:36 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cb9df900 
Feb 24 10:42:36 swoop kernel:        cb9df900 ca476580 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:36 swoop kernel:        40012000 c0138fc7 cb5e1080 cb9df900 40012000 00000001 cad50048 cb0eb400 
Feb 24 10:42:36 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:36 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 


>>ebx; c11a6b70 <_end+e92298/1057d788>
>>ecx; ca476580 <_end+a161ca8/1057d788>
>>edx; cad50048 <_end+aa3b770/1057d788>
>>esi; cad50048 <_end+aa3b770/1057d788>
>>edi; cb9df900 <_end+b6cb028/1057d788>
>>ebp; c11a6b70 <_end+e92298/1057d788>
>>esp; cad19ea0 <_end+aa055c8/1057d788>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f8                        clc    
Code;  00000003 Before first symbol
   3:   00 57 39                  add    %dl,0x39(%edi)
Code;  00000006 Before first symbol
   6:   2a c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   3d 60 a9 2d c0            cmp    $0xc02da960,%eax
Code;  0000000d Before first symbol
   d:   74 10                     je     1f <_EIP+0x1f>
Code;  0000000f Before first symbol
   f:   ff 43 20                  incl   0x20(%ebx)
Code;  00000012 Before first symbol
  12:   89 c8                     mov    %ecx,%eax

Feb 24 10:42:38 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:38 swoop kernel: invalid operand: 0000
Feb 24 10:42:38 swoop kernel: CPU:    0
Feb 24 10:42:38 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:38 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:38 swoop kernel: eax: 00000000   ebx: c11a95a0   ecx: ca476600   edx: cac1b048
Feb 24 10:42:38 swoop kernel: esi: cac1b048   edi: cbd73a80   ebp: c11a95a0   esp: cb091ea0
Feb 24 10:42:38 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:38 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cbd73a80 
Feb 24 10:42:38 swoop kernel:        cbd73a80 ca476600 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:38 swoop kernel:        40012000 c0138fc7 cb5e1080 cbd73a80 40012000 00000001 cac1b048 cb0eb400 
Feb 24 10:42:38 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:38 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 


>>ebx; c11a95a0 <_end+e94cc8/1057d788>
>>ecx; ca476600 <_end+a161d28/1057d788>
>>edx; cac1b048 <_end+a906770/1057d788>
>>esi; cac1b048 <_end+a906770/1057d788>
>>edi; cbd73a80 <_end+ba5f1a8/1057d788>
>>ebp; c11a95a0 <_end+e94cc8/1057d788>
>>esp; cb091ea0 <_end+ad7d5c8/1057d788>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f8                        clc    
Code;  00000003 Before first symbol
   3:   00 57 39                  add    %dl,0x39(%edi)
Code;  00000006 Before first symbol
   6:   2a c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   3d 60 a9 2d c0            cmp    $0xc02da960,%eax
Code;  0000000d Before first symbol
   d:   74 10                     je     1f <_EIP+0x1f>
Code;  0000000f Before first symbol
   f:   ff 43 20                  incl   0x20(%ebx)
Code;  00000012 Before first symbol
  12:   89 c8                     mov    %ecx,%eax

Feb 24 10:42:40 swoop kernel: kernel BUG at mm/rmap.c:248!
Feb 24 10:42:40 swoop kernel: invalid operand: 0000
Feb 24 10:42:40 swoop kernel: CPU:    0
Feb 24 10:42:40 swoop kernel: EIP:    0060:[page_add_rmap+62/241]    Not tainted
Feb 24 10:42:40 swoop kernel: EFLAGS: 00013246
Feb 24 10:42:40 swoop kernel: eax: 00000000   ebx: c119db38   ecx: ca476680   edx: cac62048
Feb 24 10:42:40 swoop kernel: esi: cac62048   edi: cd3fa5c0   ebp: c119db38   esp: cad43ea0
Feb 24 10:42:40 swoop kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 10:42:40 swoop kernel: Stack: 00000002 00000000 c0138df3 000000d0 40012000 00000000 cf091000 cd3fa5c0 
Feb 24 10:42:40 swoop kernel:        cd3fa5c0 ca476680 cb0eb400 00000001 cb5e1080 cb0eb400 40012000 cb5e1080 
Feb 24 10:42:40 swoop kernel:        40012000 c0138fc7 cb5e1080 cd3fa5c0 40012000 00000001 cac62048 cb0eb400 
Feb 24 10:42:40 swoop kernel: Call Trace: [do_no_page+362/714]  [handle_mm_fault+116/139]  [do_page_fault+293/1089]  [old_mmap+268/321]  [do_page_fault+0/1089]  [error_code+45/56] 
Feb 24 10:42:40 swoop kernel: Code: 0f 0b f8 00 57 39 2a c0 3d 60 a9 2d c0 74 10 ff 43 20 89 c8 


>>ebx; c119db38 <_end+e89260/1057d788>
>>ecx; ca476680 <_end+a161da8/1057d788>
>>edx; cac62048 <_end+a94d770/1057d788>
>>esi; cac62048 <_end+a94d770/1057d788>
>>edi; cd3fa5c0 <_end+d0e5ce8/1057d788>
>>ebp; c119db38 <_end+e89260/1057d788>
>>esp; cad43ea0 <_end+aa2f5c8/1057d788>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f8                        clc    
Code;  00000003 Before first symbol
   3:   00 57 39                  add    %dl,0x39(%edi)
Code;  00000006 Before first symbol
   6:   2a c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   3d 60 a9 2d c0            cmp    $0xc02da960,%eax
Code;  0000000d Before first symbol
   d:   74 10                     je     1f <_EIP+0x1f>
Code;  0000000f Before first symbol
   f:   ff 43 20                  incl   0x20(%ebx)
Code;  00000012 Before first symbol
  12:   89 c8                     mov    %ecx,%eax


1 warning issued.  Results may not be reliable.

--cNdxnHkX5QqsyA0e--
