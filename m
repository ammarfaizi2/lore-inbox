Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSEMP6m>; Mon, 13 May 2002 11:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEMP6l>; Mon, 13 May 2002 11:58:41 -0400
Received: from adsl-132-170.wanadoo.be ([213.177.132.170]:18476 "EHLO
	slack.local") by vger.kernel.org with ESMTP id <S314077AbSEMP6e>;
	Mon, 13 May 2002 11:58:34 -0400
From: Pol <blenderman@wanadoo.be>
Reply-To: blenderman@wanadoo.be
To: linux-kernel@vger.kernel.org
Subject: Freeze on 2.4.18
Date: Mon, 13 May 2002 18:01:57 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <20020513120953.GD4258@louise.pinerecords.com> <20020513151121.GA5811@louise.pinerecords.com> <20020513145125.GG10675@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9J42A1G32E30I0XPX5BZ"
Message-Id: <200205131802.01422.blenderman@wanadoo.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9J42A1G32E30I0XPX5BZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi all,

I subscribed to this mailing list to try to find a solution to my linux b=
ox,=20
this is my first message, I hope I have done it well.

Everything was ok in my linux box until I bought my harddisk 80 Go of IGM=
=20
(GXP).

Here is the problem:

Sometimes when I boot my system, It freeze ... You can check the oops inc=
luded=20
in the email.
More strange ... When I enable the UDMA in the bios of my motherboard,
I get some errors like:

hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }

So, Like I have that errors, I disable it and I have no errors.

Anyway, that's a part of the problem.

The second part is that my computer is really buggy ... I don't know why
=2E.. I work ... freeze ... I play ... freeze ... I make 3D .... it freez=
e ....
That's really boring.

Now third part, when I reboot it just after a crash, I get a beautifull O=
OPS.

I don't know how to reproduce it ... but I need to reset the computer 3 o=
r 4=20
times
to make it go away.

I want you to know that all this problems come just after the bought of m=
y new=20
HD. Before the IBM, I had a Maxtor of 20Go ... and I had NO ANY PROBLEM !=
!

I use Linux (Slackware) since now 3 years and it is the first time I see =
a=20
problem like mine.

I also remarqued that I have less booting problem when I use the kernel=20
2.5.15... dunno why

So, here is my machine spec:

[17:53:36][blenderman@slack:~]$ uname -a
Linux slack 2.5.15 #1 SMP Sat May 11 23:02:24 CEST 2002 i686 unknown

[17:53:54][root@slack:/home/blenderman]# lspci=20
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4=
)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 4=
0)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev =
06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] =
(rev=20
40)
00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev=
 07)
00:0e.1 Input device controller: Creative Labs SB Live! (rev 07)
00:10.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (re=
v 04)
[17:53:57][root@slack:/home/blenderman]#=20

[17:55:14][root@slack:/home/blenderman]# free
             total       used       free     shared    buffers     cached
Mem:       1035444     809812     225632          0      97088     558476
-/+ buffers/cache:     154248     881196
Swap:      1951856          0    1951856
[17:55:22][root@slack:/home/blenderman]#=20

My motherboard is a MSI 694D-pro Version 1.0

[17:55:22][root@slack:/home/blenderman]# cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.276
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a=20
cmov       pat pse36 mmx fxsr sse
bogomips        : 1998.84

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.276
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a=20
cmov       pat pse36 mmx fxsr sse
bogomips        : 1998.84

my dmesg:

Linux version 2.5.15 (root@slack) (gcc version 2.95.3 20010315 (release))=
 #1=20
SMP Sat M
ay 11 23:02:24 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5fd0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=3D2.5.15 root=3D302
Initializing CPU#0
Detected 1002.276 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 1035216k/1048576k available (1438k kernel code, 12972k reserved, =
466k=20
data, 22
8k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.04 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1998.84 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3997.69 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23=
 not=20
connecte
d.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E... register #01: 00178011
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 002 02  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1002.2517 MHz.
=2E.... host bus clock speed is 133.6329 MHz.
cpu: 0, clocks: 1336329, slice: 445443
CPU0<T0:1336320,T1:890864,D:13,S:445443,C:1336329>
cpu: 1, clocks: 1336329, slice: 445443
CPU1<T0:1336320,T1:445424,D:10,S:445443,C:1336329>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=3D0
migration_task 1 on cpu=3D1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=3D1
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I14,P0) -> 10
PCI->APIC IRQ transform: (B0,I16,P0) -> 11
PCI->APIC IRQ transform: (B1,I0,P0) -> 10
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
parport0: PC-style at 0x3bc [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=3D0x3BC
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL=
_PCI=20
ISAPNP e
nabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
lp0: using parport0 (polling).
block: 256 slots per queue, batch=3D32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ATA/ATAPI driver v7.0.0
ATA: system bus speed 33MHz
ATA: VIA Technologies, Inc. Bus Master IDE (1106:0571) on PCI slot 00:07.=
1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
hdc: 40X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 160836480 sectors w/1863KiB Cache, CHS=3D159560/16/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [10011/255/63] hda1 hda2
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xd800, IRQ 5
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.0 (8192 buckets, 65536 max) - 292 bytes per conntr=
ack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
hub.c: new USB device 00:07.2-1, assigned address 2
hid-core.c: ctrl urb status -32 received
input.c: calling /sbin/hotplug input [HOME=3D/=20
PATH=3D/sbin:/bin:/usr/sbin:/usr/bin ACTION
=3Dadd PRODUCT=3D3/45e/40/121 NAME=3DMicrosoft Microsoft Wheel Mouse Opti=
cal<AE>]
input.c: hotplug returned -2
input,hiddev0: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse=20
Optical<AE>] on us
b-00:07.2-1
Reiserfs journal params: device 03:02, size 8192, journal first block 18,=
 max=20
trans le
n 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,2)) for (ide0(3,2))
reiserfs: replayed 29 transactions in 0 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 1951856k swap-space (priority -1)
Creative EMU10K1 PCI Audio Driver, version 0.16, 23:07:13 May 11 2002
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xdc00-0xdc1f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
fealnx.c:v2.51 Nov-17-2001
eth0: 100/10M Ethernet PCI Adapter at 0xe400, 00:02:44:20:58:f1, IRQ 11.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xc0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0

Thanks to all who can help me and those who read my SOS.

-pol-
--------------Boundary-00=_9J42A1G32E30I0XPX5BZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops"

Unable to handle kernel NULL pointer dereference at virtual address 00000018
printing eip: 00000018
*pde = 00000000
Oops = 0000
CPU = 1
EIP = 0010:[<00000018>]   Not tainted
EFLAGS = 00010246
ttyS00 at 0x02f8  (irq = 4) is a 16550A
esi: c2018000    edi: c01051c0    ebp: 00000000   esp: c2019fb0
Stack: ttyS01 at 0x02f8 (irq = 3) is a 16550A
c0105252   00000002   00000000   00000000   c02c3f16   00000bfc   00000bfc
00000286   fffff404   00000292   c02a5e40   00000000   00000001   00000286
00000001   0000002a   c01171c8   c031f9ca   00000000   c01170de
Call trace: [<c0105252>] [<c01171c8>] [<c01170de>]
Code: Bad EIP value.
<0> Kernel Panic: Attempted to kill the idle task!
In idle task - Not syncing

--------------Boundary-00=_9J42A1G32E30I0XPX5BZ--

