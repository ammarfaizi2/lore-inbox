Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUEKTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUEKTHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUEKTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:07:15 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:36075 "EHLO
	mail-relay-3.tiscali.i") by vger.kernel.org with ESMTP
	id S263448AbUEKTGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:06:44 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 IDE drive errors at boot time
Date: Tue, 11 May 2004 21:10:48 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112110.49192.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is the boot log.
I've never seen this error before (2.6.5 and previous kernels).
During normal reboot my disks have turned off the spindle motor
few seconds and then turned on again.
100% reproducible.


Linux version 2.6.6 (root@odyssey) (gcc version 3.3.3 (Debian 20040429)) #1 
Tue May 11 09:53:40 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa800
ACPI: RSDT (v001 AMIINT AMIINI09 0x00000010 MSFT 0x0100000d) @ 0x1fff0000
ACPI: FADT (v001 AMIINT AMIINI09 0x00000011 MSFT 0x0100000d) @ 0x1fff0030
ACPI: MADT (v001 AMIINT AMIINI09 0x00000011 MSFT 0x0100000d) @ 0x1fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: 
Initializing CPU#0
CPU 0 irqstacks, hard=c037b000 soft=c037a000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1339.122 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 516552k/524224k available (1687k kernel code, 6908k reserved, 696k 
data, 124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2637.82 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1500+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
hdb: WDC WD205BA, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
hdb: max request size: 128KiB
hdb: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
 hdb: hdb1 hdb2
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
NET: Registered protocol family 1
Adding 489940k swap on /dev/hda10.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Creative EMU10K1 PCI Audio Driver, version 0.20a, 09:46:03 May 11 2004
emu10k1: EMU10K1 rev 7 model 0x8027 found, IO at 0xe800-0xe81f, IRQ 10
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lp0: using parport0 (polling).
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03279c0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

-- 
Lorenzo
