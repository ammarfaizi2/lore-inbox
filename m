Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSF3PM5>; Sun, 30 Jun 2002 11:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSF3PM4>; Sun, 30 Jun 2002 11:12:56 -0400
Received: from [62.3.122.162] ([62.3.122.162]:38841 "EHLO
	alien.meansolutions.com") by vger.kernel.org with ESMTP
	id <S315239AbSF3PMv>; Sun, 30 Jun 2002 11:12:51 -0400
Date: Sun, 30 Jun 2002 16:15:10 +0100
From: Anders Karlsson <anders.karlsson@meansolutions.com>
To: linux-kernel@vger.kernel.org
Subject: Spacewalker SS40
Message-ID: <20020630151510.GA21888@alien.meansolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have very recently bought a Shuttle SS40 and I have installed Debian
Woody on it. During the install process everything works fine, and the
machine installs nicely. Then I started adding a few of the things I
like in all systems, like a 2.4 kernel for example.=20

Debian Woody have 2.4.16 and 2.4.18 up for grabs, and I have tried
both. The problem with the 2.4 kernels seems to be that PCI does not
get recognised or enabled. Hence things like networking, USB and
IEEE1394 becomes unusable.

I have tried to get 2.4.19-rc1 installed, but as that does not compile
for various reasons I have not yet been able to test it.

Please find attached the output from /proc/pci, the output from lspci,
lspci -v as well as the output from dmesg when I boot the 2.4.18-k7
kernel.

Should any other details be required, let me know. I do not subscribe
to the list, so I will look in the archives for responses but would
appreciate it if I was CC'd.

Looking forward to hearing what the cause of the problem might be.

--=20
Anders Karlsson <anders dot karlsson at meansolutions dot com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc.pci.txt"
Content-Transfer-Encoding: quoted-printable

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Silicon Integrated Systems Unknown device (rev 1).
      Vendor id=3D1039. Device id=3D740.
      Medium devsel.  Master Capable.  Latency=3D32. =20
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe8000000].
  Bus  0, device   1, function  0:
    PCI bridge: Silicon Integrated Systems 5591/5592 AGP (rev 0).
      Fast devsel.  Master Capable.  Latency=3D99.  Min Gnt=3D12.
  Bus  0, device   2, function  0:
    ISA bridge: Silicon Integrated Systems 85C503 (rev 0).
      Medium devsel.  Master Capable.  No bursts. =20
  Bus  0, device   2, function  2:
    USB Controller: Silicon Integrated Systems 7001 USB (rev 7).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable. =
 Latency=3D32.  Max Lat=3D80.
      Non-prefetchable 32 bit memory at 0xec100000 [0xec100000].
  Bus  0, device   2, function  3:
    USB Controller: Silicon Integrated Systems 7001 USB (rev 7).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  =
Latency=3D32.  Max Lat=3D80.
      Non-prefetchable 32 bit memory at 0xec101000 [0xec101000].
  Bus  0, device   2, function  5:
    IDE interface: Silicon Integrated Systems 85C5513 (rev 208).
      Fast devsel.  Master Capable.  Latency=3D128. =20
      I/O at 0x4000 [0x4001].
  Bus  0, device  10, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 16).
      Vendor id=3D13f6. Device id=3D111.
      Medium devsel.  IRQ 10.  Master Capable.  Latency=3D32.  Min Gnt=3D2.=
Max Lat=3D24.
      I/O at 0xe000 [0xe001].
  Bus  0, device  11, function  0:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 80).
      Medium devsel.  IRQ 11.  Master Capable.  Latency=3D32. =20
      I/O at 0xe400 [0xe401].
  Bus  0, device  11, function  1:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 80).
      Medium devsel.  IRQ 12.  Master Capable.  Latency=3D32. =20
      I/O at 0xe800 [0xe801].
  Bus  0, device  11, function  2:
    USB Controller: VIA Technologies Unknown device (rev 81).
      Vendor id=3D1106. Device id=3D3104.
      Medium devsel.  IRQ 5.  Master Capable.  Latency=3D32. =20
      Non-prefetchable 32 bit memory at 0xec102000 [0xec102000].
  Bus  0, device  15, function  0:
    Ethernet controller: Realtek 8139 (rev 16).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable. =
 Latency=3D32.  Min Gnt=3D32.Max Lat=3D64.
      I/O at 0xec00 [0xec01].
      Non-prefetchable 32 bit memory at 0xec103000 [0xec103000].
  Bus  0, device  16, function  0:
    FireWire (IEEE 1394): Lucent (ex-AT&T) Microelectronics Unknown device =
