Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbTG1VB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTG1U7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:59:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:39307 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271129AbTG1U5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:57:54 -0400
Message-ID: <3F258E53.3070204@gmx.de>
Date: Mon, 28 Jul 2003 22:57:55 +0200
From: Alexander Rau <al.rau@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2
 -- linux-2.5.75-acpi-irqparams-final4.patch
References: <200307272305.12412.adq_dvb@lidskialf.net> <200307281638.24474.adq_dvb@lidskialf.net> <3F2546EF.9030803@gmx.de> <200307281653.58216.adq_dvb@lidskialf.net> <3F254E5F.8040700@gmx.de>
In-Reply-To: <3F254E5F.8040700@gmx.de>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Rau wrote:
> Andrew de Quincey wrote:
> 
>> On Monday 28 July 2003 16:53, you wrote:
>>
>>> Andrew de Quincey wrote:
>>>
>>>> Weird! I compiled it on 2.6.0-test2 last night (for a thinkpad T20), 
>>>> and
>>>> it was fine..... (and the thinkpad works fine too)
>>>>
>>>> Send me your .config file so I can fix the patch, please.
>>>>
>>> Hope this solved the problems on my T40p too :)
>>
>>
>>
>> Ta, lemme know how it goes.
>>
>>
> 
> Sorry, there's still a kernel oops during bootup. I'll provide a kernel 
> trace when I'm back at home.
> 
> Regards, Al
> 

I tried to dump the kernel messages onto my printer. Unfortunatly it 
doesn't print anything, only with acpi=off.

This is somehow unconventional, but here's a link for a screenshot of 
the trace. Sorry, one screen is missing but the messages were too fast 
for my camera :) I can still recognize a lots of ......... on the 
missing screen.

http://w3studi.informatik.uni-stuttgart.de/~rauar/IMG_1120.JPG


Here's the kernel output with acpi=off.

--------------------------------------------------------------------------


Linux version 2.6.0-test2 (root@aphrodite) (gcc version 3.2.3 20030422 
(Gentoo Linux 1.4 3.2.3-r1, propolice)) #1 SMP Mon Jul 28 18:17:12 CEST 2003
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
  BIOS-e820: 000000001ff60000 - 000000001ff79000 (ACPI data)
  BIOS-e820: 000000001ff79000 - 000000001ff7b000 (ACPI NVS)
  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126816 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 acpi=off 
video=radeonfb:1400x1050x24@60 vga=0x00567
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 598.191 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 1179.64 BogoMIPS
Memory: 512716k/523648k available (2500k kernel code, 10184k reserved, 
1040k data, 172k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After generic, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) M processor 1600MHz stepping 05
per-CPU timeslice cutoff: 2925.79 usecs.
task migration cache decay timeout: 3 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 597.0993 MHz.
..... host bus clock speed is 99.0665 MHz.
Starting migration thread for cpu 0
CPUS done 32
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd906, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.96 (c) Adam Belay
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
PCI: Found IRQ 5 for device 0000:00:1f.6
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:02:00.1
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Hewlett-Packard hp LaserJet 1300
lp0: using parport0 (polling).
lp0: console ready
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:02.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: setmax LBA 78140160, native  73004018
hda: 73004018 sectors (37378 MB) w/7898KiB Cache, CHS=72424/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB EHCI Con
ehci_hcd 0000:00:1d.7: irq 11, pci mem e084a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
uhci-hcd 0000:00:1d.0: irq 11, io base 00001800
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
uhci-hcd 0000:00:1d.1: irq 11, io base 00001820
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:02.0
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
uhci-hcd 0000:00:1d.2: irq 11, io base 00001840
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 
12:01:18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.6
PCI: Sharing IRQ 5 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 3-0:0: new USB device on port 1, assigned address 2
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel 82801DB-ICH4 at 0xc0000c00, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 172k freed
Adding 506512k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
Intel(R) PRO/1000 Network Driver - version 5.1.13-k2
Copyright (c) 1999-2003 Intel Corporation.
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
eth0: Intel(R) PRO/1000 Network Connection
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
ti113x: Routing card interrupts to PCI
Yenta IRQ list 0000, PCI irq11
Socket status: 30000011
PCI: Found IRQ 5 for device 0000:02:00.1
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.6
ti113x: Routing card interrupts to PCI
Yenta IRQ list 0000, PCI irq5
Socket status: 30000006
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.11
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0008:0048
eth1: Looks like a Lucent/Agere firmware version 8.72
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:42:CD:E7
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x013f
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:02:01.0
eth1: New link status: Connected (0001)
hub 1-0:0: debounce: port 4: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 3

