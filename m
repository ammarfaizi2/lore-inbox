Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTLTLTi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTLTLTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:19:38 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:15887 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S263876AbTLTLTa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:19:30 -0500
Date: Sat, 20 Dec 2003 12:19:28 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 don't boot (2.6.0-test9-bk16 does) (Attempted to kill init!)
Message-ID: <20031220111928.GA15124@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a Mandrake Cooker with 2.6.0-test9-bk16 and it works really
great, I haven't tested post 2.6.0-test9-bk16 kernels.
Compiling and booting the 2.6.0 with same config I got:

Linux version 2.6.0 (greg@greg.greg) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-3mdk)) #21 Sat Dec 20 00:34:22 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000fb900
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: I845E        APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: hda=ide-floppy hdc=ide-scsi root=/dev/sdb2 video=matroxfb:1600x1200-16@75 psmouse_rate=70 psmouse_resolution=400 console=ttyS1
ide_setup: hda=ide-floppy
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2205.107 MHz processor.
Console: colour VGA+ 80x25
Memory: 903628k/917504k available (2696k kernel code, 13092k reserved, 891k data, 168k init, 0k highmem)
Calibrating delay loop... 4341.76 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2204.0658 MHz.
..... host bus clock speed is 100.0211 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I1,P0) -> 17
PCI->APIC IRQ transform: (B3,I2,P0) -> 18
PCI->APIC IRQ transform: (B3,I3,P0) -> 19
PCI->APIC IRQ transform: (B3,I4,P0) -> 16
PCI->APIC IRQ transform: (B3,I8,P0) -> 20
PCI->APIC IRQ transform: (B3,I14,P0) -> 22
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x65536)
matroxfb: framebuffer at 0xDC000000, mapped to 0xf8805000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
SGI XFS for Linux with large block numbers, no debug enabled
Initializing Cryptographic API
Console: switching to colour frame buffer device 200x75
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: 0000:03:08.0, 00:10:DC:4E:BB:8E, IRQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20276: IDE controller at PCI slot 0000:03:0e.0
PDC20276: chipset revision 1
PDC20276: 100% native mode on irq 22
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
hdg: IC35L120AVVA07-0, ATA DISK drive
ide3 at 0xc000-0xc007,0xbc02 on irq 22
hdg: max request size: 128KiB
hdg: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 >
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
(scsi0:A:15): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR  VéroModel: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 15, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg4 at scsi1, channel 0, id 3, lun 0,  type 5
Console: switching to colour frame buffer device 200x75
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem fa83bc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: irq 16, io base 0000d400
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: irq 19, io base 0000d800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: irq 18, io base 0000dc00
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.6) at 0xb400, irq 16
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
XFS mounting filesystem sdb2
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
hub 4-0:1.0: new USB device on port 1, assigned address 2
INIT: version 2.85 booINIT: Kernel panic: Attempted to kill init!
INIT: cannot ex ecute "/etc/rc.d/rc.sysinit"
<6>SysRq : Resetting

Any idea what I should do?

I only read this ml through nntp so if you need some other info please
CC to me ;-)

Thank you very much,

	Grégoire
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
