Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbUDFJDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbUDFJDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:03:44 -0400
Received: from mailgate5.web.de ([217.72.192.165]:33680 "EHLO mailgate5.web.de")
	by vger.kernel.org with ESMTP id S263667AbUDFJDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:03:11 -0400
Date: Tue, 06 Apr 2004 11:00:06 +0200
Message-Id: <1205335994@web.de>
MIME-Version: 1.0
From: "Dirk Herzhauser" <Dirk.Herzhauser@web.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: BLUETOOTH Dongle causes freeze of System or error Message
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,



I've got a problem with Linux and Kernel 2.6.[0-5] with hotplugin of an
BLUETOOTH dongle. If I start up the System with the DONGLE the System works
fine, even if BLUETOOTH did not work, if I remove the Dongle the systems
hangs. If I plug the Dongle into an running System I receive the following
messages:



dmesg:

(acpi_id[0x00] high edge lint[0x1])

ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])

IOAPIC[0]: Assigned apic_id 2

IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)

Enabling APIC mode: Flat. Using 1 I/O APICs

Using ACPI (MADT) for SMP configuration information

Built 1 zonelists

Kernel command line: root=/dev/hda7 vga=extended

Initializing CPU#0

PID hash table entries: 2048 (order 11: 16384 bytes)

Detected 2400.296 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x50

Memory: 505632k/516032k available (2337k kernel code, 9612k reserved, 885k
data,

176k init, 0k highmem)

Checking if this processor honours the WP bit even in supervisor mode... Ok.

Calibrating delay loop... 4734.97 BogoMIPS

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd

Freeing initrd memory: 882k freed

CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000

CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 128K

CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available

CPU#0: Thermal monitoring enabled

CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

enabled ExtINT on CPU#0

ESR value before enabling vector: 00000000

ESR value after enabling vector: 00000000

ENABLING IO-APIC IRQs

init IO_APIC IRQs

IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not co

nnected.

..TIMER: vector=0x31 pin1=2 pin2=-1

Using local APIC timer interrupts.

calibrating APIC timer ...

..... CPU clock speed is 2399.0674 MHz.

..... host bus clock speed is 99.0986 MHz.

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfb800, last bus=1

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20040326

ACPI: Interpreter enabled

ACPI: Using IOAPIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1

Transparent bridge - 0000:00:1e.0

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

SCSI subsystem initialized

drivers/usb/core/usb.c: registered new driver usbfs

drivers/usb/core/usb.c: registered new driver hub

IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)

00:00:1e[A] -> 2-16 -> IRQ 16

IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)

00:00:1e[B] -> 2-17 -> IRQ 17

IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)

00:00:1e[C] -> 2-18 -> IRQ 18

IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)

00:00:1e[D] -> 2-19 -> IRQ 19

IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)

00:00:1d[D] -> 2-23 -> IRQ 23

IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)

00:01:08[A] -> 2-20 -> IRQ 20

IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)

00:01:08[B] -> 2-21 -> IRQ 21

IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)

00:01:08[C] -> 2-22 -> IRQ 22

number of MP IRQ sources: 15.

number of IO-APIC #2 registers: 24.

testing the IO APIC.......................

IO APIC #2......

.... register #00: 02000000

....... : physical APIC id: 02

....... : Delivery Type: 0

....... : LTS : 0

.... register #01: 00178020

....... : max redirection entries: 0017

....... : PRQ implemented: 1

....... : IO APIC version: 0020

.... register #02: 00000000

....... : arbitration: 00

.... register #03: 00000001

....... : Boot DT : 1

.... IRQ redirection table:

NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:

00 000 00 1 0 0 0 0 0 0 00

01 001 01 0 0 0 0 0 1 1 39

02 001 01 0 0 0 0 0 1 1 31

03 001 01 0 0 0 0 0 1 1 41

04 001 01 0 0 0 0 0 1 1 49

05 001 01 0 0 0 0 0 1 1 51

06 001 01 0 0 0 0 0 1 1 59

07 001 01 0 0 0 0 0 1 1 61

08 001 01 0 0 0 0 0 1 1 69

09 001 01 0 1 0 0 0 1 1 71

0a 001 01 0 0 0 0 0 1 1 79

0b 001 01 0 0 0 0 0 1 1 81

0c 001 01 0 0 0 0 0 1 1 89

0d 001 01 0 0 0 0 0 1 1 91

0e 001 01 0 0 0 0 0 1 1 99

0f 001 01 0 0 0 0 0 1 1 A1

10 001 01 1 1 0 1 0 1 1 A9

