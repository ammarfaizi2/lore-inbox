Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTDIGNi (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTDIGNi (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:13:38 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:260
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S261967AbTDIGNU (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 02:13:20 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Luming Yu'" <luming.yu@intel.com>
Cc: "'Adam Belay'" <ambx1@neo.rr.com>,
       "'Andrew Grover'" <andrew.grover@intel.com>,
       "'Len Brown'" <len.brown@intel.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.xx ACPI/Sb16 IRQ conflict - See bug #430 (ACPI + PCI are not aware of ISA interrupts in use or required to be in use)
Date: Wed, 9 Apr 2003 02:25:02 -0400
Message-ID: <000001c2fe60$c529c640$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C2FE3F.3E182640"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C2FE3F.3E182640
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dmesg:
=3D=3D=3D=3D=3D=3D

Linux version 2.5.66-bk9 (root@coredump) (gcc version 3.2.3 20030208
(prerelease)) #2 Wed Apr 9 00:20:06 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffd9c0 (usable)
 BIOS-e820: 0000000007ffd9c0 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32765
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28669 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff80
ACPI: FADT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff00
ACPI: DSDT (v001 IBM    CDTPWSNV 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3Dnewlinux ro root=3D301
rootflags=3Ddata=3Dwriteback pci=3Dnoacpi console=3DttyS2,9600n8
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 447.910 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 884.73 BogoMIPS
Memory: 125132k/131060k available (2748k kernel code, 5392k reserved, =
759k
data, 340k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 447.0999 MHz.
..... host bus clock speed is 99.0555 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd83c, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 242 entries (12 bytes)
biovec pool[1]:   4 bvecs: 242 entries (48 bytes)
biovec pool[2]:  16 bvecs: 242 entries (192 bytes)
biovec pool[3]:  64 bvecs: 242 entries (768 bytes)
biovec pool[4]: 128 bvecs: 121 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  60 entries (3072 bytes)
ACPI: Subsystem revision 20030328
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully =
acquired
Parsing all Control
Methods:.................................................................=
...
...........................
Table [DSDT] - 250 Objects with 29 Devices 95 Methods 7 Regions
ACPI Namespace successfully loaded at root c04d93bc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers =
at
000000000000FD0C on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 =
to
GPE 0x0F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0B as =
GPE
number 0x0B
Executing all Device _STA and_INI methods:.............................
29 Devices found containing: 29 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package
initialization:.........................
Initialized 2/7 Regions 1/6 Fields 13/15 Buffers 9/9 Packages (250 =
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, =
disabled)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, =
disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Found PnP BIOS installation structure at 0xc00fde50
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x587a, dseg 0xf0000
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0e' and the driver 'system'
pnp: match found with the PnP device '00:0f' and the driver 'system'
pnp: match found with the PnP device '00:10' and the driver 'system'
pnp: match found with the PnP device '00:15' and the driver 'system'
PnPBIOS: 21 nodes reported by PnP BIOS; 21 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Capability LSM initialized
There is already a security framework initialized, register_security =
failed.
Failure registering Root Plug module with the kernel
Failure registering Root Plug  module with primary security module.
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
pnp: Calling quirk for 01:02.00
pnp: SB audio device quirk - increasing port range
pnp: res: Unable to resolve resource conflicts for the device =
'01:02.00',
some devices may not be usable.
pnp: Calling quirk for 01:02.02
pnp: AWE32 quirk - adding two ports

isapnp: Card 'Crystal Audio' <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D IGNORE, =
this isn't usable with no
IRQs free (?)!!!!!!!!!!!!!!!!!!!!!!!!!!!!

isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
isapnp: 3 Plug & Play cards detected total
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error =3D -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin =
is 60
seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:12' and the driver 'serial'
pnp: match found with the PnP device '00:13' and the driver 'serial'
pnp: match found with the PnP device '01:03.00' and the driver 'serial'
pnp: res: the device '01:03.00' has been activated.
ttyS3 at I/O 0x2e8 (irq =3D 5) is a 16550A
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:14' and the driver 'parport_pc'
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:02.2
e100: selftest OK.
Freeing alive device c7ed4000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX4: IDE controller at PCI slot 00:02.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L040L2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRD-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: host protected area =3D> 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=3D77557/16/63, =
UDMA(33)
 hda: hda1 hda2
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
PCI: Found IRQ 9 for device 00:12.0
PCI: Sharing IRQ 9 with 01:01.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=3D7, 3/253 SCBs

  Vendor: HP        Model: T4000s            Rev: 1.10
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface =
driver
v2.0
PCI: Found IRQ 11 for device 00:02.2
PCI: Sharing IRQ 11 with 00:03.0
uhci-hcd 00:02.2: Intel Corp. 82371AB/EB/MB PIIX4=20
uhci-hcd 00:02.2: irq 11, io base 0000ff00
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is =
deprecated.
uhci-hcd 00:02.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 00:02.2: root hub device address 1
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4=20
usb usb1: Manufacturer: Linux 2.5.66-bk9 uhci-hcd
drivers/usb/host/uhci-hcd.c: ff00: suspend_hc
usb usb1: SerialNumber: 00:02.2
usb usb1: usb_new_device - registering interface 1-0:0
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
sb: Init: Starting Probe...
pnp: the driver 'OSS SndBlstr' has been registered
pnp: match found with the PnP device '01:02.00' and the driver 'OSS
SndBlstr'
drivers/pnp/manager.c:379: spin_lock(drivers/pnp/core.c:c04282f0) =
already
locked by drivers/pnp/manager.c/440
pnp: res: Unable to resolve resource conflicts for the device =
'01:01.00',
some devices may not be usable.
pnp: res: the device '01:02.00' has been activated.
sb: PnP: Found Card Named =3D "Audio", Card PnP id =3D CTL0048, Device =
PnP id =3D
CTL0031
sb: PnP:      Detected at: io=3D0x220, irq=3D5, dma=3D1, dma16=3D5
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
sb: Turning on MPU
<Sound Blaster 16> at 0x330 irq 5
sb: Init: Done
error in initcall at 0xc0491480: returned with preemption imbalance
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 128 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 2340)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 340k freed
Adding 72284k swap on /dev/hda2.  Priority:1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
e100: eth0 NIC Link is Up 100 Mbps Full duplex

Rest is attached (interrupts and lspci -vv info and dsdt.dat from
/proc/acpi/dsdt).

Shawn.

-----Original Message-----
From: "Yu, Luming"=20
Date: Tue, 8 Apr 2003 16:10:31=20
Subject: RE: 2.5.xx ACPI/Sb16 IRQ conflict

Did you try disabling Pnp BIOS and enabling ACPI in kernel?
If yes, please do cat  /proc/acpi/dsdt  > dsdt.dat and send it to me.=20
And I need the outputs of  "lspci -vv" and "cat /proc/interrupts".
(Dmesg of problematic kernel is also needed)

Thanks,
Luming


Regarding old email:

On Tue, Feb 18, 2003 at 09:42:10AM -0800, Grover, Andrew wrote:
> > From: Shawn Starr [mailto:shawn.starr@datawire.net]=20
> > I can confirm this with 2.5.61 and my SB16AWE card. There
> > seems to be a bug
> > when PCI interrupts are set by ACPI on a IBM 300PL 6892-N2U.
> >
> > Also, the IBM BIOS's PnP for OS is enabled.
> >
> > When the PnP BIOS is disabled and pci=3Dnoacpi is NOT used.
> > There are no
> > conflicts. When PnP BIOS is enabled and we don't set
> > pci=3Dnoacpi we get
> > conflicts with IRQs.
>
> Hmmm, yes.
>
> > >ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
>
> There should have been a previous line about LNKD, listing possible
> interrupts for it -- what did that line say?

On my copy of Shawn's dmesg I see the following:

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, =
disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 5


>=20
> Clearly, either we need another IRQ for LNKD or we PnPISA needs to
> assign a different IRQ - some coordination is needed here.

Agreed, in this particular case there are no available irqs for PnPISA =
to
assign because it isn't able to share irqs.  Here is some aditional
information about the ISAPnP device that is using irq 5.

7 is used by the parport
10 and 11 are used by pci devices
5 is clear but only with pci=3Dnoacpi

ISAPnP Based Sound Blaster Card

sh-2.05a$ cat possible
Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible
Dependent: 02 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 03 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 04 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 05 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 06 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 07 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10,11 High-Edge
   dma 0,1,3 8-bit byte-count compatible

How would you suggest PnP and PCI coordinate this?

Thanks,

Adam




------=_NextPart_000_0001_01C2FE3F.3E182640
Content-Type: application/octet-stream;
	name="lspci"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge =
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge =
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	Memory behind bridge: f4000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:02.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) =
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fff0 [size=3D16]

00:02.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) =
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 48
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff00 [size=3D32]

00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 05)
	Subsystem: IBM: Unknown device 00d7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f3dff000 (32-bit, prefetchable) [size=3D4K]
	Region 1: I/O ports at 7c60 [size=3D32]
	Region 2: Memory at f3f00000 (32-bit, non-prefetchable) [size=3D1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:12.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 7800 [disabled] [size=3D256]
	Region 1: Memory at f3eff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:01.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01) (prog-if =
00 [VGA])
	Subsystem: IBM Integrated Trio3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=3D64M]
	Expansion ROM at 000c0000 [disabled] [size=3D64K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


------=_NextPart_000_0001_01C2FE3F.3E182640
Content-Type: application/octet-stream;
	name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="interrupts"

           CPU0       
  0:     302775          XT-PIC  timer
  1:         12          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         10          XT-PIC  serial
  4:       3730          XT-PIC  serial
  5:        241          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:         20          XT-PIC  acpi, aic7xxx
 11:        494          XT-PIC  uhci-hcd, eth0
 12:         86          XT-PIC  i8042
 14:       1050          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0 
LOC:     301744 
ERR:          0
MIS:          0

------=_NextPart_000_0001_01C2FE3F.3E182640
Content-Type: application/octet-stream;
	name="dsdt.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dsdt.dat"

RFNEVMwkAAABiklCTSAgIENEVFBXU05WABAAAE1TRlQHAAABW4BDSEtQAQqACgFbgQtDSEtQAUlP
UFQIEBNcX1BSX1uDC0NQVTAAEP0AAAYUNlxfUFRTAaAYk2gKAXAKoUlPUFRwAElPUFRwAElPUFSh
FXAKqElPUFSgDJNoCgVwCvdBUE1DFBpcX1dBSwFwCqJJT1BUcAFJT1BUcAFJT1BUW4BBUE1SAQqy
CgJbgRBBUE1SAUFQTUMIQVBNUwhbgFBNQkEBCwD9CjhbgUkFUE1CQQMAQAYAEFRIUk0BAAdVU0JF
AUdQSUUBUklFTgFMSURFAQAEAEAMR0xCQyAAQAQAGUdPMjUBR08yNgFHTzI3AUdPMjgBR08yOQFH
TzMwAUdPMzEBCFxfUzBfEgoECgUKAAoACgAIXF9TMV8SCgQKBAoACgAKAAhcX1M0XxIKBAoACgAK
AAoACFxfUzVfEgoECgAKAAoACgAQSGpcX1NCX1uCT2lQQ0kwCF9ISUQMQdAKAwhfQURSCgBbgEhC
QlgCCgALAAFbgRNIQkJYAwBIM0RSQjcIRkRIQwgUCV9TVEEApAoPCF9DUlMRTAgKiIgNAAIMAAAA
AAD/AAAAAAFHAfgM+AwBCIgNAAEMAwAAAAD3DAAA+AyIDQABDAMAAAAN//8AAADzhxcAAAwDAAAA
AAAACgD//wsAAAAAAAAAAgCHFwAADAMAAAAAAIAMAP//DQAAAAAAAIABAIcXAAAMAwAAAAAAAAAC
///f/wAAAAAAAOD9eQCKX0NSUwp2TU1JTopfQ1JTCnpNTUFYil9DUlMKgk1MRU4UJl9JTkkAcERS
QjdgeWAKF01NSU50TU1BWE1NSU5NTEVOdU1MRU4QQEtcLl9TQl9QQ0kwW4JHElBJTjEIX0hJRAxB
0AwPCF9VSUQKARQnX1NUQQCgG3tcLwRfU0JfUENJMElTQV9QSVJBCoAApAoJoQSkCgsUNl9ESVMA
cArpSU9QVH1cLwRfU0JfUENJMElTQV9QSVJBCoBcLwRfU0JfUENJMElTQV9QSVJBFEMFX0NSUwBw
CupJT1BUCExOQV8RCQoGIwAAGHkAi0xOQV8KAUlSQTF7XC8EX1NCX1BDSTBJU0FfUElSQQqPYKAO
lWAKgHB5AWAASVJBMaRMTkFfCF9QUlMRCQoGI/jeGHkAFE0EX1NSUwFwCuxJT1BUi2gKAUlSQTKC
SVJBMmB7XC8EX1NCX1BDSTBJU0FfUElSQQpwYX1hdmBhcGFcLwRfU0JfUENJMElTQV9QSVJBW4JH
ElBJTjIIX0hJRAxB0AwPCF9VSUQKAhQnX1NUQQCgG3tcLwRfU0JfUENJMElTQV9QSVJCCoAApAoJ
oQSkCgsUNl9ESVMAcArtSU9QVH1cLwRfU0JfUENJMElTQV9QSVJCCoBcLwRfU0JfUENJMElTQV9Q
SVJCFEMFX0NSUwBwCu5JT1BUCExOQl8RCQoGIwAAGHkAi0xOQl8KAUlSQjF7XC8EX1NCX1BDSTBJ
U0FfUElSQgqPYKAOlWAKgHB5AWAASVJCMaRMTkJfCF9QUlMRCQoGI/jeGHkAFE0EX1NSUwFwCvBJ
T1BUi2gKAUlSQjKCSVJCMmB7XC8EX1NCX1BDSTBJU0FfUElSQgpwYX1hdmBhcGFcLwRfU0JfUENJ
MElTQV9QSVJCW4JHElBJTjMIX0hJRAxB0AwPCF9VSUQKAxQnX1NUQQCgG3tcLwRfU0JfUENJMElT
QV9QSVJDCoAApAoJoQSkCgsUNl9ESVMAcArxSU9QVH1cLwRfU0JfUENJMElTQV9QSVJDCoBcLwRf
U0JfUENJMElTQV9QSVJDFEMFX0NSUwBwCvJJT1BUCExOQ18RCQoGIwAAGHkAi0xOQ18KAUlSQzF7
XC8EX1NCX1BDSTBJU0FfUElSQwqPYKAOlWAKgHB5AWAASVJDMaRMTkNfCF9QUlMRCQoGI/jeGHkA
FE0EX1NSUwFwCvRJT1BUi2gKAUlSQzKCSVJDMmB7XC8EX1NCX1BDSTBJU0FfUElSQwpwYX1hdmBh
cGFcLwRfU0JfUENJMElTQV9QSVJDW4JHElBJTjQIX0hJRAxB0AwPCF9VSUQKBBQnX1NUQQCgG3tc
LwRfU0JfUENJMElTQV9QSVJECoAApAoJoQSkCgsUNl9ESVMAcAr1SU9QVH1cLwRfU0JfUENJMElT
QV9QSVJECoBcLwRfU0JfUENJMElTQV9QSVJEFEMFX0NSUwBwCvZJT1BUCExORF8RCQoGIwAAGHkA
i0xORF8KAUlSRDF7XC8EX1NCX1BDSTBJU0FfUElSRAqPYKAOlWAKgHB5AWAASVJEMaRMTkRfCF9Q
UlMRCQoGI/jeGHkAFE0EX1NSUwFwCvhJT1BUi2gKAUlSRDKCSVJEMmB7XC8EX1NCX1BDSTBJU0Ff
UElSRApwYX1hdmBhcGFcLwRfU0JfUENJMElTQV9QSVJECF9QUlcSBgIKCQoFFA1fUFNXAXAKpklP
UFRbgjZJU0FfCF9BRFIMAAACAFuAUElSUQIKYAoEW4EaUElSUQNQSVJBCFBJUkIIUElSQwhQSVJE
CFuCTgdVU0IwCF9BRFIMAgACAFuAQ0ZHMgIKAAoiW4EVQ0ZHMgMAIFBDSUMQAEANVVNCQhAUMV9T
VEEAcAqjSU9QVKALkFBDSUMKAaQKD6EXe1VTQkIL4P9hoAeTYQCkCgGhBKQKDwhfUFJXEgYCCggK
ARQNX1BTVwFwCqRJT1BUECNcX0dQRRQcX0wwQgCGXC8EX1NCX1BDSTBJU0FfQ09NMQoCEIGFAVwv
A19TQl9QQ0kwSVNBX1uAU01DMQELcAMKAluBEFNNQzEBSU5EWAhEQVRBCFuGRwVJTkRYREFUQQEA
OExETl8IAEANUFdSQwgASAZBQ1RSCABIF0lPQUgISU9BTAgAQAdJTlRSCAAISU5UMQgACERNQ0gI
AEg9T1BUMQhPUFQyCE9QVDMIW4JOLkZEQzAIX0hJRAxB0AcAFE8EX1NUQQBwCrpJT1BUcApVSU5E
WHAKAExETl+gD0FDVFJwCqpJTkRYpAoPoSKgFJFJT0FISU9BTHAKqklORFikCg2hC3AKqklORFik
CgAUKV9ESVMAcAq7SU9QVHAKVUlORFhwCgBMRE5fcAoAQUNUUnAKqklORFgUQxJfQ1JTAHAKvElP
UFQIQlVGMBEbChhHAfID8gMBBEcB9wP3AwEBIkAAKgQAeQCMQlVGMAoCSU9MT4xCVUYwCgNJT0hJ
jEJVRjAKBElPUkyMQlVGMAoFSU9SSIxCVUYwCgpJMkxPjEJVRjAKC0kySEmMQlVGMAoMSTJSTIxC
VUYwCg1JMlJIjEJVRjAKEUlSUUyMQlVGMAoURE1BVnAKVUlORFhwCgBMRE5ffUlPQUwKAklPTE99
SU9BTAoCSU9STH1JT0FMCgdJMkxPfUlPQUwKB0kyUkxwSU9BSElPSElwSU9BSElPUkhwSU9BSEky
SElwSU9BSEkyUkhwCgFgeWBJTlRSSVJRTHAKAWB5YERNQ0hETUFWcAqqSU5EWKRCVUYwFDNfUFJT
AHAKvUlPUFQIQlVGMBEbChhHAfID8gMBBEcB9wP3AwEBIkAAKgQAeQCkQlVGMBRNB19TUlMBcAq+
SU9QVIxoCgJJT0xPjGgKA0lPSEmMaAoRSVJRTIxoChRETUFWcApVSU5EWHAKAExETl97SU9MTwr4
YHBgSU9BTHBJT0hJSU9BSIJJUlFMYHZgcGBJTlRSgkRNQVZgdmBwYERNQ0hwCgFBQ1RScAqqSU5E
WBQzX1BTQwBwChFJT1BUcApVSU5EWKASkFBXUkMKAXAKqklORFikCgChC3AKqklORFikCgMULF9Q
UzAAcAoSSU9QVHAKVUlORFhwUFdSQ2B9YAoBYHBgUFdSQ3AKqklORFgULF9QUzMAcAoTSU9QVHAK
VUlORFhwUFdSQ2B7YAr+YHBgUFdSQ3AKqklORFhbgkAtTFBUXwhfSElEDEHQBAAIX1VJRAoBFEkG
X1NUQQBwCr9JT1BUcApVSU5EWHAKA0xETl97T1BUMQoHYKA4k2AKBKAPQUNUUnAKqklORFikCg+h
IqAUkUlPQUhJT0FMcAqqSU5EWKQKDaELcAqqSU5EWKQKAKELcAqqSU5EWKQKABQpX0RJUwBwCsBJ
T1BUcApVSU5EWHAKA0xETl9wCgBBQ1RScAqqSU5EWBRCDF9DUlMAcArBSU9QVAhCVUYwERAKDUcB
eAN4AwEIIoAAeQCMQlVGMAoCSU9MT4xCVUYwCgNJT0hJjEJVRjAKBElPUkyMQlVGMAoFSU9SSIxC
VUYwCgdMRU5UjEJVRjAKCUlSUUxwClVJTkRYcAoDTEROX3BJT0FMSU9MT3BJT0FMSU9STHBJT0FI
SU9ISXBJT0FISU9SSKAPk0lPTE8KvHAKA0xFTlRwCgFgeWBJTlRSSVJRTHAKqklORFikQlVGMBRD
BF9QUlMAcArCSU9QVAhCVUYwESoKJzBHAXgDeAMBCCKgADBHAXgCeAIBCCKgADBHAbwDvAMBAyKg
ADh5AKRCVUYwFE8IX1NSUwFwCsNJT1BUjGgKAklPTE+MaAoDSU9ISYxoCgRJT1JMjGgKBUlPUkiM
aAoJSVJRTHAKVUlORFhwCgNMRE5fcElPTE9JT0FMcElPSElJT0FIgklSUUxgoAiSk2AKAHZgcGBJ
TlRScABETUNIe09QVDEK+GB9YAoET1BUMXAKAUFDVFJwCqpJTkRYFDNfUFNDAHAKFElPUFRwClVJ
TkRYoBKQUFdSQwoIcAqqSU5EWKQKAKELcAqqSU5EWKQKAxQsX1BTMABwChVJT1BUcApVSU5EWHBQ
V1JDYH1gCghgcGBQV1JDcAqqSU5EWBQsX1BTMwBwChZJT1BUcApVSU5EWHBQV1JDYHtgCvdgcGBQ
V1JDcAqqSU5EWFuCSyxTUFBfCF9ISUQMQdAEAAhfVUlECgIUSQZfU1RBAHAKxElPUFRwClVJTkRY
cAoDTEROX3tPUFQxCgdgoDiTYAoAoA9BQ1RScAqqSU5EWKQKD6EioBSRSU9BSElPQUxwCqpJTkRY
pAoNoQtwCqpJTkRYpAoAoQtwCqpJTkRYpAoAFClfRElTAHAKxUlPUFRwClVJTkRYcAoDTEROX3AK
AEFDVFJwCqpJTkRYFEIMX0NSUwBwCsZJT1BUCEJVRjAREAoNRwF4A3gDAQgigAB5AIxCVUYwCgJJ
T0xPjEJVRjAKA0lPSEmMQlVGMAoESU9STIxCVUYwCgVJT1JIjEJVRjAKB0xFTlSMQlVGMAoJSVJR
THAKVUlORFhwCgNMRE5fcElPQUxJT0xPcElPQUxJT1JMcElPQUhJT0hJcElPQUhJT1JIoA+TSU9M
Twq8cAoDTEVOVHAKAWB5YElOVFJJUlFMcAqqSU5EWKRCVUYwFEMEX1BSUwBwCsdJT1BUCEJVRjAR
KgonMEcBeAN4AwEIIqAAMEcBeAJ4AgEIIqAAMEcBvAO8AwEDIqAAOHkApEJVRjAUSghfU1JTAXAK
yElPUFSMaAoCSU9MT4xoCgNJT0hJjGgKBElPUkyMaAoFSU9SSIxoCglJUlFMcApVSU5EWHAKA0xE
Tl9wSU9MT0lPQUxwSU9ISUlPQUiCSVJRTGCgCJKTYAoAdmBwYElOVFJwAERNQ0h7T1BUMQr4T1BU
MXAKAUFDVFJwCqpJTkRYFDNfUFNDAHAKFElPUFRwClVJTkRYoBKQUFdSQwoIcAqqSU5EWKQKAKEL
cAqqSU5EWKQKAxQsX1BTMABwChVJT1BUcApVSU5EWHBQV1JDYH1gCghgcGBQV1JDcAqqSU5EWBQs
X1BTMwBwChZJT1BUcApVSU5EWHBQV1JDYHtgCvdgcGBQV1JDcAqqSU5EWFuCSClFUFBfCF9ISUQM
QdAEAAhfVUlECgMUSQZfU1RBAHAKyUlPUFRwClVJTkRYcAoDTEROX3tPUFQxCgdgoDiTYAoFoA9B
Q1RScAqqSU5EWKQKD6EioBSRSU9BSElPQUxwCqpJTkRYpAoNoQtwCqpJTkRYpAoAoQtwCqpJTkRY
pAoAFClfRElTAHAKyklPUFRwClVJTkRYcAoDTEROX3AKAEFDVFJwCqpJTkRYFEcKX0NSUwBwCstJ
T1BUCEJVRjAREAoNRwF4A3gDAQgigAB5AIxCVUYwCgJJT0xPjEJVRjAKA0lPSEmMQlVGMAoESU9S
TIxCVUYwCgVJT1JIjEJVRjAKCUlSUUxwClVJTkRYcAoDTEROX3BJT0FMSU9MT3BJT0FMSU9STHBJ
T0FISU9ISXBJT0FISU9SSHAKAWB5YElOVFJJUlFMcAqqSU5EWKRCVUYwFDZfUFJTAHAKzElPUFQI
QlVGMBEeChswRwF4A3gDAQgioAAwRwF4AngCAQgioAA4eQCkQlVGMBRPB19TUlMBcArNSU9QVIxo
CgJJT0xPjGgKA0lPSEmMaAoJSVJRTHAKVUlORFhwCgNMRE5fcElPTE9JT0FMcElPSElJT0FIgklS
UUxgoAiSk2AKAHZgcGBJTlRScABETUNIe09QVDEK+GB9YAoFT1BUMXAKAUFDVFJwCqpJTkRYFDNf
UFNDAHAKFElPUFRwClVJTkRYoBKQUFdSQwoIcAqqSU5EWKQKAKELcAqqSU5EWKQKAxQsX1BTMABw
ChVJT1BUcApVSU5EWHBQV1JDYH1gCghgcGBQV1JDcAqqSU5EWBQsX1BTMwBwChZJT1BUcApVSU5E
WHBQV1JDYHtgCvdgcGBQV1JDcAqqSU5EWFuCTTdFQ1BfCF9ISUQMQdAEAQhfVUlECgQUSQZfU1RB
AHAKzklPUFRwClVJTkRYcAoDTEROX3tPUFQxCgdgoDiTYAoCoA9BQ1RScAqqSU5EWKQKD6EioBSR
SU9BSElPQUxwCqpJTkRYpAoNoQtwCqpJTkRYpAoAoQtwCqpJTkRYpAoAFClfRElTAHAKz0lPUFRw
ClVJTkRYcAoDTEROX3AKAEFDVFJwCqpJTkRYFE0UX0NSUwBwCtBJT1BUCEJVRjARGwoYRwF4A3gD
AQhHAXgHeAcBCCKAACoIAHkAjEJVRjAKAklPTE+MQlVGMAoDSU9ISYxCVUYwCgRJT1JMjEJVRjAK
BUlPUkiMQlVGMAoHTEVOMYxCVUYwCgpJT0wyjEJVRjAKC0lPSDKMQlVGMAoMSU8yTIxCVUYwCg1J
TzJIjEJVRjAKD0xFTjKMQlVGMAoRSVJRTIxCVUYwChRETUFWcApVSU5EWHAKA0xETl9wSU9BTElP
TE9wSU9BTElPUkxwSU9BSElPSElwSU9BSElPUkhwSU9BTElPTDJwSU9BTElPMkxwSU9BSGByYAoE
YXBhSU9IMnBhSU8ySKAWk0lPTE8KvHAKA0xFTjFwCgNMRU4ycAoBYHlgSU5UUklSUUxwCgFgeWBE
TUNIRE1BVnAKqklORFikQlVGMBRFBl9QUlMAcArRSU9QVAhCVUYwEUwECkgwRwF4A3gDAQhHAXgH
eAcBCCKgACoKADBHAXgCeAIBCEcBeAZ4BgEIIqAAKgoAMEcBvAO8AwEDRwG8B7wHAQMioAAqCgA4
eQCkQlVGMBRPCF9TUlMBcArSSU9QVIxoCgJJT0xPjGgKA0lPSEmMaAoRSVJRTIxoChRETUFWcApV
SU5EWHAKA0xETl9wSU9MT0lPQUxwSU9ISUlPQUiCSVJRTGCgCJKTYAoAdmBwYElOVFKCRE1BVmB2
YHBgRE1DSHtPUFQxCvhgfWAKAk9QVDFwCgFBQ1RScAqqSU5EWBQzX1BTQwBwChRJT1BUcApVSU5E
WKASkFBXUkMKCHAKqklORFikCgChC3AKqklORFikCgMULF9QUzAAcAoVSU9QVHAKVUlORFhwUFdS
Q2B9YAoIYHBgUFdSQ3AKqklORFgULF9QUzMAcAoWSU9QVHAKVUlORFhwUFdSQ2B7YAr3YHBgUFdS
Q3AKqklORFhbgkgzRVBDUAhfSElEDEHQBAEIX1VJRAoFFEkGX1NUQQBwCtNJT1BUcApVSU5EWHAK
A0xETl97T1BUMQoHYKA4k2AKB6APQUNUUnAKqklORFikCg+hIqAUkUlPQUhJT0FMcAqqSU5EWKQK
DaELcAqqSU5EWKQKAKELcAqqSU5EWKQKABQpX0RJUwBwCtRJT1BUcApVSU5EWHAKA0xETl9wCgBB
Q1RScAqqSU5EWBRAEl9DUlMAcArVSU9QVAhCVUYwERsKGEcBeAN4AwEIRwF4B3gHAQgigAAqCAB5
AIxCVUYwCgJJT0xPjEJVRjAKA0lPSEmMQlVGMAoESU9STIxCVUYwCgVJT1JIjEJVRjAKCklPTDKM
QlVGMAoLSU9IMoxCVUYwCgxJTzJMjEJVRjAKDUlPMkiMQlVGMAoRSVJRTIxCVUYwChRETUFWcApV
SU5EWHAKA0xETl9wSU9BTElPTE9wSU9BTElPUkxwSU9BSElPSElwSU9BSElPUkhwSU9BTElPTDJw
SU9BTElPMkxwSU9BSGByYAoEYXBhSU9IMnBhSU8ySHAKAWB5YElOVFJJUlFMcAoBYHlgRE1DSERN
QVZwCqpJTkRYpEJVRjAUTQRfUFJTAHAK1klPUFQIQlVGMBE0CjEwRwF4A3gDAQhHAXgHeAcBCCKg
ACoKADBHAXgCeAIBCEcBeAZ4BgEIIqAAKgoAOHkApEJVRjAUTwhfU1JTAXAK10lPUFSMaAoCSU9M
T4xoCgNJT0hJjGgKEUlSUUyMaAoURE1BVnAKVUlORFhwCgNMRE5fcElPTE9JT0FMcElPSElJT0FI
gklSUUxgoAiSk2AKAHZgcGBJTlRSgkRNQVZgdmBwYERNQ0h7T1BUMQr4YH1gCgdPUFQxcAoBQUNU
UnAKqklORFgUM19QU0MAcAoUSU9QVHAKVUlORFigEpBQV1JDCghwCqpJTkRYpAoAoQtwCqpJTkRY
pAoDFCxfUFMwAHAKFUlPUFRwClVJTkRYcFBXUkNgfWAKCGBwYFBXUkNwCqpJTkRYFCxfUFMzAHAK
FklPUFRwClVJTkRYcFBXUkNge2AK92BwYFBXUkNwCqpJTkRYW4JAB1BTMksIX0hJRAxB0AMDFE8F
X0NSUwBwCrJJT1BUCEJVRjARGAoVRwFgAGAAAQFHAWQAZAABASICAHkAi0JVRjAKEUlSUUxwClVJ
TkRYcAoHTEROX3AKAWB5YElOVFJJUlFMcAqqSU5EWKRCVUYwW4JABlBTMk0IX0hJRAxB0A8TFE8E
X0NSUwBwCrdJT1BUCEJVRjARCAoFIgAQeQCLQlVGMAoBSVJRTHAKVUlORFhwCgdMRE5fcAoBYHlg
SU5UMUlSUUxwCqpJTkRYpEJVRjBbgkQpQ09NMQhfSElEDEHQBQEIX1VJRAoBFE8EX1NUQQBwCthJ
T1BUcApVSU5EWHAKBExETl+gD0FDVFJwCqpJTkRYpAoPoSKgFJFJT0FISU9BTHAKqklORFikCg2h
C3AKqklORFikCgAUKV9ESVMAcArZSU9QVHAKVUlORFhwCgRMRE5fcAoAQUNUUnAKqklORFgURwpf
Q1JTAHAK/0lPUFQIQlVGMBEQCg1HAfID8gMBCCIAAHkAjEJVRjAKAklPTE+MQlVGMAoDSU9ISYxC
VUYwCgRJT1JMjEJVRjAKBUlPUkiLQlVGMAoJSVJRTHAKVUlORFhwCgRMRE5fcElPQUxJT0xPcElP
QUxJT1JMcElPQUhJT0hJcElPQUhJT1JIcAoBYHlgSU5UUklSUUxwCqpJTkRYpEJVRjAUTwRfUFJT
AHAK20lPUFQIQlVGMBE2CjMwRwH4A/gDAQgiGM4wRwH4AvgCAQgiGM4wRwHoA+gDAQgiGM4wRwHo
AugCAQgiGM44eQCkQlVGMBRCBl9TUlMBcArcSU9QVIxoCgJJT0xPjGgKA0lPSEmLaAoJSVJRTHAK
VUlORFhwCgRMRE5fcElPTE9JT0FMcElPSElJT0FIgklSUUxgdmBwYElOVFJwCgFBQ1RScAqqSU5E
WAhfUFJXEgYCCgsKBRQNX1BTVwFwCt1JT1BUFDNfUFNDAHAKF0lPUFRwClVJTkRYoBKQUFdSQwoQ
cAqqSU5EWKQKAKELcAqqSU5EWKQKAxQsX1BTMABwChhJT1BUcApVSU5EWHBQV1JDYH1gChBgcGBQ
V1JDcAqqSU5EWBQsX1BTMwBwChlJT1BUcApVSU5EWHBQV1JDYHtgCu9gcGBQV1JDcAqqSU5EWFuC
SidDT00yCF9ISUQMQdAFAQhfVUlECgIUTwRfU1RBAHAK3klPUFRwClVJTkRYcAoFTEROX6APQUNU
UnAKqklORFikCg+hIqAUkUlPQUhJT0FMcAqqSU5EWKQKDaELcAqqSU5EWKQKABQpX0RJUwBwCt9J
T1BUcApVSU5EWHAKBUxETl9wCgBBQ1RScAqqSU5EWBRHCl9DUlMAcArgSU9QVAhCVUYwERAKDUcB
8gPyAwEIIgAAeQCMQlVGMAoCSU9MT4xCVUYwCgNJT0hJjEJVRjAKBElPUkyMQlVGMAoFSU9SSItC
VUYwCglJUlFMcApVSU5EWHAKBUxETl9wSU9BTElPTE9wSU9BTElPUkxwSU9BSElPSElwSU9BSElP
UkhwCgFgeWBJTlRSSVJRTHAKqklORFikQlVGMBRPBF9QUlMAcArhSU9QVAhCVUYwETYKMzBHAfgD
+AMBCCIYzjBHAfgC+AIBCCIYzjBHAegD6AMBCCIYzjBHAegC6AIBCCIYzjh5AKRCVUYwFEIGX1NS
UwFwCuJJT1BUjGgKAklPTE+MaAoDSU9ISYtoCglJUlFMcApVSU5EWHAKBUxETl9wSU9MT0lPQUxw
SU9ISUlPQUiCSVJRTGB2YHBgSU5UUnAKAUFDVFJwCqpJTkRYFDNfUFNDAHAKGklPUFRwClVJTkRY
oBKQUFdSQwogcAqqSU5EWKQKAKELcAqqSU5EWKQKAxQsX1BTMABwChtJT1BUcApVSU5EWHBQV1JD
YH1gCiBgcGBQV1JDcAqqSU5EWBQsX1BTMwBwChxJT1BUcApVSU5EWHBQV1JDYHtgCt9gcGBQV1JD
cAqqSU5EWBBCFVwvA19TQl9QQ0kwSVNBX1uCK1BJQ18IX0hJRAtB0AhfQ1JTERgKFUcBIAAgAAEC
RwGgAKAAAQIiBAB5AFuCNURNQTAIX0hJRAxB0AIACF9DUlMRIAodRwEAAAAAASBHAYAAgAABEEcB
wADAAAEgKhAEeQBbgiVUTVJfCF9ISUQMQdABAAhfQ1JTERAKDUcBQABAAAEEIgEAeQBbgiVSVENf
CF9ISUQMQdALAAhfQ1JTERAKDUcBcABwAAEEIgABeQBbgiJTUEtSCF9ISUQMQdAIAAhfQ1JTEQ0K
CkcBYQBhAAEBeQBbgiVDT1BSCF9ISUQMQdAMBAhfQ1JTERAKDUcB8ADwAAEQIgAgeQBbgkIEU0JE
MQhfSElEDEHQDAIIX1VJRAoBCF9DUlMRJQoiRwHQBNAEAQJHAQD9AP0BQEcBAP4A/gEQRwFwA3AD
AQJ5ABBAGlxfU0JfW4JDDFJBTV8IX0hJRAxB0AwBCF9VSUQKARQJX1NUQQCkCgsIX0NSUxEpCiaG
CQABAAAAAAAACgCGCQABAAAQAAAA8ACGCQABAAAAAQAAAAF5AIpfQ1JTChRNTE4xil9DUlMKHE1C
UzKKX0NSUwogTUxOMhRBBV9JTkkAcFwvA19TQl9QQ0kwRkRIQ2B6YAoGYKATk2AKAnRNTE4xDAAA
EABNTE4xcFwvA19TQl9QQ0kwRFJCN2B5YAoXYHRgTUJTMk1MTjJbgkkJUk9NXwhfSElEDEHQDAEI
X1VJRAoCFAlfU1RBAKQKCwhfQ1JTEUIHCm6GCQAAAAAOAAAQAACGCQAAABAOAAAQAACGCQAAACAO
AAAQAACGCQAAADAOAAAQAACGCQAAAEAOAAAQAACGCQAAAFAOAAAQAACGCQAAAGAOAAAQAACGCQAA
AHAOAAAQAACGCQAAAIAOAACAAQB5AFuCN1JPTTIIX0hJRAxB0AwBCF9VSUQKAxQJX1NUQQCkCgsI
X0NSUxERCg6GCQAAAAD8/wAABAB5ABBFElwuX1NCX1BDSTAIX1BSVBJDERESDwQM//8BAAoAUElO
MQoAEg8EDP//AQAKAVBJTjIKABIPBAz//wIACgBQSU4xCgASDwQM//8CAAoDUElONAoAEg8EDP//
AwAKAFBJTjQKABIPBAz//xAACgBQSU4zCgASDwQM//8QAAoBUElONAoAEg8EDP//EAAKAlBJTjEK
ABIPBAz//xAACgNQSU4yCgASDwQM//8SAAoAUElOMgoAEg8EDP//EgAKAVBJTjMKABIPBAz//xIA
CgJQSU40CgASDwQM//8SAAoDUElOMQoAEg8EDP//FAAKAFBJTjEKABIPBAz//xQACgFQSU4yCgAS
DwQM//8UAAoCUElOMwoAEg8EDP//FAAKA1BJTjQKABAoXC5fU0JfUENJMFuCG0xBTjAIX0FEUgwA
AAMACF9QUlcSBgIKCgoF

------=_NextPart_000_0001_01C2FE3F.3E182640--

