Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJNSRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJNSRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:17:49 -0400
Received: from 133.32.3.213.dial.bluewin.ch ([213.3.32.133]:60201 "EHLO p3000")
	by vger.kernel.org with ESMTP id S262714AbTJNSQ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:16:28 -0400
Subject: Re: linux 2.6.0-test7 broadcom driver b44
From: Marc Kalberer <Marc.Kalberer@programmers.ch>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031014172617.GA27889@ee.oulu.fi>
References: <3F710B1D00077369@mssbzhh-int.msg.bluewin.ch>
	 <20031014172617.GA27889@ee.oulu.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1066154876.2239.4.camel@p3000>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 20:07:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is the full logs from dmesg & proc/interrupts

I'll try your patch right now and keep you informed , 
Thanks anyway,
Marc

-----------------------------------------------------------
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fee0000 (usable)
 BIOS-e820: 000000002fee0000 - 000000002feeb000 (ACPI data)
 BIOS-e820: 000000002feeb000 - 000000002ff00000 (ACPI NVS)
 BIOS-e820: 000000002ff00000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
766MB LOWMEM available.
found SMP MP-table at 000f7bd0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 196320
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192224 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Dell Inspiron with broken BIOS detected. Refusing to enable the local
APIC.
ACPI: RSDP (v000 DELL                                      ) @
0x000f7b80
ACPI: RSDT (v001 DELL   MwoodNwd 0x06040000  LTP 0x00000000) @
0x2fee5e39
ACPI: FADT (v001 INTEL  MONTARA  0x06040000 PTL  0x00000050) @
0x2feeae6a
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x2feeafd8
ACPI: MADT (v001 INTEL  MONTARA  0x06040000 PTL  0x00000050) @
0x2feeaf7e
ACPI: SSDT (v001 INTEL  CPU0CST  0x00000001 INTL 0x20020725) @
0x2fee6282
ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20020725) @
0x2fee5e71
ACPI: DSDT (v001 INTEL  MONTARAG 0x06040000 MSFT 0x0100000e) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6.0-test7-30 ro root=1606 devfs=mount
hda=ide-scsi
ide_setup: hda=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1595.148 MHz processor.
Console: colour VGA+ 80x25
Memory: 771424k/785280k available (3316k kernel code, 13116k reserved,
1358k data, 300k init, 0k highmem)
Calibrating delay loop... 3145.72 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Genuine Intel(R) CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
BIOS bug, local APIC #0 not detected!...
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9a4, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030918
IOAPIC[0]: Invalid reference to IRQ 0
    ACPI-1120: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.BAT1._STA] (Node efdd7e00), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.BAT1._STA] (Node efdd7e00), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15)
