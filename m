Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUE2E6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUE2E6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUE2E6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 00:58:40 -0400
Received: from PHOSPHORUS.CLUB.CC.cmu.edu ([128.2.4.171]:38672 "HELO
	club.cc.cmu.edu") by vger.kernel.org with SMTP id S263226AbUE2E6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 00:58:31 -0400
Date: Sat, 29 May 2004 00:58:30 -0400
From: "John S. Bucy" <bucy@gloop.org>
To: linux-kernel@vger.kernel.org
Subject: TI PCI1250 cardbus woes
Message-ID: <20040529045830.GF18562@phosphorus.club.cc.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an IBM TP600 with a TI PCI1250 cardbus bridge.  Old PCMCIA
cards work fine but new cardbus cards, e.g. an SMC 2835W wireless card
yield

PCI: device 0000:05:00.0 has unknown header type 7f, ignoring.

I saw a post from awhile back saying that PCI1250 doesn't autodetect
card voltage correctly or something which causes this problem --
though I'm not sure if that's the problem here since cardctl status shows
the SMC card as being there and 3.3V (correct).

I tried the SMC card in a TP600X which has (IIRC) a PCI1251
which detected it just fine.

Any ideas?


thanks
john


Linux version 2.6.6 (bucy@catalepsy) (gcc version 3.3.3 (Debian 20040401)) #3 Fri May 28 18:55:26 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005fd0000 (usable)
 BIOS-e820: 0000000005fd0000 - 0000000005fdf000 (ACPI data)
 BIOS-e820: 0000000005fdf000 - 0000000005fe0000 (ACPI NVS)
 BIOS-e820: 0000000005fe0000 - 0000000006000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
95MB LOWMEM available.
On node 0 totalpages: 24528
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 20432 pages, LIFO batch:4
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
ACPI disabled because your bios is from 99 and too old
You can enable it with acpi=force
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=266 ro root=301
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 232.163 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 93160k/98112k available (2452k kernel code, 4444k reserved, 846k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 456.70 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=6
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:02.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:02.1
vesafb: framebuffer at 0xe0000000, mapped to 0xc6800000, size 1984k
vesafb: mode is 1024x768x8, linelength=1024, pages=1
vesafb: protected mode interface info at c000:8e10
vesafb: scrolling: redraw
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
udf: registering filesystem
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Console: switching to colour frame buffer device 128x48
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK227A-41, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-1702BC, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 8007552 sectors (4099 MB) w/512KiB Cache, CHS=7944/16/63, UDMA(33)
 hda: hda1 hda2
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0092]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.0, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0092]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.1, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000010
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 439480k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x130-0x137 0x200-0x207 0x220-0x22f 0x388-0x38f 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth0: Station identity 001f:0001:0007:001c
eth0: Looks like a Lucent/Agere firmware version 7.28
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:60:1D:1B:EA:DA
eth0: Station name "HERMES I"
eth0: ready
eth0: index 0x01: Vcc 5.0, irq 3, io 0x0180-0x01bf
eth0: New link status: Connected (0001)
mtrr: 0xe0000000,0x200000 overlaps existing 0xe0000000,0x100000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03fb2a0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
eth0: New link status: AP Out of Range (0004)
eth0: New link status: AP In Range (0005)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
input: AT Translated Set 2 keyboard on isa0060/serio0



00:00.0 Class 0600: 8086:7192 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:02.0 Class 0607: 104c:ac16 (rev 02)
	Subsystem: 1014:0092
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 20301000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:02.1 Class 0607: 104c:ac16 (rev 02)
	Subsystem: 1014:0092
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 20300000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.0 Class 0300: 10c8:0004 (rev 01)
	Subsystem: 10c8:0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at 20000000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 20200000 (32-bit, non-prefetchable) [size=1M]

00:07.0 Class 0680: 8086:7110 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 Class 0101: 8086:7111 (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 48
	Region 4: I/O ports at fcf0 [size=16]

00:07.2 Class 0c03: 8086:7112 (rev 01)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 48
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 8400 [size=32]

00:07.3 Class 0680: 8086:7113 (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9


