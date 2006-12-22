Return-Path: <linux-kernel-owner+w=401wt.eu-S1422916AbWLVPje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWLVPje (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423130AbWLVPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:39:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422916AbWLVPjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:39:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=j5btDNra9+El++db5M3F/pGXWLJlIJF6GqdDtF1EC0gGBk6dJkBaKAEaF0yQDhfdbq53w0PeHGpQlImP7le/Fh2S1iCYDH45KC2E3Sd+gGwe779Sr5TwjeXeo/4VTra/NSdCngovRy1c7WyTxLIHdP0qXNrAGdwsUjfzU5XDxkY=
Message-ID: <458BFC2E.4060201@gmail.com>
Date: Fri, 22 Dec 2006 16:39:26 +0100
From: Krzysztof Czainski <1czajnik@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061118)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mouse irq problem
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://forums.gentoo.org/viewtopic-p-3798833.html#3798833

Hello
I just installed gentoo on my old laptop MicroQuest with a pentium MMX 
266 processor.
So far everything was fine, until the mouse.
It is detected ok, but reacts very slowly.
When I say mouse, I mean built in touchpad, but that doesn't seem to 
matter - I tried disabling the touchpad in bios and connecting a ps2 
mouse and the slow reaction was the same.
I tested the mouse (results same slow reaction) in 3 ways:
1. gpm in console
2. in fluxbox/xorg
3. cat /dev/input/mice

Heres some info about the system:
Linux i586 2.6.18-gentoo-r4

in kernel:
CONFIG_INPUT_MOUSEDEV_PSAUX=Y
CONFIG_MOUSE_PS2=Y

dmesg:
Linux version 2.6.18-gentoo-r4 (root@laptop) (gcc version 4.1.1 (Gentoo 
4.1.1-r1)) #14 Tue Dec 19 14:15:00 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eb000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000fffeb000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16384
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 12288 pages, LIFO batch:3
DMI not present or invalid.
Allocating PCI resources starting at 10000000 (gap: 04000000:fbfeb000)
Detected 266.158 MHz processor.
Built 1 zonelists.  Total pages: 16384
Kernel command line: root=/dev/hda3 video=vesafb:1024x768-16@75 idebus=66
ide_setup: idebus=66
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01081000)
Initializing CPU#0
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60352k/65536k available (2692k kernel code, 4736k reserved, 994k 
data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Calibrating delay using timer specific routine.. 532.75 BogoMIPS 
(lpj=1065505)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 008001bf 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 008001bf 00000000 00000000 00000000 
00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.

CPU: After all inits, caps: 008001bf 00000000 00000000 00000000 00000000 
00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9e3, last bus=0
PCI: Using configuration type 1
Setting up standard PCI resources
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6b00
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa550, dseg 0x400
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region ff00-ff3f claimed by PIIX4 ACPI
PCI quirk: region ff80-ff8f claimed by PIIX4 SMB
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:03.0
NET: Registered protocol family 23
pnp: 00:00: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:00: ioport range 0xff00-0xff3f has been reserved
pnp: 00:00: ioport range 0xff80-0xff8f has been reserved
pnp: 00:00: ioport range 0x398-0x399 has been reserved
pnp: 00:01: ioport range 0x1260-0x1263 has been reserved
pnp: 00:01: ioport range 0x2260-0x2263 has been reserved
pnp: 00:01: ioport range 0x3260-0x3263 has been reserved
pnp: 00:01: ioport range 0x4260-0x4263 has been reserved
pnp: 00:01: ioport range 0x5260-0x5263 has been reserved
pnp: 00:01: ioport range 0x6260-0x6263 has been reserved
pnp: 00:01: ioport range 0x7260-0x7263 has been reserved
PCI: Bus 1, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Bus 5, cardbus bridge: 0000:00:0a.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 14000000-15ffffff
  MEM window: 16000000-17ffffff
PCI: setting IRQ 12 as level-triggered
PCI: Assigned IRQ 12 for device 0000:00:0a.0
PCI: Setting latency timer of device 0000:00:0a.0 to 64
PCI: Assigned IRQ 12 for device 0000:00:0a.1
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de 
<mailto:okir@monad.swb.de>).
NTFS driver 2.1.27 [Flags: R/W].
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
lp: driver loaded but no devices found
Non-volatile memory driver v1.2
[drm] Initialized drm 1.0.1 20051102
vesafb: , ,  (OEM: Copyright 1994 TRIDENT MICROSYSTEMS INC.
)
vesafb: VBE version: 2.0
vesafb: protected mode interface info at c000:7786
vesafb: pmi: set display start = c00c779b, set palette = c00c77ed
vesafb: no monitor limits have been set
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
vesafb: framebuffer at 0xfe400000, mapped to 0xc4880000, using 4096k, 
total 4096k
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
PIIX4: IDE controller at PCI slot 0000:00:03.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: IBM-DTCA-23240, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-1602B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 6354432 sectors (3253 MB) w/468KiB Cache, CHS=6304/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 12
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [0000:0000]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 12
Socket status: 30000006
USB Universal Host Controller Interface driver v3.0
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:03.2
PCI: Sharing IRQ 9 with 0000:00:02.0
uhci_hcd 0000:00:03.2: UHCI Host Controller
uhci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:03.2: irq 9, io base 0x0000fce0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
hub 1-0:1.0: over-current change on port 1
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb0: register 'gl620a' at usb-0000:00:03.2-1, Genesys GeneLink, 
00:00:00:00:00:00
usbcore: registered new driver gl620a
i2c /dev entries driver
piix4_smbus 0000:00:03.3: Found 0000:00:03.3 device
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 
13:55:50 2006 UTC).
ALSA device list:
  No soundcards found.
ip_conntrack version 2.4 (512 buckets, 4096 max) - 172 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x8148a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
Adding 254008k swap on /dev/hda2.  Priority:-1 extents:1 across:254008k
