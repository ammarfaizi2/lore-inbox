Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbSJBVE0>; Wed, 2 Oct 2002 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbSJBVE0>; Wed, 2 Oct 2002 17:04:26 -0400
Received: from 184.80-203-35.nextgentel.com ([80.203.35.184]:27239 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S262584AbSJBVEV>;
	Wed, 2 Oct 2002 17:04:21 -0400
Subject: Preliminary report on 2.5.39bk2
From: Kjartan Maraas <kmaraas@online.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1033592854.1556.5.camel@sevilla.gnome.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 23:07:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this one to boot by removing the boot label stuff in grub.conf and
using the partition name instead and from a short test drive it seems
that the IDE stuff is working ok here at least. Other stuff that didn't
work quite that well was sound and USB, but that's probably a matter of
configuration more than a kernel problem.

dmesg output below if that's interesting for anyone. I'll see if I can
do some more testing later this week.

I wonder what I must do to get the ext3 partition mounted correctly,
since after modifying grub.conf it was mounted as an ext2 partition.

Cheers
Kjartan

Linux version 2.5.39bk2 (kmaraas@sevilla.gnome.no) (gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-110)) #1 Mon Sep 30 23:05:44 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
 BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65488
  DMA zone: 4096 pages
  Normal zone: 61392 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f72d0
