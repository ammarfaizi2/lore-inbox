Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUFSXao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUFSXao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUFSXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:30:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:14294 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264398AbUFSXa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:30:26 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Date: Sun, 20 Jun 2004 02:37:51 +0200
User-Agent: KMail/1.6.2
Cc: florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040619210714.GD3243@iucha.net> <200406200207.16399.dominik.karall@gmx.net> <20040619162322.1d15c2dd.akpm@osdl.org>
In-Reply-To: <20040619162322.1d15c2dd.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hxN1Amu5ny9wAl1"
Message-Id: <200406200237.54067.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hxN1Amu5ny9wAl1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 20 June 2004 01:23, Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> > > dmesg and .config, please.
> >
> >  attached
>
> The dmesg output is incomplete.  You'll need to use `dmesg -s 1000000' to
> get all of it.
>
> I wish that would get fixed actually.  Seems a bit silly, and current
> kernels permit querying of the ringbuffer size.
'dmesg -s 1000000' output attached.

greets dominik

--Boundary-00=_hxN1Amu5ny9wAl1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.7-bk2 (root@debian) (gcc-Version 3.3.4 (Debian)) #1 SMP Sun Jun 20 00:33:20 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
found SMP MP-table at 000f58e0
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AWARD                                     ) @ 0x000f72b0
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: MADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff69c0
ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 20, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.7-bk2 ro root=30a hda=scsi hdb=scsi hdc=scsi hdd=scsi hde=scsi hdf=scsi hdg=scsi hdh=scsi apm=power-off nomce
ide_setup: hda=scsi
ide_setup: hdb=scsi
ide_setup: hdc=scsi
ide_setup: hdd=scsi
ide_setup: hde=scsi
ide_setup: hdf=scsi
ide_setup: hdg=scsi
ide_setup: hdh=scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2673.460 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 254564k/262080k available (2907k kernel code, 6784k reserved, 1188k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5275.64 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
per-CPU timeslice cutoff: 1462.65 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Total of 1 processors activated (5275.64 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2672.0393 MHz.
..... host bus clock speed is 133.0619 MHz.
Brought up 1 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb400, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *13
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178014
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0014
.... register #02: 02000000
.......     : arbitration: 02
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
 10 001 01  1    1    0   1   0    1    1    B1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    E1
 14 001 01  1    1    0   1   0    1    1    C1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D1
 17 001 01  1    1    0   1   0    1    1    D9
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
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
vesafb: framebuffer at 0xd8000000, mapped to 0xd0807000, size 10240k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: protected mode interface info at c000:e2d0
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [FUTS]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (42 C)
Console: switching to colour frame buffer device 160x64
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 128M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
Linux video capture interface: v1.00
saa7130/34: v4l2 driver version 0.2.11 loaded
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
saa7134[0]: found at 0000:00:08.0, rev: 1, irq: 19, latency: 32, mmio: 0xe2426000
saa7134[0]: subsystem: 16be:0003, board: Medion 7134 [card=12,autodetected]
saa7134[0]: board init: gpio is 0
saa7134[0]: i2c eeprom 00: be 16 03 00 08 20 1c 55 43 43 a9 1c 55 43 43 a9
saa7134[0]: i2c eeprom 10: ff ff ff ff 15 00 0e 01 0c c0 08 00 00 00 00 00
saa7134[0]: i2c eeprom 20: 00 00 00 e3 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
tda9887: chip found @ 0x86
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio
hda: ST3120023A, ATA DISK drive
hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [default]
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
ide-cd: passing drive hdb to ide-scsi emulation.
ide-cd: passing drive hdc to ide-scsi emulation.
ide-floppy driver 0.99.newide
ide-cd: passing drive hdb to ide-scsi emulation.
ide-cd: passing drive hdc to ide-scsi emulation.
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE       Model: DVD-ROM 16X       Rev: 2.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX210E1   Rev: 2YS2
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 1x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr1: scsi3-mmc drive: 20x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e2427000-e24277ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem d1251000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem d1253000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:03.1: irq 21, pci mem d1255000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ohci_hcd 0000:00:03.2: irq 22, pci mem d1257000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/none/none/1.1.2.2
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:03.2: remote wakeup
intel8x0_measure_ac97_clock: measured 99813 usecs
intel8x0: measured clock 24014 rejected
intel8x0: clocking to 48000
usb 3-1: new full speed USB device using address 2
ALSA device list:
  #0: SiS SI7012 at 0xd400, irq 18
NET: Registered protocol family 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000010dc001ee09a]
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2
usb 4-1: new full speed USB device using address 2
Adding 514040k swap on /dev/hda9.  Priority:-1 extents:1
EXT3 FS on hda10, internal journal
usb 4-1: control timeout on ep0in
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7004
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 31 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:3f:d9:bc.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
eth1: RealTek RTL8139 at 0xe000, 00:50:fc:3d:2b:5c, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8139C'
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
NET: Registered protocol family 4
NET: Registered protocol family 10
Disabled Privacy Extensions on device c04a0c60(lo)
IPv6 over IPv4 tunneling driver
PPP BSD Compression module registered
PPP Deflate Compression module registered
eth0: no IPv6 routers present

--Boundary-00=_hxN1Amu5ny9wAl1--
