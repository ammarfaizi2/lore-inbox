Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUHDQkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUHDQkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUHDQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:40:40 -0400
Received: from pop.gmx.de ([213.165.64.20]:54730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267350AbUHDQae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:30:34 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc2-mm2
Date: Wed, 4 Aug 2004 18:32:18 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org>
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T+QEBHMQ3Ks59Ye"
Message-Id: <200408041832.19646.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_T+QEBHMQ3Ks59Ye
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 02 August 2004 10:55, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6
>.8-rc2-mm2/

the kernel does not boot on my machine. 2.6.8-rc2 and rc2-mm1 boot fine with 
the same .config.

...
Aug  4 17:59:04 mybox kernel: saa7134[0]/audio: audio carrier scan failed, 
using 5.500 MHz [default]
Aug  4 17:59:06 mybox kernel: usb 3-1: control timeout on ep0out
Aug  4 17:59:06 mybox kernel: ohci_hcd 0000:00:03.2: Unlink after no-IRQ?  
Different ACPI or APIC settings may help.


The saa7134 error also did not appear with 2.6.8-rc2-mm1.

syslog, lspci and .config attached.

thx,
dominik

--Boundary-00=_T+QEBHMQ3Ks59Ye
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog.txt"

Aug  4 17:58:58 mybox syslogd 1.4.1#15: restart.
Aug  4 17:58:58 mybox kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Aug  4 17:58:58 mybox kernel: Inspecting /boot/System.map-2.6.8-rc2-mm2
Aug  4 17:58:58 mybox kernel: Loaded 24870 symbols from /boot/System.map-2.6.8-rc2-mm2.
Aug  4 17:58:58 mybox kernel: Symbols match kernel version 2.6.8.
Aug  4 17:58:58 mybox kernel: No module symbols loaded - kernel modules not enabled.
Aug  4 17:58:58 mybox kernel: Linux version 2.6.8-rc2-mm2 (root@mybox) (gcc-Version 3.4.1 (Debian 3.4.1-5)) #1 Mon Aug 2 17:36:30 CEST 2004
Aug  4 17:58:58 mybox kernel: BIOS-provided physical RAM map:
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug  4 17:58:58 mybox kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug  4 17:58:58 mybox kernel: 255MB LOWMEM available.
Aug  4 17:58:58 mybox kernel: On node 0 totalpages: 65520
Aug  4 17:58:58 mybox kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug  4 17:58:58 mybox kernel:   Normal zone: 61424 pages, LIFO batch:14
Aug  4 17:58:58 mybox kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug  4 17:58:58 mybox kernel: DMI 2.3 present.
Aug  4 17:58:58 mybox kernel: ACPI: RSDP (v000 AWARD                                     ) @ 0x000f72b0
Aug  4 17:58:58 mybox kernel: ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
Aug  4 17:58:58 mybox kernel: ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
Aug  4 17:58:58 mybox kernel: ACPI: MADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff69c0
Aug  4 17:58:58 mybox kernel: ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Aug  4 17:58:58 mybox kernel: ACPI: PM-Timer IO Port: 0x1008
Aug  4 17:58:58 mybox kernel: Built 1 zonelists
Aug  4 17:58:58 mybox kernel: Initializing CPU#0
Aug  4 17:58:58 mybox kernel: Kernel command line: BOOT_IMAGE=2.6.8-rc2-mm2 ro root=30a hda=scsi hdb=scsi hdc=scsi hdd=scsi hde=scsi hdf=scsi hdg=scsi hdh=scsi apm=power-off nomce
Aug  4 17:58:58 mybox kernel: ide_setup: hda=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdb=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdc=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdd=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hde=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdf=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdg=scsi
Aug  4 17:58:58 mybox kernel: ide_setup: hdh=scsi
Aug  4 17:58:58 mybox kernel: CPU 0 irqstacks, hard=c03a1000 soft=c03a0000
Aug  4 17:58:58 mybox kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Aug  4 17:58:58 mybox kernel: Detected 2673.220 MHz processor.
Aug  4 17:58:58 mybox kernel: Using pmtmr for high-res timesource
Aug  4 17:58:58 mybox kernel: Console: colour dummy device 80x25
Aug  4 17:58:58 mybox kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug  4 17:58:58 mybox kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug  4 17:58:58 mybox kernel: Memory: 255996k/262080k available (1804k kernel code, 5336k reserved, 744k data, 112k init, 0k highmem)
Aug  4 17:58:58 mybox kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug  4 17:58:58 mybox kernel: Calibrating delay loop... 5292.03 BogoMIPS (lpj=2646016)
Aug  4 17:58:58 mybox kernel: Security Scaffold v1.0.0 initialized
Aug  4 17:58:58 mybox kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug  4 17:58:58 mybox kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
Aug  4 17:58:58 mybox kernel: CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
Aug  4 17:58:58 mybox kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug  4 17:58:58 mybox kernel: CPU: L2 cache: 512K
Aug  4 17:58:58 mybox kernel: CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Aug  4 17:58:58 mybox kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
Aug  4 17:58:58 mybox kernel: Enabling fast FPU save and restore... done.
Aug  4 17:58:58 mybox kernel: Enabling unmasked SIMD FPU exception support... done.
Aug  4 17:58:58 mybox kernel: Checking 'hlt' instruction... OK.
Aug  4 17:58:58 mybox kernel: NET: Registered protocol family 16
Aug  4 17:58:58 mybox kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb400, last bus=1
Aug  4 17:58:58 mybox kernel: PCI: Using configuration type 1
Aug  4 17:58:58 mybox kernel: mtrr: v2.0 (20020519)
Aug  4 17:58:58 mybox kernel: ACPI: Subsystem revision 20040715
Aug  4 17:58:58 mybox kernel: ACPI: IRQ9 SCI: Level Trigger.
Aug  4 17:58:58 mybox kernel: ACPI: Interpreter enabled
Aug  4 17:58:58 mybox kernel: ACPI: Using PIC for interrupt routing
Aug  4 17:58:58 mybox kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug  4 17:58:58 mybox kernel: PCI: Probing PCI hardware (bus 00)
Aug  4 17:58:58 mybox kernel: Uncovering SIS963 that hid as a SIS503 (compatible=1)
Aug  4 17:58:58 mybox kernel: Enabling SiS 96x SMBus.
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *13
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Aug  4 17:58:58 mybox kernel: PCI: Using ACPI for IRQ routing
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 11 (level, low) -> IRQ 11
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 10 (level, low) -> IRQ 10
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 11 (level, low) -> IRQ 11
Aug  4 17:58:58 mybox kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 5 (level, low) -> IRQ 5
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug  4 17:58:58 mybox kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xd0880000, size 10240k
Aug  4 17:58:58 mybox kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Aug  4 17:58:58 mybox kernel: vesafb: protected mode interface info at c000:e2d0
Aug  4 17:58:58 mybox kernel: vesafb: scrolling: redraw
Aug  4 17:58:58 mybox kernel: vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Aug  4 17:58:58 mybox kernel: fb0: VESA VGA frame buffer device
Aug  4 17:58:58 mybox kernel: udf: registering filesystem
Aug  4 17:58:58 mybox kernel: Initializing Cryptographic API
Aug  4 17:58:58 mybox kernel: Console: switching to colour frame buffer device 160x64
Aug  4 17:58:58 mybox kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug  4 17:58:58 mybox kernel: agpgart: Detected SiS 648 chipset
Aug  4 17:58:58 mybox kernel: agpgart: Maximum main memory to use for agp memory: 203M
Aug  4 17:58:58 mybox kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Aug  4 17:58:58 mybox kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug  4 17:58:58 mybox kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug  4 17:58:58 mybox kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
Aug  4 17:58:58 mybox kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  4 17:58:58 mybox kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug  4 17:58:58 mybox kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  4 17:58:58 mybox kernel: SIS5513: IDE controller at PCI slot 0000:00:02.5
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 11 (level, low) -> IRQ 11
Aug  4 17:58:58 mybox kernel: SIS5513: chipset revision 0
Aug  4 17:58:58 mybox kernel: SIS5513: not 100%% native mode: will probe irqs later
Aug  4 17:58:58 mybox kernel: SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
Aug  4 17:58:58 mybox kernel:     ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
Aug  4 17:58:58 mybox kernel:     ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio
Aug  4 17:58:58 mybox kernel: hda: ST3120023A, ATA DISK drive
Aug  4 17:58:58 mybox kernel: hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
Aug  4 17:58:58 mybox kernel: Using anticipatory io scheduler
Aug  4 17:58:58 mybox kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  4 17:58:58 mybox kernel: hdc: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Aug  4 17:58:58 mybox kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug  4 17:58:58 mybox kernel: hda: max request size: 128KiB
Aug  4 17:58:58 mybox kernel: hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Aug  4 17:58:58 mybox kernel: hda: cache flushes supported
Aug  4 17:58:58 mybox kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Aug  4 17:58:58 mybox kernel: ide-cd: passing drive hdb to ide-scsi emulation.
Aug  4 17:58:58 mybox kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Aug  4 17:58:58 mybox kernel: ide-floppy driver 0.99.newide
Aug  4 17:58:58 mybox kernel: ide-cd: passing drive hdb to ide-scsi emulation.
Aug  4 17:58:58 mybox kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Aug  4 17:58:58 mybox kernel: mice: PS/2 mouse device common for all mice
Aug  4 17:58:58 mybox kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug  4 17:58:58 mybox kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug  4 17:58:58 mybox kernel: input: PC Speaker
Aug  4 17:58:58 mybox kernel: NET: Registered protocol family 2
Aug  4 17:58:58 mybox kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Aug  4 17:58:58 mybox kernel: TCP: Hash tables configured (established 16384 bind 32768)
Aug  4 17:58:58 mybox kernel: IPv4 over IPv4 tunneling driver
Aug  4 17:58:58 mybox kernel: GRE over IPv4 tunneling driver
Aug  4 17:58:58 mybox kernel: Initializing IPsec netlink socket
Aug  4 17:58:58 mybox kernel: NET: Registered protocol family 1
Aug  4 17:58:58 mybox kernel: NET: Registered protocol family 17
Aug  4 17:58:58 mybox kernel: ACPI: (supports S0 S3 S4 S5)
Aug  4 17:58:58 mybox kernel: ACPI wakeup devices:
Aug  4 17:58:58 mybox kernel: FUTS PCI0 USB0 USB1 USB2 USB3 MAC0 AMR0 UAR1 PS2M PS2K
Aug  4 17:58:58 mybox kernel: kjournald starting.  Commit interval 5 seconds
Aug  4 17:58:58 mybox kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  4 17:58:58 mybox kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug  4 17:58:58 mybox kernel: Freeing unused kernel memory: 112k freed
Aug  4 17:58:58 mybox kernel: SCSI subsystem initialized
Aug  4 17:58:58 mybox kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Aug  4 17:58:58 mybox kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Aug  4 17:58:58 mybox kernel:   Vendor: IDE       Model: DVD-ROM 16X       Rev: 2.05
Aug  4 17:58:58 mybox kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug  4 17:58:58 mybox kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Aug  4 17:58:58 mybox kernel:   Vendor: SONY      Model: CD-RW  CRX210E1   Rev: 2YS2
Aug  4 17:58:58 mybox kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug  4 17:58:58 mybox kernel: hdb: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
Aug  4 17:58:58 mybox kernel: ide: failed opcode was 100
Aug  4 17:58:58 mybox kernel: hda: dma_timer_expiry: dma status == 0x60
Aug  4 17:58:58 mybox kernel: hda: DMA timeout retry
Aug  4 17:58:58 mybox kernel: hda: timeout waiting for DMA
Aug  4 17:58:58 mybox kernel: Adding 514040k swap on /dev/hda9.  Priority:-1 extents:1
Aug  4 17:58:58 mybox kernel: EXT3 FS on hda10, internal journal
Aug  4 17:58:58 mybox kernel: warning: process `update' used the obsolete bdflush system call
Aug  4 17:58:58 mybox kernel: Fix your initscripts?
Aug  4 17:58:58 mybox kernel: ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
Aug  4 17:58:58 mybox kernel: ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:58 mybox kernel: ohci1394: fw-host0: Unexpected PCI resource length of 1000!
Aug  4 17:58:58 mybox kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e2427000-e24277ff]  Max Packet=[2048]
Aug  4 17:58:59 mybox pci.agent[720]:      ohci1394: loaded successfully
Aug  4 17:58:59 mybox kernel: snd: Unknown parameter `device_gid'
Aug  4 17:58:59 mybox kernel: ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5
Aug  4 17:58:59 mybox kernel: intel8x0_measure_ac97_clock: measured 49512 usecs
Aug  4 17:58:59 mybox kernel: intel8x0: clocking to 48000
Aug  4 17:58:59 mybox pci.agent[782]:      snd-intel8x0: loaded successfully
Aug  4 17:58:59 mybox kernel: usbcore: registered new driver usbfs
Aug  4 17:58:59 mybox kernel: usbcore: registered new driver hub
Aug  4 17:58:59 mybox kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Aug  4 17:58:59 mybox kernel: ohci_hcd: block sizes: ed 64 td 64
Aug  4 17:58:59 mybox kernel: ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 9 (level, low) -> IRQ 9
Aug  4 17:58:59 mybox kernel: ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
Aug  4 17:58:59 mybox kernel: ohci_hcd 0000:00:03.0: irq 9, pci mem d12f4000
Aug  4 17:58:59 mybox kernel: ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
Aug  4 17:58:59 mybox kernel: hub 1-0:1.0: USB hub found
Aug  4 17:58:59 mybox kernel: hub 1-0:1.0: 2 ports detected
Aug  4 17:58:59 mybox kernel: ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:58:59 mybox kernel: ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
Aug  4 17:58:59 mybox usb.agent[866]:      usbcore: already loaded
Aug  4 17:59:00 mybox kernel: ohci_hcd 0000:00:03.1: irq 3, pci mem d12f6000
Aug  4 17:59:00 mybox kernel: ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
Aug  4 17:59:00 mybox usb.agent[917]:      usbcore: already loaded
Aug  4 17:59:00 mybox kernel: hub 2-0:1.0: USB hub found
Aug  4 17:59:00 mybox kernel: hub 2-0:1.0: 2 ports detected
Aug  4 17:59:00 mybox kernel: ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 10 (level, low) -> IRQ 10
Aug  4 17:59:00 mybox kernel: ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
Aug  4 17:59:00 mybox kernel: ohci_hcd 0000:00:03.2: irq 10, pci mem d12f8000
Aug  4 17:59:00 mybox kernel: ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
Aug  4 17:59:00 mybox kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000010dc001ee09a]
Aug  4 17:59:00 mybox usb.agent[969]:      usbcore: already loaded
Aug  4 17:59:00 mybox kernel: hub 3-0:1.0: USB hub found
Aug  4 17:59:00 mybox kernel: hub 3-0:1.0: 2 ports detected
Aug  4 17:59:00 mybox pci.agent[838]:      ohci-hcd: loaded successfully
Aug  4 17:59:00 mybox pci.agent[1007]:      ohci-hcd: already loaded
Aug  4 17:59:00 mybox kernel: usb 2-1: new full speed USB device using address 2
Aug  4 17:59:00 mybox pci.agent[1035]:      ohci-hcd: already loaded
Aug  4 17:59:00 mybox kernel: Initializing USB Mass Storage driver...
Aug  4 17:59:01 mybox kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Aug  4 17:59:01 mybox kernel: ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 11 (level, low) -> IRQ 11
Aug  4 17:59:01 mybox kernel: ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
Aug  4 17:59:01 mybox scsi.agent[1124]: disk at /devices/pci0000:00/0000:00:03.1/usb2/2-1/2-1:1.0/host2/2:0:0:0
Aug  4 17:59:01 mybox usb.agent[1072]:      usb-storage: loaded successfully
Aug  4 17:59:01 mybox kernel:   Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
Aug  4 17:59:01 mybox kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Aug  4 17:59:01 mybox kernel: USB Mass Storage device found at 2
Aug  4 17:59:01 mybox kernel: usbcore: registered new driver usb-storage
Aug  4 17:59:01 mybox kernel: USB Mass Storage support registered.
Aug  4 17:59:01 mybox kernel: usb 3-1: new full speed USB device using address 2
Aug  4 17:59:01 mybox kernel: ehci_hcd 0000:00:03.3: irq 11, pci mem d1344000
Aug  4 17:59:01 mybox kernel: ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
Aug  4 17:59:01 mybox kernel: PCI: cache line size of 128 is not supported by device 0000:00:03.3
Aug  4 17:59:01 mybox kernel: ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Aug  4 17:59:01 mybox usb.agent[1158]:      usbcore: already loaded
Aug  4 17:59:01 mybox kernel: hub 4-0:1.0: USB hub found
Aug  4 17:59:01 mybox kernel: hub 4-0:1.0: 6 ports detected
Aug  4 17:59:01 mybox pci.agent[1097]:      ehci-hcd: loaded successfully
Aug  4 17:59:01 mybox kernel: sis900.c: v1.08.07 11/02/2003
Aug  4 17:59:01 mybox kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 0.
Aug  4 17:59:01 mybox kernel: eth0: Realtek RTL8201 PHY transceiver found at address 1.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 2.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 3.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 4.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 5.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 6.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 7.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 8.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 9.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 10.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 11.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 12.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 13.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 14.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 15.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 16.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 17.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 18.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 19.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 20.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 21.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 22.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 23.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 24.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 25.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 26.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 27.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 28.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 29.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 30.
Aug  4 17:59:01 mybox kernel: eth0: Unknown PHY transceiver found at address 31.
Aug  4 17:59:01 mybox kernel: eth0: Using transceiver found at address 1 as default
Aug  4 17:59:01 mybox kernel: eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 3, 00:10:dc:af:b9:cc.
Aug  4 17:59:01 mybox pci.agent[1196]:      sis900: loaded successfully
Aug  4 17:59:02 mybox kernel: 8139too Fast Ethernet driver 0.9.27
Aug  4 17:59:02 mybox kernel: ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 5 (level, low) -> IRQ 5
Aug  4 17:59:02 mybox kernel: eth1: RealTek RTL8139 at 0xd1346000, 00:50:fc:2d:da:ef, IRQ 5
Aug  4 17:59:02 mybox kernel: eth1:  Identified 8139 chip type 'RTL-8139C'
Aug  4 17:59:02 mybox pci.agent[1242]:      8139too: loaded successfully
Aug  4 17:59:02 mybox kernel: Linux video capture interface: v1.00
Aug  4 17:59:02 mybox kernel: saa7130/34: v4l2 driver version 0.2.12 loaded
Aug  4 17:59:02 mybox kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 3 (level, low) -> IRQ 3
Aug  4 17:59:02 mybox kernel: saa7134[0]: found at 0000:00:08.0, rev: 1, irq: 3, latency: 32, mmio: 0xe2426000
Aug  4 17:59:02 mybox kernel: saa7134[0]: subsystem: 16be:0003, board: Medion 7134 [card=12,autodetected]
Aug  4 17:59:02 mybox kernel: saa7134[0]: board init: gpio is 0
Aug  4 17:59:02 mybox kernel: saa7134[0]: i2c eeprom 00: be 16 03 00 08 20 1c 55 43 43 a9 1c 55 43 43 a9
Aug  4 17:59:02 mybox kernel: saa7134[0]: i2c eeprom 10: ff ff ff ff 15 00 0e 01 0c c0 08 00 00 00 00 00
Aug  4 17:59:02 mybox kernel: saa7134[0]: i2c eeprom 20: 00 00 00 e3 ff ff ff ff ff ff ff ff ff ff ff ff
Aug  4 17:59:02 mybox kernel: saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Aug  4 17:59:02 mybox kernel: tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
Aug  4 17:59:02 mybox kernel: tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
Aug  4 17:59:02 mybox kernel: tda9885/6/7: chip found @ 0x86
Aug  4 17:59:02 mybox kernel: saa7134[0]: registered device video0 [v4l2]
Aug  4 17:59:02 mybox kernel: saa7134[0]: registered device vbi0
Aug  4 17:59:02 mybox kernel: saa7134[0]: registered device radio0
Aug  4 17:59:02 mybox pci.agent[1290]:      saa7134: loaded successfully
Aug  4 17:59:02 mybox pci.rc[641]:      ignoring pci display device on 01:00.0
Aug  4 17:59:04 mybox kernel: saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [default]
Aug  4 17:59:06 mybox kernel: usb 3-1: control timeout on ep0out
Aug  4 17:59:06 mybox kernel: ohci_hcd 0000:00:03.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.

