Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTERJGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTERJGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:06:45 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:1920 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S261280AbTERJGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:06:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: "Unexpected IO APIC" on MSI KT4 Ultra (Via KT400 chipset)
Date: Sun, 18 May 2003 10:19:24 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305181019.30958.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Subject says it all really.

Dmesg advised me to send this - its from a 2.4.21pre4 kernel (I think its pre4 
- - its a Mandrake patched one, but I figured the APIC stuff would be common to 
a vanilla kernel)

I appear to have no issues with enabling APIC related stuff on this board, 
which is nice :)

As an aside, does anyone know why my onboard drive controlers are having dma 
disabled? (hda - hdd are on the KT400 ATA133 controler)

Cheers,

Mark.






Linux version 2.4.21-3mrw (root@rebecca) (gcc version 3.2 (Mandrake Linux 9.0 
3.2-1mdk)) #3 Sat Apr 5 11:52:16 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb940
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=2.4.21-3mrw ro root=2201 devfs=mount 
ide=reverse
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
Detected 1733.446 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515832k/524224k available (1412k kernel code, 8004k reserved, 507k 
data, 148k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-20, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 26.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    A9
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1733.4693 MHz.
..... host bus clock speed is 266.6876 MHz.
cpu: 0, clocks: 2666876, slice: 1333438
CPU0<T0:2666864,T1:1333424,D:2,S:1333438,C:2666876>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I6,P0) -> 17
PCI->APIC IRQ transform: (B0,I7,P0) -> 19
PCI->APIC IRQ transform: (B0,I8,P0) -> 18
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B0,I13,P0) -> 19
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:10.2, from 10 to 5
PCI: Via IRQ fixup for 00:10.1, from 12 to 5
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
SiI680: IDE controller at PCI slot 00:08.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133 
    ide2: MMIO-DMA at 0xe0800f00-0xe0800f07, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xe0800f08-0xe0800f0f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hda: DMA disabled
blk: queue c0333ea0, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hde: MAXTOR 6L020J1, ATA DISK drive
blk: queue c0334738, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4D040H2, ATA DISK drive
blk: queue c0334b84, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xe0800f80-0xe0800f87,0xe0800f8a on irq 18
ide3 at 0xe0800fc0-0xe0800fc7,0xe0800fca on irq 18
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
hde: host protected area => 1
hde: 40132503 sectors (20548 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(133)
hdg: host protected area => 1
hdg: setmax LBA 80043264, native  78125000
hdg: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host2/bus0/target0/lun0:<6> [PTBL] [2498/255/63] p1
 /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 p4 < p5 p6 >
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 22:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:01:05 Apr  2 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xac00, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 21, pci mem e0908d00
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2002-Dec-20
hub.c: USB hub found
hub.c: 6 ports detected
usbdevfs: remount parameter error
Adding Swap: 928832k swap-space (priority -1)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)
hub.c: new USB device 00:10.0-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc506) is not claimed by any active 
driver.
hub.c: new USB device 00:10.1-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
reiserfs: checking transaction log (device 22:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb.c: registered new driver usb_mouse
input0: Logitech USB Receiver on usb3:2.0
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NTFS driver 2.1.1a [Flags: R/O MODULE].
NTFS volume version 3.1.
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
reiserfs: checking transaction log (device 22:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 22:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth0: NatSemi DP8381[56] at 0xe0bdd000, 00:02:e3:0a:21:9b, IRQ 17.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+x1Aia0XO123WNagRAivgAJ48f6mhGwy8ItvcWoELchCB3aA+wACgqjge
PKYlhi0sLVvIAtDMUjAlsZI=
=hbwX
-----END PGP SIGNATURE-----

