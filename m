Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLGOti>; Sat, 7 Dec 2002 09:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSLGOti>; Sat, 7 Dec 2002 09:49:38 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:11419 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id <S263794AbSLGOtW>;
	Sat, 7 Dec 2002 09:49:22 -0500
Subject: Re: [2.4.20] Problems with yenta PCMCIA socket (worked with 2.4.19)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DF0E878.5020005@colorfullife.com>
References: <3DF0E878.5020005@colorfullife.com>
Content-Type: multipart/mixed; boundary="=-qqTLMIoz1Ge6vdSCzSiV"
Organization: 
Message-Id: <1039273099.990.14.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 07 Dec 2002 15:58:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qqTLMIoz1Ge6vdSCzSiV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here are the requested files, both from stock kernels. If you need more
info I am happy to supply it.

Greetings,

Jurgen



--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=dmesg-2.4.19
Content-Type: text/plain; name=dmesg-2.4.19; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.4.19 (root@mobilus.slim) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Fri Dec 6 16:08:07 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000effb000 (usable)
 BIOS-e820: 000000000effb000 - 000000000efff000 (ACPI data)
 BIOS-e820: 000000000efff000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
239MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 61435
zone(0): 4096 pages.
zone(1): 57339 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro BOOT_FILE=/vmlinuz
Initializing CPU#0
Detected 797.465 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 240892k/245740k available (1158k kernel code, 4460k reserved, 375k data, 80k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU       800MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0f50, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: BIOS reporting unknown device 00:48
PCI: Device 00:49 not found by BIOS
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Power Resource: found
EC: found, GPE 29
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1, 8 throttling states
ACPI: Battery socket found, battery present
ACPI: Battery socket found, battery present
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
ACPI: Thermal Zone found
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS630
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3648/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 > hda4
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:09.0
PCI: Sharing IRQ 11 with 00:09.1
PCI: Sharing IRQ 11 with 00:09.2
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:09.0
PCI: Sharing IRQ 11 with 00:09.2
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0408, PCI irq11
Socket status: 30000410
Yenta IRQ list 0408, PCI irq11
Socket status: 30000006
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 80k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 4 for device 00:01.2
PCI: Sharing IRQ 4 with 00:01.3
PCI: Sharing IRQ 4 with 00:0a.0
usb-ohci.c: USB OHCI at membase 0xcf82a000, IRQ 4
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 4 for device 00:01.3
PCI: Sharing IRQ 4 with 00:01.2
PCI: Sharing IRQ 4 with 00:0a.0
usb-ohci.c: USB OHCI at membase 0xcf82c000, IRQ 4
usb-ohci.c: usb-00:01.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,4), internal journal
Adding Swap: 248968k swap-space (priority -1)
ohci1394: $Rev: 530 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 4 for device 00:0a.0
PCI: Sharing IRQ 4 with 00:01.2
PCI: Sharing IRQ 4 with 00:01.3
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[4]  MMIO=[d1000000-d1000800]  Max Packet=[2048]
ieee1394: Host added: Node[00:1023]  GUID[00e0180003032e50]  [Linux OHCI-1394]
sis900.c: v1.08.04 4/25/2002
PCI: Found IRQ 5 for device 00:01.1
PCI: Sharing IRQ 5 with 00:01.6
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 5, 00:80:88:03:70:32.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0007:001c
eth1: Looks like a Lucent/Agere firmware version 7.28
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:52:F5:E3
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 189M
agpgart: Detected SiS 630 chipset
agpgart: AGP aperture is 64M @ 0xd4000000
spurious 8259A interrupt: IRQ7.

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=dmesg-2.4.20
Content-Type: text/plain; name=dmesg-2.4.20; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.4.20 (root@mobilus.slim) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Sat Dec 7 15:34:00 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000effb000 (usable)
 BIOS-e820: 000000000effb000 - 000000000efff000 (ACPI data)
 BIOS-e820: 000000000efff000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