--Boundary-00=_T+QEBHMQ3Ks59Ye
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

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
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_PAGG=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
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
# CONFIG_MODVERSIONS is not set
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
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
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
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
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
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

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
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

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
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
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
# CONFIG_BLK_DEV_IT8212 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
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
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

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

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
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
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
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
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_RAWIO is not set
# CONFIG_IEEE1394_CMP is not set

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
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
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
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=m
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
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
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

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
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
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
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
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
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

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
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
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
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=10
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
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
CONFIG_AGP_SIS=y
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set

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
CONFIG_I2C_I810=y
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
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
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

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
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

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
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
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

#
# Logo configuration
#
# CONFIG_LOGO is not set

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
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
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
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
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
CONFIG_SND_INTEL8X0=m
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
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
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
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
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
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set

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
# CONFIG_USB_USS720 is not set

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
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

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
CONFIG_CRAMFS=m
CONFIG_SQUASHFS=m
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
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_POSIX=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
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
# CONFIG_NLS_ASCII is not set
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
CONFIG_NLS_ISO8859_15=y
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
CONFIG_4KSTACKS=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set

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
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_T+QEBHMQ3Ks59Ye
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"


0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS 645xx
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=3 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media IO] (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 169
        Region 4: I/O ports at 10c0 [size=32]

0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 701d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 169
        Region 0: Memory at e2427000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 177
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at d800 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at e2420000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 201
        Region 0: Memory at e2421000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 209
        Region 0: Memory at e2422000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 217
        Region 0: Memory at e2423000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 91)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0900
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 225
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at e2424000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at e2425000 (32-bit, non-prefetchable) [size=256]

0000:00:08.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
        Subsystem: Creatix Polymedia GmbH: Unknown device 0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 8000ns max)
        Interrupt: pin A routed to IRQ 225
        Region 0: Memory at e2426000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0a.0 Communication controller: Intel Corp. 536EP Data Fax Modem
        Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=375mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0431
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

--Boundary-00=_T+QEBHMQ3Ks59Ye--