(rev 4).
      Vendor id=3D11c1. Device id=3D5811.
      Medium devsel.  Fast back-to-back capable.  IRQ 12.  Master Capable. =
 Latency=3D32.  Min Gnt=3D12.Max Lat=3D24.
      Non-prefetchable 32 bit memory at 0xec104000 [0xec104000].
  Bus  1, device   0, function  0:
    VGA compatible controller: Silicon Integrated Systems Unknown device (r=
ev 0).
      Vendor id=3D1039. Device id=3D6325.
      Medium devsel.  Fast back-to-back capable.  BIST capable. =20
      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
      Non-prefetchable 32 bit memory at 0xec000000 [0xec000000].
      I/O at 0xd000 [0xd001].

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0740 (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0b.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:0b.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:0b.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51)
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:10.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 (rev 04)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: Unknown device 6325

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-v.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0740 (rev 01)
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0740
	Flags: bus master, medium devsel, latency 32
	Memory at e8000000 (32-bit, non-prefetchable)
	Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ec000000-ec0fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at ec100000 (32-bit, non-prefetchable)

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at ec101000 (32-bit, non-prefetchable)

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, fast devsel, latency 128
	I/O ports at 4000

00:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f440
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e000
	Capabilities: [c0] Power Management version 2

00:0b.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e400
	Capabilities: [80] Power Management version 2

00:0b.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at e800
	Capabilities: [80] Power Management version 2

00:0b.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51) (prog-if 20)
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ec102000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ec00
	Memory at ec103000 (32-bit, non-prefetchable)

00:10.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 (rev 04) (prog-if 10 [OHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f024
	Flags: bus master, medium devsel, latency 32, IRQ 12
	Memory at ec104000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: Unknown device 6325 (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 6325
	Flags: 66Mhz, medium devsel
	BIST result: 00
	Memory at e0000000 (32-bit, prefetchable)
	Memory at ec000000 (32-bit, non-prefetchable)
	I/O ports at d000
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 2.0


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.boot2.4.18-k7.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.4.18-k7 (root@shuttle) (gcc version 2.95.4 20011002 (Debian=
 prerelease)) #2 Sat Jun 29 17:36:29 BST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
 BIOS-e820: 000000001dff0000 - 000000001dff3000 (ACPI NVS)
 BIOS-e820: 000000001dff3000 - 000000001e000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f49b0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 122864
zone(0): 4096 pages.
zone(1): 118768 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D306
Initializing CPU#0
Detected 1593.231 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3178.49 BogoMIPS
Memory: 479492k/491456k available (796k kernel code, 11580k reserved, 208k =
data, 212k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor =3D 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1900+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-12, 2-21, 2-22 not conne=
cted.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E... register #01: 00178014
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0014
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
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
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    69
 0e 001 01  0    0    0   0   0    1    1    71
 0f 001 01  0    0    0   0   0    1    1    79
 10 001 01  1    1    0   1   0    1    1    81
 11 001 01  1    1    0   1   0    1    1    89
 12 001 01  1    1    0   1   0    1    1    91
 13 001 01  1    1    0   1   0    1    1    99
 14 001 01  1    1    0   1   0    1    1    A1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ23 -> 0:23
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1593.2385 MHz.
=2E.... host bus clock speed is 265.5396 MHz.
cpu: 0, clocks: 2655396, slice: 1327698
CPU0<T0:2655392,T1:1327680,D:14,S:1327698,C:2655396>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=3D1
PCI: System does not support PCI
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SH=
ARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
block: 128 slots per queue, batch=3D32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2396 blocks [1 disk] into ram disk... |=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08done.
Freeing initrd memory: 2396k freed
VFS: Mounted root (cramfs filesystem).
Journalled Block Device driver loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: MAXTOR 6L080J4, ATA DISK drive
hdc: PLEXTOR CD-R PX-320A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=3D155114/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [9732/255/63] p1 p2 < p5 p6 p7 p8=
 p9 p10 >
cramfs: wrong magic
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3D2
Freeing unused kernel memory: 212k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 506008k swap-space (priority -1)
Real Time Clock Driver v1.10e
LVM version 1.0.1-rc4(ish)(03/10/2001) module loaded
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
cdrom: open failed.
VFS: Disk change detected on device ide1(22,0)
loop: loaded (max 8 devices)
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:43:33 Jun 29 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:43:33 Jun 29 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub

--45Z9DzgjV8m4Oswq--

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9HyB+LYywqksgYBoRAgQgAKCSmYEZ0szkX8dcEA0s9i2VvC77GwCfea1n
rOECnKAZf94pemi3Nv9aYUE=
=8jbR
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