ACPI: Power Resource [PFN0] (on)
ACPI: Power Resource [PFN1] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7c10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbb6e, dseg 0x400
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (1-16 -> 0x39 -> IRQ 16 Mode:1
Active:1)
00:00:02[A] -> 1-16 -> IRQ 16
Pin 1-16 already programmed
IOAPIC[0]: Set PCI routing entry (1-19 -> 0x41 -> IRQ 19 Mode:1
Active:1)
00:00:1d[B] -> 1-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (1-18 -> 0x49 -> IRQ 18 Mode:1
Active:1)
00:00:1d[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-23 -> 0x51 -> IRQ 23 Mode:1
Active:1)
00:00:1d[D] -> 1-23 -> IRQ 23
Pin 1-18 already programmed
IOAPIC[0]: Set PCI routing entry (1-17 -> 0x59 -> IRQ 17 Mode:1
Active:1)
00:00:1f[B] -> 1-17 -> IRQ 17
Pin 1-17 already programmed
Pin 1-17 already programmed
IOAPIC[0]: Set PCI routing entry (1-20 -> 0x61 -> IRQ 20 Mode:1
Active:1)
00:01:00[A] -> 1-20 -> IRQ 20
Pin 1-17 already programmed
Pin 1-18 already programmed
Pin 1-19 already programmed
Pin 1-16 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Arlan driver C.Jennigs 97 & Elmer.Joandi@ut.ee  Oct'98,
http://www.ylenurme.ee/~elmer/655/
arlan: No Arlan devices found 
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=19500 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch = 3000006
radeonfb: panel ID string: SHP
radeonfb: detected DFP panel size from BIOS: 1600x1200
radeonfb: ATI Radeon M9 Lf DDR SGRAM 64 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
cpqphp.o: Compaq Hot Plug PCI Controller Driver version: 0.9.7
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
mdacon: MDA with 8K of memory detected.
Console: switching consoles 1-16 to mono MDA-2 80x25
hStart = 1664, hEnd = 1856, hTotal = 2112
vStart = 1201, vEnd = 1204, vTotal = 1250
h_total_disp = 0xc70107	   hsync_strt_wid = 0x98067a
v_total_disp = 0x4af04e1	   vsync_strt_wid = 0x8304b0
post div = 0x2
fb_div = 0x8e
ppll_div_3 = 0x1008e
ron = 1632, roff = 17500
vclk_freq = 15975, per = 625
Console: switching to colour frame buffer device 200x75
pty: 256 Unix98 ptys configured
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto
(dz@debian.org)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 689M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing
disabled
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
STRIP: Version 1.3A-STUART.CHESHIRE (unlimited channels)
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and
others)
orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson
<hermes@gibson.dropbear.id.au>)
orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean
Tourrilhes <jt@hpl.hp.com>)
orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: PHILIPS DVD+RW SDVD6004, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HITACHI_DK23FB-60, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63,
UDMA(100)
hdc: TCQ not supported
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12
p13 >
ide-floppy driver 0.99.newide
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PHILIPS   Model: DVD+RW SDVD6004   Rev: 0.99
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
mdacon: MDA with 8K of memory detected.
Console: switching consoles 1-16 to mono MDA-2 80x25
Console: switching to colour frame buffer device 200x75
Yenta: CardBus bridge found at 0000:02:04.0 [1028:015f]
Yenta: ISA IRQ list 00f8, PCI irq16
Socket status: 30000006
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project
Team
NET: Registered protocol family 12
DECnet: Routing cache hash table of 1024 buckets, 8Kbytes
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 46k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc6, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc6) for (hdc6)
Using r5 hash to sort names
Mounted devfs on /dev
Freeing unused kernel memory: 300k freed
Adding 2048248k swap on /dev/hdc5.  Priority:-1 extents:1
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f4a22000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc12, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age
30
reiserfs: checking transaction log (hdc12) for (hdc12)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc7, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc7) for (hdc7)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc8, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc8) for (hdc8)
Using r5 hash to sort names
NTFS-fs warning (device hdc2): parse_options(): Option iocharset is
deprecated. Please use option nls=<charsetname> in the future.
NTFS volume version 3.1.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc11, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age
30
reiserfs: checking transaction log (hdc11) for (hdc11)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc9, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc9) for (hdc9)
Using r5 hash to sort names
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
spurious 8259A interrupt: IRQ7.
b44.c:v0.9 (Jul 14, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0b:db:9c:3f:11
b44: eth0: Link is down.
b44: eth0: Link is up at 10 Mbps, half duplex.
b44: eth0: Flow control is off for TX and off for RX.

------------------------------------------------------------

           CPU0
  0:    4735704          XT-PIC  timer
  1:       1581          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          4          XT-PIC  acpi
 12:       1184          XT-PIC  i8042
 14:          7          XT-PIC  ide0
 15:      12049          XT-PIC  ide1
 16:          0   IO-APIC-level  yenta
 17:          0   IO-APIC-level  eth0
 20:          0   IO-APIC-level  radeon@PCI:1:0:0
 23:          0   IO-APIC-level  ehci_hcd
NMI:          0
LOC:          0 
ERR:          1
MIS:          0

And here is a snapshot of my actual working config 
           CPU0
  0:      44641    IO-APIC-edge  timer
  1:        610    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 12:      12649    IO-APIC-edge  PS/2 Mouse
 14:         17    IO-APIC-edge  ide0
 15:      34247    IO-APIC-edge  ide1
 16:          0   IO-APIC-level  radeon@PCI:1:0:0
 17:      13733   IO-APIC-level  PCI device 104c:ac44 (Texas
Instruments), eth0, Intel ICH4
 23:          0   IO-APIC-level  ehci-hcd
NMI:          0
LOC:      52731
ERR:          0
MIS:          0



Le mar 14/10/2003 à 19:26, Pekka Pietikainen a écrit :
> On Tue, Oct 14, 2003 at 07:04:38PM +0200, marc.kalberer@bluewin.ch wrote:
> > Hello,
> > After about 30 recompiling of the kernel and svevral research on the net
> > I came to the result :
> > the Broadcom driver bcm4400 (b44) has a problem
> > 
> > log:
> > - Kernel: b44.c:v0.9 (july 2003)
> > - link is down 
> > - flow control is off for tx and off for rx
> > 
> > First I wasn't able to do a ifup: it gave me a siocsifflags not implemented
> > error,
> > but it disapear when I enable the acpi (??? Strange how those 2 things are
> > related ??)
> Hi
> 
> If both drivers failed it's probably something else. If ACPI makes
> it work, it might be something in the IRQ assignment, so
> everything interrupt related from dmesg (and /proc/interrupts) is 
> helpful in finding the problem. Also try to see whether turning off
> the "PnP OS" selection if you have it enabled in the BIOS helps.
> 
> There is one known problem in the driver which the following patch
> should fix. It only affects you if you see a tx transmit timeout
> message in the logs.
> 
> --- linux-2.6.0-0.test6.1.47/drivers/net/b44.c.orig	2003-09-28 03:50:18.000000000 +0300
> +++ linux-2.6.0-0.test6.1.47/drivers/net/b44.c	2003-10-03 18:55:29.000000000 +0300
> @@ -25,8 +25,8 @@
>  
>  #define DRV_MODULE_NAME		"b44"
>  #define PFX DRV_MODULE_NAME	": "
> -#define DRV_MODULE_VERSION	"0.9"
> -#define DRV_MODULE_RELDATE	"Jul 14, 2003"
> +#define DRV_MODULE_VERSION	"0.91"
> +#define DRV_MODULE_RELDATE	"Oct 3, 2003"
>  
>  #define B44_DEF_MSG_ENABLE	  \
>  	(NETIF_MSG_DRV		| \
> @@ -80,15 +80,6 @@
>  
>  static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
>  
> -#ifndef PCI_DEVICE_ID_BCM4401
> -#define PCI_DEVICE_ID_BCM4401      0x4401
> -#endif
> -
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> -#define IRQ_RETVAL(x) 
> -#define irqreturn_t void
> -#endif
> -
>  static struct pci_device_id b44_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
> @@ -870,6 +861,8 @@
>  
>  	spin_unlock_irq(&bp->lock);
>  
> +	b44_enable_ints(bp);
> +
>  	netif_wake_queue(dev);
>  }
>  
> 