11 001 01 1 1 0 1 0 1 1 B1

12 001 01 1 1 0 1 0 1 1 B9

13 001 01 1 1 0 1 0 1 1 C1

14 001 01 1 1 0 1 0 1 1 D1

15 001 01 1 1 0 1 0 1 1 D9

16 001 01 1 1 0 1 0 1 1 E1

17 001 01 1 1 0 1 0 1 1 C9

IRQ to pin mappings:

IRQ0 -> 0:2

IRQ1 -> 0:1

IRQ3 -> 0:3

IRQ4 -> 0:4

IRQ5 -> 0:5

IRQ6 -> 0:6

IRQ7 -> 0:7

IRQ8 -> 0:8

IRQ9 -> 0:9

IRQ10 -> 0:10

IRQ11 -> 0:11

IRQ12 -> 0:12

IRQ13 -> 0:13

IRQ14 -> 0:14

IRQ15 -> 0:15

IRQ16 -> 0:16

IRQ17 -> 0:17

IRQ18 -> 0:18

IRQ19 -> 0:19

IRQ20 -> 0:20

IRQ21 -> 0:21

IRQ22 -> 0:22

IRQ23 -> 0:23

.................................... done.

PCI: Using ACPI for IRQ routing

PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off

'

Bluetooth: Core ver 2.4

NET: Registered protocol family 31

Bluetooth: HCI device and connection manager initialized

Bluetooth: HCI socket layer initialized

agpgart: Detected an Intel 845G Chipset.

agpgart: Maximum main memory to use for agp memory: 431M

agpgart: Detected 8060K stolen memory.

agpgart: AGP aperture is 128M @ 0xd8000000

Simple Boot Flag at 0x39 set to 0x80

Machine check exception polling timer started.

ikconfig 0.7 with /proc/config*

udf: registering filesystem

Initializing Cryptographic API

ACPI: Power Button (FF) [PWRF]

ACPI: Sleep Button (CM) [SLPB]

ACPI: Fan [FAN] (on)

ACPI: Processor [CPU0] (supports C1)

ACPI: Thermal Zone [THRM] (22 C)

Linux agpgart interface v0.100 (c) Dave Jones

[drm] Initialized i830 1.3.2 20021108 on minor 0

Using anticipatory io scheduler

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

nbd: registered device at major 43

8139too Fast Ethernet driver 0.9.27

eth0: RealTek RTL8139 at 0xc000, 00:0c:76:9b:75:8c, IRQ 21

eth0: Identified 8139 chip type 'RTL-8101'

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

ICH4: IDE controller at PCI slot 0000:00:1f.1

ICH4: chipset revision 2

ICH4: not 100% native mode: will probe irqs later

ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio

ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio

hda: ST340015A, ATA DISK drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: SONY CD-RW CRX300E, ATAPI CD/DVD-ROM drive

hdd: Maxtor 6Y080L0, ATA DISK drive

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 128KiB

hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)

hda: hda1 hda2 < hda5 hda6 hda7 >

hdd: max request size: 128KiB

hdd: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)

hdd: hdd1 hdd2 < hdd5hdd: dma_intr: status=0x51 { DriveReady SeekComplete
Error

}

hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }

hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }

hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }

hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }

hdc: DMA disabled

ide1: reset: success

hdd6 >

hdc: ATAPI 32X DVD-ROM CD-R/RW CD-MRW drive, 2048kB Cache

Uniform CD-ROM driver Revision: 3.20

ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2

PCI: Setting latency timer of device 0000:00:1d.7 to 64

ehci_hcd 0000:00:1d.7: irq 23, pci mem e008d000

ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1

PCI: cache line size of 128 is not supported by device 0000:00:1d.7

ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 6 ports detected

USB Universal Host Controller Interface driver v2.2

uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)

PCI: Setting latency timer of device 0000:00:1d.0 to 64

uhci_hcd 0000:00:1d.0: irq 16, io base 0000d800

uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2

hub 2-0:1.0: USB hub found

hub 2-0:1.0: 2 ports detected

uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)

PCI: Setting latency timer of device 0000:00:1d.1 to 64

uhci_hcd 0000:00:1d.1: irq 19, io base 0000d000

uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3

hub 3-0:1.0: USB hub found

hub 3-0:1.0: 2 ports detected

uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)

PCI: Setting latency timer of device 0000:00:1d.2 to 64

uhci_hcd 0000:00:1d.2: irq 18, io base 0000d400

uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4

hub 4-0:1.0: USB hub found

hub 4-0:1.0: 2 ports detected

