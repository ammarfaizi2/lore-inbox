Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285517AbRLNVii>; Fri, 14 Dec 2001 16:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285531AbRLNVia>; Fri, 14 Dec 2001 16:38:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49636 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285517AbRLNViS> convert rfc822-to-8bit; Fri, 14 Dec 2001 16:38:18 -0500
Date: Fri, 14 Dec 2001 16:37:57 -0500 (EST)
From: Denis Pelletier <denis.pelletier@umontreal.ca>
X-X-Sender: dpel@maniwaki.dyndns.org
To: linux-kernel@vger.kernel.org
cc: manfred@colorfullife.com
Subject: IRQ routing conflict #2
Message-ID: <Pine.LNX.4.40.0112141617160.7496-100000@maniwaki.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Like I said previously I have an IRQ routing conflict with my Compaq
Presario 700 laptop. This machine does not have an option "non-pnp OS" in
its BIOS. Because of this conflict (I guess) the sound does not work.


[dpel@mobile dpel] dmesg
Linux version 2.4.16 (root@maniwaki.dyndns.org) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.69mdk)) #1 Fri Dec 14 08:25:43 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda6  devfs=mount vga=791
Initializing CPU#0
Detected 896.910 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1789.13 BogoMIPS
Memory: 239344k/245760k available (1258k kernel code, 5960k reserved, 368k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU: AMD Mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0b.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v0.120 (20011103) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.............................................................................................................
109 Control Methods found and parsed (441 nodes total)
Parsing Methods:
0 Control Methods found and parsed (444 nodes total)
ACPI Namespace successfully loaded at root c02e1000
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.....[ACPI Debug] String: ---------------------------- AC _STA
..evregion-0300 [21] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0._INI (cee39768)
  nsinit-0350 [04] Ns_init_one_device    : \   /_SB_PCI0._INI failed: AE_ERROR
......................................
45 Devices found: 45 _STA, 1 _INI
Completing Region and Field initialization:............
11/15 Regions, 1/1 Fields initialized (444 nodes total)
ACPI: Subsystem enabled
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
EC: found, GPE 6
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
evregion-0300 [25] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
 dswexec-0391 [16] Ds_exec_end_op        : [Store]: Could not resolve operands, AE_ERROR
Ps_execute: method failed - \_SB_.BAT0._BIF (cee392e8)
[ACPI Debug] String: ---------------------------- AC _STA
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
vesafb: framebuffer at 0xf0000000, mapped to 0xcf816000, size 15296k
vesafb: mode is 1024x768x16, linelength=2048, pages=8
vesafb: protected mode interface info at c000:7e56
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
toshiba: not a supported Toshiba laptop
i8k: Inspiron 8000 BIOS signature not found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 190M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xec000000
ide-floppy driver 0.97.sv
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0b.0
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0008, PCI irq11
Socket status: 30000006
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 21k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 220k freed
Adding Swap: 682720k swap-space (priority -1)
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd078c000, 00:08:02:02:34:06, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 08:36:09 Dec 14 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
devfs: devfs_register(): device already registered: "sequencer"
devfs: devfs_register(): device already registered: "sequencer2"
devfs: devfs_register(): device already registered: "sound/dspW"
devfs: devfs_register(): device already registered: "sound/audio"
Via 686a audio driver 1.9.1
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
devfs: devfs_register(): device already registered: "mixer"
ac97_codec: AC97 Audio codec, id: 0x4144:0x5361 (Unknown)
devfs: devfs_register(): device already registered: "dsp"
via82cxxx: board #1 at 0x1000, IRQ 5
SCSI subsystem driver Revision: 1.00
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
via_audio: ignoring drain playback error -11
Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1201
via_audio: ignoring drain playback error -11
[ACPI Debug] String: ---------------------------- AC _PSR
[ACPI Debug] String: ---------------------------- AC off line
[ACPI Debug] String: ---------------------------- AC _PSR
[ACPI Debug] String: ---------------------------- AC off line
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11



[dpel@mobile dpel] cat /proc/interrupts
           CPU0
  0:      74449          XT-PIC  timer
  1:        870          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       8481          XT-PIC  via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
 10:          0          XT-PIC  acpi
 11:       9106          XT-PIC  Texas Instruments PCI1410 PC card Cardbus Controller, eth0
 12:       2741          XT-PIC  PS/2 Mouse
 14:       5567          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0


[root@mobile root] lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
	Flags: bus master, medium devsel, latency 8
	Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 80 00 00 06 00 08 00 00
10: 08 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 a2 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 10 e8 10 e8 00 f0 f0 f7 00 00 00 00 ff ff ff ff
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 42)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 42 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1840 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 57 30
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Flags: medium devsel, IRQ 5
	I/O ports at 1000 [size=256]
	I/O ports at 1854 [size=4]
	I/O ports at 1850 [size=4]
	Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 55 18 00 00 51 18 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 97 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:09.0 Communication controller: CONEXANT: Unknown device 2f00 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Flags: medium devsel, IRQ 4
	Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at 1858 [size=8]
	Capabilities: [40] Power Management version 2
00: f1 14 00 2f 03 00 90 02 01 00 80 07 00 40 00 00
10: 00 00 00 e8 59 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 88 8d
30: 00 00 00 00 40 00 00 00 00 00 00 00 04 01 00 00

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 1: fbbfd000-ffbfc000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 e0 bf ff a0 00 00 02 00 02 05 b0 00 d0 bf ff
20: 00 d0 bf ff 00 d0 bf fb 00 c0 bf ff 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 c0 05
40: 11 0e 03 b1 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1400 [size=256]
	Memory at e8010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 14 00 00 00 00 01 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0086
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
	Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [80] AGP version 2.0
00: 33 53 02 8d 07 00 30 02 01 00 00 03 08 40 00 00
10: 00 00 10 e8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 86 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 04 ff


As for my sound problem: I can load the kernel module (via82cxxx_audio),
the sound mixers are unmuted, the volume is high, but I can only faintly
hear something. I have the same result with ALSA (without the "ignoring
drain playback error" in dmesg).

Thanks.

Denis
_______________________________________________
Denis Pelletier
Étudiant au doctorat
sciences économiques, Université de Montréal

