Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTFAL22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTFAL22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:28:28 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:4457 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S263570AbTFAL2V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:28:21 -0400
Subject: 2.5.70 ibm trackpoint weirdness
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jun 2003 13:41:41 +0200
Message-Id: <1054467702.893.10.camel@gmicsko03>
Mime-Version: 1.0
X-OriginalArrivalTime: 01 Jun 2003 11:41:42.0871 (UTC) FILETIME=[C5CFC670:01C32832]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sometimes my trackpoint (ibm r32 notebook built in mouse) totally out of
control (randomly) under X11. Under 2.4.x kernels works fine.

Error message from syslog:

Jun  1 13:32:18 gmicsko03 kernel: psmouse.c: Lost synchronization,
throwing 2 bytes away.
Jun  1 13:35:22 gmicsko03 kernel: psmouse.c: Lost synchronization,
throwing 2 bytes away.



dmesg:

Linux version 2.5.70 (root@gmicsko03) (gcc version 2.95.4 20011002
(Debian prerelease)) #4 Sun Jun 1 12:41:55 CEST 2003
Video mode to be used for restore is 318
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff70000 (usable)
 BIOS-e820: 000000000ff70000 - 000000000ff7a000 (ACPI data)
 BIOS-e820: 000000000ff7a000 - 000000000ff7c000 (ACPI NVS)
 BIOS-e820: 000000000ff7c000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65392
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61296 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux-2.5 ro root=305
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1700.227 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3350.52 BogoMIPS
Memory: 254728k/261568k available (2120k kernel code, 6124k reserved,
1038k data, 144k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd91e, last bus=5
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7150
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9f57, dseg 0x400
PnPBIOS: 22 nodes reported by PnP BIOS; 22 recorded by driver
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: IRQ 0 for device 00:1f.1 doesn't match PIRQ mask - try
pci=usepirqmask
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:09.0
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 11 for device 02:08.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and
others)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
PCI: Found IRQ 11 for device 02:09.0
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
Yenta IRQ list 06f8, PCI irq11
Socket status: 30000010
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci-hcd 00:1d.0: Intel Corp. 82801CA/CAM USB (Hub
uhci-hcd 00:1d.0: irq 11, io base 00001800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
uhci-hcd 00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
uhci-hcd 00:1d.1: Intel Corp. 82801CA/CAM USB (Hub
uhci-hcd 00:1d.1: irq 11, io base 00001820
uhci-hcd 00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Setting latency timer of device 00:1d.2 to 64
uhci-hcd 00:1d.2: Intel Corp. 82801CA/CAM USB (Hub
uhci-hcd 00:1d.2: irq 11, io base 00001840
uhci-hcd 00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Intel 810 + AC97 Audio, version 0.24, 11:42:49 Jun  1 2003
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.6
PCI: Sharing IRQ 11 with 02:09.0
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, MEM 0x0000 and 0x0000,
IRQ 11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS72 (Analog Devices AD1881A)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not
present), total channels = 2
i810_audio: setting clocking to 48730
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (2043 buckets, 16344 max) - 164 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session:
CDROMMULTISESSION not supported: rc=-25
UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048
byte sectors)
UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte
32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block
256, tag 16777215 != 256
UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block
found
UDF-fs: No partition found (1)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 136040k swap on /dev/hda6.  Priority:-1 extents:1
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x3f8-0x3ff
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: Station identity 001f:0002:0001:0001
eth1: Looks like a Symbol firmware version [V2.00-17] (parsing to 20017)
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:B3:04:7C:20
eth1: Station name "Prism  I"
eth1: firmware ALLOC bug detected (old Symbol firmware?). Trying to work
around... ok.
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x0147
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 01:00.0 into 1x mode
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
spurious 8259A interrupt: IRQ7.
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
psmouse.c: Lost synchronization, throwing 2 bytes away.
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 1, assigned address 2
HID device not claimed by input or hiddev
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 01:00.0 into 1x mode
psmouse.c: Lost synchronization, throwing 2 bytes away.
usb 2-1: USB disconnect, address 2
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.

Any idea?

-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út.2.
Tel: +36 96 502-216
Fax: +36 96 318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/