drivers/usb/core/usb.c: registered new driver usblp

drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver

Initializing USB Mass Storage driver...

drivers/usb/core/usb.c: registered new driver usb-storage

USB Mass Storage support registered.

drivers/usb/core/usb.c: registered new driver hid

drivers/usb/input/hid-core.c: v2.0:USB HID core driver

mice: PS/2 mouse device common for all mice

input: PC Speaker

serio: i8042 AUX port at 0x60,0x64 irq 12

input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

serio: i8042 KBD port at 0x60,0x64 irq 1

input: AT Translated Set 2 keyboard on isa0060/serio0

Bluetooth: BlueFRITZ! USB driver ver 1.1

drivers/usb/core/usb.c: registered new driver bfusb

Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30
08:19:30 2

004 UTC).

PCI: Setting latency timer of device 0000:00:1f.5 to 64

intel8x0_measure_ac97_clock: measured 49298 usecs

intel8x0: clocking to 48000

ALSA device list:

#0: Intel 82801DB-ICH4 at 0xe2081000, irq 17

NET: Registered protocol family 2

IP: routing cache hash table of 4096 buckets, 32Kbytes

TCP: Hash tables configured (established 32768 bind 65536)

NET: Registered protocol family 1

NET: Registered protocol family 17

NET: Registered protocol family 15

ACPI: (supports S0 S3 S4 S5)

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem).

EXT3-fs: INFO: recovery required on readonly filesystem.

EXT3-fs: write access will be enabled during recovery.

(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0,
recover

ed transactions 269367 to 269722

(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 3114 and revoked
1/1 bl

ocks

kjournald starting. Commit interval 5 seconds

EXT3-fs: recovery complete.

EXT3-fs: mounted filesystem with ordered data mode.

VFS: Mounted root (ext3 filesystem) readonly.

Trying to move old root to /initrd ... failed

Unmounting old root

Trying to free ramdisk memory ... okay

Freeing unused kernel memory: 176k freed

EXT3 FS on hda7, internal journal

EXT3 FS on hda7, internal journal

EXT3 FS on hda7, internal journal

kjournald starting. Commit interval 5 seconds

EXT3 FS on hdd6, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS on hda6, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS on hdd5, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

Adding 2104472k swap on /dev/hdd1. Priority:42 extents:1

hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }



hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }

blk: queue c173de00, I/O limit 4095Mb (mask 0xffffffff)

hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }



hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }

hdc: CHECK for good STATUS

blk: queue c173d200, I/O limit 4095Mb (mask 0xffffffff)

Real Time Clock Driver v1.12

eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1

ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

ohci_hcd: block sizes: ed 64 td 64

ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

ohci_hcd: block sizes: ed 64 td 64

Bluetooth: HCI USB driver ver 2.5

drivers/usb/core/usb.c: registered new driver hci_usb

Bluetooth: HCI UART driver ver 2.1

Bluetooth: HCI H4 protocol initialized

Bluetooth: HCI BCSP protocol initialized

Bluetooth: VHCI driver ver 1.1

Bluetooth: L2CAP ver 2.1

Bluetooth: L2CAP socket layer initialized

usb 4-1: new full speed USB device using address 2

Unable to handle kernel NULL pointer dereference at virtual address 00000004

printing eip:

c02761fe

*pde = 00000000

Oops: 0000 [#1]

PREEMPT

CPU: 0

EIP: 0060:[<c02761fe>] Not tainted

EFLAGS: 00010282 (2.6.5)

EIP is at usb_disable_interface+0x14/0x46

eax: db844b80 ebx: 00000000 ecx: df50e000 edx: 0000002d

esi: 00000002 edi: 00000000 ebp: db9c8400 esp: df50fd40

ds: 007b es: 007b ss: 0068

Process khubd (pid: 5, threadinfo=df50e000 task=df628080)

Stack: 00000002 0000000b 00000001 00000002 db8441b0 db9c8400 c02772fa
db9c8400

db844b80 0000000b 00000001 00000002 00000001 00000000 00000000
00001388

00000000 db844b80 00000000 db844280 db844338 00000000 e01a9691
db9c8400

Call Trace:

[<c02772fa>] usb_set_interface+0xb7/0x173

[<e01a9691>] hci_usb_probe+0x30d/0x4c6 [hci_usb]

_____________________________________________________________________
Der WEB.DE Virenschutz schuetzt Ihr Postfach vor dem Wurm Netsky.A-P!
Kostenfrei fuer alle FreeMail Nutzer. http://f.web.de/?mc=021157

