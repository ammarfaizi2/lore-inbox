Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318351AbSGYG7I>; Thu, 25 Jul 2002 02:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSGYG7I>; Thu, 25 Jul 2002 02:59:08 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:4
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S318351AbSGYG7G>; Thu, 25 Jul 2002 02:59:06 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: MTRR Problems - 2.4.19-rc3
Date: Thu, 25 Jul 2002 03:03:20 -0400
User-Agent: KMail/1.4.5
Cc: rgooch@atnf.csiro.au
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4K6P9Y7r/alergs"
Message-Id: <200207250303.20809.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4K6P9Y7r/alergs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
mtrr: no MTRR for e0000000,4000000 found

Someone explain how an AMD Motherboard is Intel type? ;-)=20

The AGP Card is: AGP4x
Video card; Is an All-In-Wonder (see below)
Motherboard: A7M266-D, Bios 1006 release

lspci listing:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] Syst=
em=20
Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP=20
Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev=
=20
04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 04)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 7500 QW
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:05.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78)
02:08.0 USB Controller: NEC Corporation USB (rev 41)
02:08.1 USB Controller: NEC Corporation USB (rev 41)
02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

Dmesg attached

Shawn.

--Boundary-00=_4K6P9Y7r/alergs
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.19-rc3 (root@unknown) (gcc version 3.1) #2 Thu Jul 25 01:24:28 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f7d40
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
Advanced speculative caching feature present
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: BOOT_IMAGE=linux ro root=302 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1680.422 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3355.44 BogoMIPS
Memory: 515636k/524208k available (1223k kernel code, 8184k reserved, 298k data, 272k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Advanced speculative caching feature present
Disabling advanced speculative caching
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbf7 c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU: AMD Athlon(TM) MP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
....changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
...TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
..... register #00: 02000000
........    : physical APIC id: 02
..... register #01: 00170011
........     : max redirection entries: 0017
........     : PRQ implemented: 0
........     : IO APIC version: 0011
..... register #02: 00000000
........     : arbitration: 00
..... IRQ redirection table:
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
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
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
..................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
...... CPU clock speed is 1680.3879 MHz.
...... host bus clock speed is 268.8619 MHz.
cpu: 0, clocks: 2688619, slice: 1344309
CPU0<T0:2688608,T1:1344288,D:11,S:1344309,C:2688619>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1dd0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
PCI->APIC IRQ transform: (B1,I5,P0) -> 16
PCI->APIC IRQ transform: (B2,I4,P0) -> 17
PCI->APIC IRQ transform: (B2,I5,P0) -> 18
PCI->APIC IRQ transform: (B2,I8,P0) -> 19
PCI->APIC IRQ transform: (B2,I8,P1) -> 16
PCI->APIC IRQ transform: (B2,I8,P2) -> 17
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
amd768_rng: AMD768 system management I/O registers at 0xE400.
amd768_rng hardware driver 0.1.0 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060J3, ATA DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63, UDMA(100)
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:05.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xa400. Vers LK1.1.16
 ***INVALID CHECKSUM 002f*** <6>Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xf0000000
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
[drm] AGP 0.99 on AMD Irongate @ 0xf0000000 128MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
cmipci: no OPL device at 0x388, skipping...
smb_get_length: recv error = 512
smb_request: result -512, setting invalid
smb_retry: successful, new pid=122, generation=2
mtrr: no MTRR for e0000000,4000000 found
[drm] Module unloaded
[drm] AGP 0.99 on AMD Irongate @ 0xf0000000 128MB
[drm] Initialized radeon 1.2.0 20010405 on minor 0

--Boundary-00=_4K6P9Y7r/alergs--