239MB LOWMEM available.
On node 0 totalpages: 61435
zone(0): 4096 pages.
zone(1): 57339 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro BOOT_FILE=/vmlinuz level 3
Initializing CPU#0
Detected 797.465 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 240752k/245740k available (1237k kernel code, 4600k reserved, 434k data, 76k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU       800MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0f50, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: BIOS reporting unknown device 00:48
PCI: Device 00:49 not found by BIOS
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..................................................................................................................................................
146 Control Methods found and parsed (534 nodes total)
ACPI Namespace successfully loaded at root c02c5c60
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-35] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:...........................................
43 Devices found: 43 _STA, 3 _INI
Completing Region and Field initialization:..............................
30/37 Regions, 0/0 Fields initialized (534 nodes total)
ACPI: Subsystem enabled
Power Resource: found
EC: found, GPE 29
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1, 8 throttling states
ACPI: Battery socket found, battery present
ACPI: Battery socket found, battery present
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
ACPI: Thermal Zone found
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS630
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c02dc304, I/O limit 4095Mb (mask 0xffffffff)
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3648/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 > hda4
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:09.0
PCI: Sharing IRQ 11 with 00:09.1
PCI: Sharing IRQ 11 with 00:09.2
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:09.0
PCI: Sharing IRQ 11 with 00:09.2
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0408, PCI irq11
Socket status: 30000410
Yenta IRQ list 0408, PCI irq11
Socket status: 30000006
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 4 for device 00:01.2
PCI: Sharing IRQ 4 with 00:01.3
PCI: Sharing IRQ 4 with 00:0a.0
usb-ohci.c: USB OHCI at membase 0xcf82a000, IRQ 4
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 4 for device 00:01.3
PCI: Sharing IRQ 4 with 00:01.2
PCI: Sharing IRQ 4 with 00:0a.0
usb-ohci.c: USB OHCI at membase 0xcf82c000, IRQ 4
usb-ohci.c: usb-00:01.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
Adding Swap: 248968k swap-space (priority -1)
ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 4 for device 00:0a.0
PCI: Sharing IRQ 4 with 00:01.2
PCI: Sharing IRQ 4 with 00:01.3
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[4]  MMIO=[d1000000-d10007ff]  Max Packet=[2048]
ieee1394: Host added: Node[00:1023]  GUID[00e0180003032e50]  [Linux OHCI-1394]
sis900.c: v1.08.06 9/24/2002
PCI: Found IRQ 5 for device 00:01.1
PCI: Sharing IRQ 5 with 00:01.6
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 5, 00:80:88:03:70:32.
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs: RequestIRQ: Resource in use

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=iomem-2.4.19
Content-Type: text/plain; name=iomem-2.4.19; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0effafff : System RAM
  00100000-00221b0a : Kernel code
  00221b0b-0027f79f : Kernel data
0effb000-0effefff : ACPI Tables
0efff000-0effffff : ACPI Non-volatile Storage
10000000-10000fff : Ricoh Co Ltd RL5c476 II
10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
10002000-100020ff : PCI device 1180:0576 (Ricoh Co Ltd)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
a0000000-a0000fff : card services
d0800000-d0803fff : Texas Instruments TSB43AB21 IEEE-1394 Controller (PHY/Link) 1394a-2000
d1000000-d10007ff : Texas Instruments TSB43AB21 IEEE-1394 Controller (PHY/Link) 1394a-2000
  d1000000-d10007ff : ohci1394
d1800000-d1ffffff : PCI Bus #01
  d1800000-d181ffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
