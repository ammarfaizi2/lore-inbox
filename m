Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270638AbTGURhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGURgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:36:46 -0400
Received: from voicecomcorp.com ([161.58.223.92]:53261 "EHLO voicecomcorp.com")
	by vger.kernel.org with ESMTP id S270608AbTGURfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:35:14 -0400
Message-ID: <3F1C2752.40503@voicecomcorp.com>
Date: Mon, 21 Jul 2003 12:48:02 -0500
From: Josh Crawley <josh@voicecomcorp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Synaptics touchpad problem.....
Content-Type: multipart/mixed;
 boundary="------------070904040407090702020308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904040407090702020308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've got a older K6-2 Compaq laptop that I run the 2.4 series on. Turns 
out that there's some weird issues with Synaptics and this laptops' 
interface. It detects the keyboard/mouse IO chip, and initalizes it. But 
whenever I use my 4 button+touchpad, it spits out on console "Lost Sync 
on X bit". I do have a usb moust that works perfectly though.

I've enclosed my dmesg on startup, and propigated a bunch of the "lost 
sync" errors to 2 text files. If this problems' known or a result of me 
being scatterbrained, sorry.

If there is anything else you would like me to do, just ask.

Sincerly
Josh Crawley

--------------070904040407090702020308
Content-Type: text/plain;
 name="dmessage.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmessage.txt"

Linux version 2.6.0-test1 (crawley@joshlap.voicecomcorp.com) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Thu Jul 17 00:06:33 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0c00 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16384
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 12288 pages, LIFO batch:3
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Unable to locate RSDP
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5 ro root=303
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 328.050 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 643.07 BogoMIPS
Memory: 61008k/65536k available (2082k kernel code, 4044k reserved, 1007k data, 112k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb26, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 118 entries (12 bytes)
biovec pool[1]:   4 bvecs: 118 entries (48 bytes)
biovec pool[2]:  16 bvecs:  59 entries (192 bytes)
biovec pool[3]:  64 bvecs:  29 entries (768 bytes)
biovec pool[4]: 128 bvecs:  14 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   7 entries (3072 bytes)
ACPI: Subsystem revision 20030619
tbxfroot-0324 [04] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
ACPI: System description tables not found
 tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
 tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
Linux Plug and Play Support v0.96 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router OPTI [1045/c700] at 0000:00:01.0
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
pty: 256 Unix98 ptys configured
Journalled Block Device driver loaded
udf: registering filesystem
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: HITACHI_DK227A-41, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-1802B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 8007552 sectors (4100 MB) w/512KiB Cache, CHS=7944/16/63
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
PCI: Found IRQ 10 for device 0000:00:13.0
ohci-hcd 0000:00:13.0: OPTi Inc. 82C861
ohci-hcd 0000:00:13.0: irq 10, pci mem c480d000
ohci-hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci-hcd 0000:00:13.0: WARNING: OPTi workarounds unavailable
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
pc110pad: I/O area 0x15e0-0x15e4 in use.
Synaptics Touchpad, model: 1
 Firware: 4.6
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block 256, tag 1986618723 != 256
UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
reiserfs: replayed 2 transactions in 1 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
spurious 8259A interrupt: IRQ7.
Adding 245944k swap on /dev/hda2.  Priority:-1 extents:1
mtrr: 0xfd000000,0x200000 overlaps existing 0xfd000000,0x100000

--------------070904040407090702020308
Content-Type: text/plain;
 name="lostsync.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lostsync.txt"

yte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte

--------------070904040407090702020308--

