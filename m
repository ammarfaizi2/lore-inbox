Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUDLNLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 09:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbUDLNLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 09:11:47 -0400
Received: from burp.tkv.asdf.org ([212.16.99.49]:13984 "EHLO burp.tkv.asdf.org")
	by vger.kernel.org with ESMTP id S262896AbUDLNLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 09:11:42 -0400
Date: Mon, 12 Apr 2004 16:11:40 +0300
Message-Id: <200404121311.i3CDBexA027123@burp.tkv.asdf.org>
From: Markku Savela <msa@burp.tkv.asdf.org>
To: linux-kernel@vger.kernel.org
Subject: aha152x0: irq 9 possibly wrong.  Please verify.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whatever IRQ I try (9, 10, 11 or 12), I always get the error in
subject. Any ideas what I should try/do?

----------------

Linux version 2.6.5-mm4 (root@moth) (gcc version 3.3.2 (Debian)) #4 Sun Apr 11 18:54:26 EEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77808 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI disabled because your bios is from 1999 and too old
You can enable it with acpi=force
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux-2.6.5-1 ro root=301 aha152x=0x140,9
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.993 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 320956k/327616k available (2052k kernel code, 5892k reserved, 665k data, 344k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 790.52 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: 3c5x9 found at 0x300, 10baseT port, address  00 20 af 92 e3 22, IRQ 7.
3c509.c:1.19b 08Nov2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: LTN382, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63
 hda: hda1 hda2 hda3
hdd: ATAPI 40X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.20
aha152x: processing commandline: ok
aha152x: BIOS test: passed, 1 controller(s) configured
aha152x: resetting bus...
aha152x0: vital data: rev=1, io=0x140 (0x140/0x140), irq=9, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
aha152x0: trying software interrupt, lost.
aha152x0: irq 9 possibly wrong.  Please verify.
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
es1371: version v0.32 time 18:33:58 Apr 11 2004
PCI: Found IRQ 11 for device 0000:00:0b.0
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xe400 irq 11 joystick 0x0
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
unable to register OSS rawmidi device 0:0
unable to register OSS mixer device 0:0
ALSA device list:
  #0: Virtual MIDI Card 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 344k freed
Adding 292816k swap on /dev/hda2.  Priority:-1 extents:1
eth0: Setting 3c5x9/3c5x9B half-duplex mode if_port: 0, sw_info: 3f11
eth0: Setting Rx mode to 1 addresses.
eth0: Setting Rx mode to 2 addresses.
eth0: Setting Rx mode to 3 addresses.
eth0: no IPv6 routers present
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
