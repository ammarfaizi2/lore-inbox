Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUFTCcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUFTCcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 22:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUFTCcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 22:32:39 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:46324 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264538AbUFTCcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 22:32:20 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Date: Sun, 20 Jun 2004 04:31:44 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QcP1AJJHWKD4s3g"
Message-Id: <200406200431.44576.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QcP1AJJHWKD4s3g
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have the same problem.

Everything seems to be double speed. The keys, the little moving icon in th=
e=20
top right off the konqueror window  and the cursor is blinking like mad.=20
glxgears fps are halved, like the fps in  unreal tournament 2004 demo.

There everything was incredidbly fast, but fps halved.

testgart showed only half of the ususal throughput.

Oh, and between a boot, recompiling some modules and reboot I lost over 500=
=20
secs.

Attached are dmesg output and config.

Gl=FCck Auf,
Volker

=2D-=20
Conclusions
 In a straight-up fight, the Empire squashes the Federation like a bug. Eve=
n=20
with its numerical advantage removed, the Empire would still squash the=20
=46ederation like a bug. Accept it. -Michael Wong

--Boundary-00=_QcP1AJJHWKD4s3g
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.out"

Linux version 2.6.7 (root@energy.heim10.tu-clausthal.de) (gcc-Version 3.4.0 20040601 (Gentoo Linux 3.4.0-r6, ssp-3.4-2, pie-8.7.6.3)) #2 Sun Jun 20 03:33:47 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fbc70
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fab70
ACPI: RSDT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0000
ACPI: FADT (v001 AMIINT SiS740XX 0x00000011 MSFT 0x0100000b) @ 0x1fff0030
ACPI: MADT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x1fff00c0
ACPI: DSDT (v001    SiS      746 0x00000100 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda3 gentoo=noudev vga=792 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1666.922 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 516548k/524224k available (1794k kernel code, 6912k reserved, 566k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3309.56 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1666.0376 MHz.
..... host bus clock speed is 266.0620 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    D9
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    D1
 13 001 01  1    1    0   1   0    1    1    C9
 14 001 01  1    1    0   1   0    1    1    B1
 15 001 01  1    1    0   1   0    1    1    B9
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 0:0-> 0:2
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
IRQ23 -> 0:23
.................................... done.
vesafb: framebuffer at 0xc0000000, mapped to 0xe0807000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e280
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
Console: switching to colour frame buffer device 128x48
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SP1213N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ARTEC WRR-4848 1.00, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM BDV212B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem e0e0c000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 21, pci mem e0e0e000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-1.2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:03.1-1.2
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1
st: Version 20040403, fixed bufsize 32768, s/g segs 256
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 19, 00:0c:6e:08:f5:5c.
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: irq 23, pci mem e0f51000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
usb 2-1: USB disconnect, address 2
usb 2-1.2: USB disconnect, address 3
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
Linux video capture interface: v1.00
bttv: driver version 0.9.14 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
bttv0: Bt848 (rev 18) at 0000:00:0b.0, irq: 19, latency: 128, mmio: 0xcdcff000
bttv0: using: Terratec TerraTV+ Version 1.0 (Bt848)/ Terra TValue Version 1.0/ Vobis TV-Boostar [card=25,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
ohci_hcd 0000:00:03.1: remote wakeup
usb 2-1: new full speed USB device using address 4
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
bttv0: tea5757: read timeout
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt848 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
usb 2-1.2: new low speed USB device using address 5
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:03.1-1.2
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
Real Time Clock Driver v1.12
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2944 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000000 
eth0: Media Link On 100mbps full-duplex 

--Boundary-00=_QcP1AJJHWKD4s3g
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
XeUhn1BSZFbotf6tjb+I/Gw1KGcAAA==

--Boundary-00=_QcP1AJJHWKD4s3g--