d2000000-d2000fff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
d2800000-d2800fff : Silicon Integrated Systems [SiS] 7001 (#2)
  d2800000-d2800fff : usb-ohci
d3000000-d3000fff : Silicon Integrated Systems [SiS] 7001
  d3000000-d3000fff : usb-ohci
d3800000-d3800fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d3800000-d3800fff : sis900
d4000000-d7ffffff : Silicon Integrated Systems [SiS] 630 Host
d8000000-e7efffff : PCI Bus #01
  d8000000-dfffffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
ffff0000-ffffffff : reserved

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=iomem-2.4.20
Content-Type: text/plain; name=iomem-2.4.20; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0effafff : System RAM
  00100000-00235616 : Kernel code
  00235617-002a215f : Kernel data
0effb000-0effefff : ACPI Tables
0efff000-0effffff : ACPI Non-volatile Storage
10000000-10000fff : Ricoh Co Ltd RL5c476 II
10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
10002000-100020ff : PCI device 1180:0576 (Ricoh Co Ltd)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
60000000-60000fff : card services
d0800000-d0803fff : Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
d1000000-d10007ff : Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
  d1000000-d10007ff : ohci1394
d1800000-d1ffffff : PCI Bus #01
  d1800000-d181ffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
d2000000-d2000fff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
d2800000-d2800fff : Silicon Integrated Systems [SiS] 7001 (#2)
  d2800000-d2800fff : usb-ohci
d3000000-d3000fff : Silicon Integrated Systems [SiS] 7001
  d3000000-d3000fff : usb-ohci
d3800000-d3800fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d3800000-d3800fff : sis900
d4000000-d7ffffff : Silicon Integrated Systems [SiS] 630 Host
d8000000-e7efffff : PCI Bus #01
  d8000000-dfffffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
ffff0000-ffffffff : reserved

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=ioports-2.4.19
Content-Type: text/plain; name=ioports-2.4.19; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
a000-afff : PCI Bus #01
  a800-a87f : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
b400-b47f : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible)
b800-b8ff : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible)
d000-d0ff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
d400-d4ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d400-d4ff : sis900
d800-d80f : Silicon Integrated Systems [SiS] 5513 [IDE]
  d800-d807 : ide0

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=ioports-2.4.20
Content-Type: text/plain; name=ioports-2.4.20; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
a000-afff : PCI Bus #01
  a800-a87f : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
b400-b47f : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible)
b800-b8ff : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible)
d000-d0ff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
d400-d4ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d400-d4ff : sis900
d800-d80f : Silicon Integrated Systems [SiS] 5513 [IDE]
  d800-d807 : ide0

--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=lspci-2.4.19
Content-Type: text/plain; name=lspci-2.4.19; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Flags: bus master, medium devsel, latency 32
	Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, fast devsel, latency 16
	I/O ports at d800 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 82)
	Subsystem: Asustek Computer, Inc.: Unknown device 1455
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=256]
	Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [40] Power Management version 2

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d3000000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7000
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d2800000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1473
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at d000 [size=256]
	Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:01.6 Modem: Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible) (rev a0) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1616
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b800 [size=256]
	I/O ports at b400 [size=128]
	Capabilities: [48] Power Management version 2

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Flags: bus master, VGA palette snoop, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: d1800000-d1ffffff
	Prefetchable memory behind bridge: d8000000-e7efffff

00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:09.2 System peripheral: Ricoh Co Ltd: Unknown device 0576
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: medium devsel, IRQ 11
	Memory at 10002000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2

00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1677
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d1000000 (32-bit, non-prefetchable) [size=2K]
	Memory at d0800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1672
	Flags: 66Mhz, medium devsel
	BIST result: 00
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Memory at d1800000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a800 [size=128]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0


--=-qqTLMIoz1Ge6vdSCzSiV
Content-Disposition: attachment; filename=lspci-2.4.20
Content-Type: text/plain; name=lspci-2.4.20; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Flags: bus master, medium devsel, latency 32
	Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, fast devsel, latency 16
	I/O ports at d800 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 82)
	Subsystem: Asustek Computer, Inc.: Unknown device 1455
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=256]
	Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [40] Power Management version 2

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d3000000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7000
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d2800000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1473
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at d000 [size=256]
	Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:01.6 Modem: Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible) (rev a0) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1616
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b800 [size=256]
	I/O ports at b400 [size=128]
	Capabilities: [48] Power Management version 2

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Flags: bus master, VGA palette snoop, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: d1800000-d1ffffff
	Prefetchable memory behind bridge: d8000000-e7efffff

00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:09.2 System peripheral: Ricoh Co Ltd: Unknown device 0576
	Subsystem: Asustek Computer, Inc.: Unknown device 1674
	Flags: medium devsel, IRQ 11
	Memory at 10002000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2

00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1677
	Flags: bus master, medium devsel, latency 32, IRQ 4
	Memory at d1000000 (32-bit, non-prefetchable) [size=2K]
	Memory at d0800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1672
	Flags: 66Mhz, medium devsel
	BIST result: 00
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Memory at d1800000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a800 [size=128]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0


--=-qqTLMIoz1Ge6vdSCzSiV--