ACPI: RSDT (v001 COMPAQ CPQ0022  00517.00544) @ 0x0fff0c84
ACPI: FADT (v002 COMPAQ CPQ0022  00000.00002) @ 0x0fff0c00
ACPI: DSDT (v001 COMPAQ EVON400C 00001.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 846.953 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1675.26 BogoMIPS
Memory: 254840k/261952k available (2123k kernel code, 6724k reserved,
791k data, 120k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0491, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
loaded
Parsing
Methods:.............................................................................................................................................................................................................................................................
Table [DSDT] - 741 Objects with 71 Devices 253 Methods 17 Regions
ACPI Namespace successfully loaded at root c043741c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
 evevent-0568 [07] Ev_save_method_info   : Unknown GPE method type: C10E
(name not of form _Lnn or _Enn)
 evevent-0568 [07] Ev_save_method_info   : Unknown GPE method type: C159
(name not of form _Lnn or _Enn)
 evevent-0568 [07] Ev_save_method_info   : Unknown GPE method type: C1B0
(name not of form _Lnn or _Enn)
Executing all Device _STA and_INI
methods:.......................................................................
71 Devices found containing: 71 _STA, 7 _INI methods
Completing Region/Field/Buffer/Package
initialization:.............................................................................
Initialized 7/17 Regions 0/0 Fields 22/23 Buffers 48/56 Packages (741
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: Power Resource [C11E] (on)
ACPI: Power Resource [C132] (on)
ACPI: Power Resource [C137] (on)
ACPI: Power Resource [C13A] (on)
ACPI: Power Resource [C146] (on)
ACPI: Power Resource [C1C6] (off)
ACPI: Power Resource [C1C7] (off)
ACPI: Power Resource [C1C8] (off)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 03 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [C179] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
dswstate-0252 [28] Ds_result_pop_from_bot: No result objects!
State=cff6d428
 dsutils-0461 [28] Ds_create_operand     : Missing or null operand,
AE_AML_NO_RETURN_VALUE
 dsutils-0554 [27] Ds_create_operands    : While creating Arg 1 -
AE_AML_NO_RETURN_VALUE
 psparse-1155: *** Error: Method execution failed,
AE_AML_NO_RETURN_VALUE
Method pathname:  \_TZ_.TZ1_._TMP (Node c12c212c)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:08.0
PCI: Sharing IRQ 11 with 00:09.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (4545,1116,32902,8705)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0x50000000
[drm] AGP 0.99 on Intel 440BX @ 0x50000000 64MB
MTRR: setting reg 1
[drm] Initialized radeon 1.6.0 20020828 on minor 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3460-0x3467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3468-0x346f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
Debug: sleeping function called from illegal context at slab.c:1374
c12f1eb4 c0114d86 c03212e0 c03232c2 0000055e 000001d0 c0130a11 c03232c2 
       0000055e cff61a94 c024258c c045384c 00000042 c045384c 00000004
000001d0 
       c0130a11 cff68534 c024a280 04000000 c04537b0 c0109132 00000018
000001d0 
Call Trace:
 [<c0114d86>]__might_sleep+0x56/0x60
 [<c0130a11>]kmalloc+0x61/0x220
 [<c024258c>]piix_tune_chipset+0x33c/0x350
 [<c0130a11>]kmalloc+0x61/0x220
 [<c024a280>]ide_intr+0x0/0x190
 [<c0109132>]request_irq+0x52/0xa0
 [<c0243a3d>]init_irq+0x1fd/0x340
 [<c024a280>]ide_intr+0x0/0x190
 [<c0243e8c>]hwif_init+0x10c/0x250
 [<c024371d>]probe_hwif_init+0x1d/0x70
 [<c0253f7b>]ide_setup_pci_device+0x3b/0x60
 [<c0242745>]piix_init_one+0x35/0x40
 [<c0105098>]init+0x38/0x1b0
 [<c0105060>]init+0x0/0x1b0
 [<c01054f5>]kernel_thread_helper+0x5/0x10

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Compaq DVD-ROM DV28EA 01, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
c12f1eb4 c0114d86 c03212e0 c03232c2 0000055e 000001d0 c0130a11 c03232c2 
       0000055e 00000300 c024258c c0453e24 00000022 c0453e24 00000004
000001d0 
       c0130a11 cff685fc c024a280 04000000 c0453d88 c0109132 00000018
000001d0 
Call Trace:
 [<c0114d86>]__might_sleep+0x56/0x60
 [<c0130a11>]kmalloc+0x61/0x220
 [<c024258c>]piix_tune_chipset+0x33c/0x350
 [<c0130a11>]kmalloc+0x61/0x220
 [<c024a280>]ide_intr+0x0/0x190
 [<c0109132>]request_irq+0x52/0xa0
 [<c0243a3d>]init_irq+0x1fd/0x340
 [<c024a280>]ide_intr+0x0/0x190
 [<c0243e8c>]hwif_init+0x10c/0x250
 [<c024371d>]probe_hwif_init+0x1d/0x70
 [<c0253f99>]ide_setup_pci_device+0x59/0x60
 [<c0242745>]piix_init_one+0x35/0x40
 [<c0105098>]init+0x38/0x1b0
 [<c0105060>]init+0x0/0x1b0
 [<c01054f5>]kernel_thread_helper+0x5/0x10

ide1 at 0x170-0x177,0x376 on irq 15
ide2: ports already in use, skipping probe
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2584/240/63,
UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: not ready
request_module[scsi_hostadapter]: not ready
request_module[scsi_hostadapter]: not ready
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Mon Aug 05
14:24:05 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000010
EXT2-fs warning (device ide0(3,3)): ext2_fill_super: mounting ext3
filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Real Time Clock Driver v1.11
Adding 521600k swap on /dev/hda5.  Priority:-1 extents:1
usb.c: registered new driver usbfs
usb.c: registered new driver hub
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
irda_init()
irlan_init()
irlan_register_netdev()
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:09.0
PCI: Sharing IRQ 11 with 00:08.0
PCI: Sharing IRQ 11 with 00:09.1
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:59:7F:94:C6, IRQ 11.
  Board assembly 980100-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
eth0: 0 multicast blocks dropped.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Debug: sleeping function called from illegal context at slab.c:1374
cdf2bf4c c0114d86 c03212e0 c03232c2 0000055e 000001d0 c0130a11 c03232c2 
       0000055e c128e268 cdf4cdc8 cdf2a000 cedb1e54 c012a96e cedb1e54
cdf4cdc8 
       cdf4ce60 00000000 00000400 00000001 ce460ba0 c010b813 00000080
000001d0 
Call Trace:
 [<c0114d86>]__might_sleep+0x56/0x60
 [<c0130a11>]kmalloc+0x61/0x220
 [<c012a96e>]do_munmap+0x10e/0x120
 [<c010b813>]sys_ioperm+0x83/0x120
 [<c01071cf>]syscall_call+0x7/0xb

mtrr: 0x40000000,0x800000 overlaps existing 0x40000000,0x400000
mtrr: 0x40000000,0x800000 overlaps existing 0x40000000,0x400000
cdrom: This disc doesn't have any tracks I recognize!


