Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUCCPhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUCCPhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:37:19 -0500
Received: from emn-agsl-4744.mxs.adsl.euronet.nl ([212.129.199.68]:5902 "EHLO
	kapteyn.telox.net") by vger.kernel.org with ESMTP id S262504AbUCCPgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:36:32 -0500
Date: Wed, 3 Mar 2004 16:30:06 +0100
From: Wouter Lueks <wouter@telox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040303153005.GI31279@telox.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com> <20040303123340.GH31279@telox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <20040303123340.GH31279@telox.net>
X-Operating-System: Linux kapteyn 2.4.18 #1 Wed Jun 11 07:47:21 CEST 2003 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 03, 2004 at 01:33:40PM +0100, Wouter Lueks wrote:
> See the attached dmesg file I get one error more. On top of that I have
> enabled usb debugging so perhaps the dmesg file yields more result when
> someone who knows this subsystem can see what is happening here.
> Personally I lack the experience to fix this problem. When you need any
> more information I'll be happy to provide it.

Which attached file ;). Here it is.

--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.2 (root@newton) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 Sun Feb 8 12:12:08 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f6330
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 65408
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61312 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6300
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0fefbddc
ACPI: FADT (v001 INTEL  WTVV     0x06040000 PTL  0x00000008) @ 0x0fefef32
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x0fefefa6
ACPI: DSDT (v001    NEC          0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: WTVV+ICH2    APIC at: 0xFEE00000
I/O APIC #1 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: 
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1879.179 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 254680k/261632k available (2286k kernel code, 6160k reserved, 906k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3702.78 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 1.90GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1878.0242 MHz.
..... host bus clock speed is 98.0854 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9ab, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD OFFICEJET PRO 1150C
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xd0816000, 00:30:f1:1e:29:7c, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST360020A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD-ROM DV-5800A, ATAPI CD/DVD-ROM drive
hdd: R/RW 12x8x32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63
 hda: hda1 < hda5 hda6 > hda2
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0x3400, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ACPI: (supports S0 S1 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 706820k swap on /dev/hda6.  Priority:-1 extents:1
Disabled Privacy Extensions on device c03deda0(lo)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
lp0: using parport0 (polling).
lp0: console ready
spurious 8259A interrupt: IRQ7.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 9, io base 00001cc0
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:1f.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.2 uhci_hcd
usb usb1: SerialNumber: 0000:00:1f.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 11, io base 00001ce0
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:1f.4: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1f.4
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
drivers/usb/host/uhci-hcd.c: 1cc0: suspend_hc
drivers/usb/host/uhci-hcd.c: 1ce0: suspend_hc

------------- COPIED FROM SCREEN -------------
hub 1-0:1.0: new USB device on port 2, assigned address 2
usb 1-2: Pruduct: USB Keyboard
usb 1-2: Manufacturer: BTC
hun 1-2:1.0: USB hub found
hub 1-2:1.0: 2 ports detected
hub 1-2:1.0: new USB device on port 1, assigned address 3
usb 1-2.1: Product USB Keyboard
usb 1-2.1: Manufacturer: BTC
drivers/usb/input/hid-core.c: ctrl urb status -104 received
drvers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb-0000:00:1f.2-2.1
------------END COPIED FROM SCREEN ------------


--X3gaHHMYHkYqP6yf--
