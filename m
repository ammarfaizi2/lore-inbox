Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUEXPiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUEXPiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbUEXPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:38:20 -0400
Received: from [128.192.48.229] ([128.192.48.229]:18560 "EHLO
	xavier.soforext.net") by vger.kernel.org with ESMTP id S264308AbUEXPhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:37:33 -0400
Message-ID: <002c01c441a5$4b1d09a0$af30c080@wolverine>
Reply-To: "Todd Elsbernd" <telsbernd@sref.info>
From: "Todd Elsbernd" <telsbernd@sref.info>
To: <linux-kernel@vger.kernel.org>
Subject: Oops error: Bad EIP value  question
Date: Mon, 24 May 2004 11:39:25 -0400
Organization: University of Georgia
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to upgrade my debian system, kernel was version 2.4.18 and
working fine.
After compiling new kernel images (for both 2.4.26 and 2.6.6), I go through
the whole process, no errors reported.  System boots fine off the new kernel
image, and everything works fine EXCEPT for sleep, tar, and "ls -l".  I have
tried recompiling with various different options enabled for the kernel,
nothing seems to make a difference.  I even recompiled tar from the latest
source files, it still gives the error.  Any help would be greatly
appreciated, below is the relevant logs/output, you will see the errors near
the bottom.

76 bytes)

Inode cache hash table entries: 65536 (order: 7, 524288 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)

Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 512K

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: After generic, caps: 0383fbff 00000000 00000000 00000000

CPU: Common caps: 0383fbff 00000000 00000000 00000000

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 512K

Intel machine check reporting enabled on CPU#0.

CPU: After generic, caps: 0383fbff 00000000 00000000 00000000

CPU: Common caps: 0383fbff 00000000 00000000 00000000

CPU0: Intel Pentium III (Katmai) stepping 03

per-CPU timeslice cutoff: 1464.52 usecs.

enabled ExtINT on CPU#0

ESR value before enabling vector: 00000040

ESR value after enabling vector: 00000000

Booting processor 1/0 eip 2000

Initializing CPU#1

masked ExtINT on CPU#1

ESR value before enabling vector: 00000000

ESR value after enabling vector: 00000000

Calibrating delay loop... 894.56 BogoMIPS

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 512K

Intel machine check reporting enabled on CPU#1.

CPU: After generic, caps: 0383fbff 00000000 00000000 00000000

CPU: Common caps: 0383fbff 00000000 00000000 00000000

CPU1: Intel Pentium III (Katmai) stepping 03

Total of 2 processors activated (1789.13 BogoMIPS).

ENABLING IO-APIC IRQs

Setting 2 in the phys_id_present_map

...changing IO-APIC physical APIC ID to 2 ... ok.

init IO_APIC IRQs

IO-APIC (apicid-pin) 2-0, 2-5, 2-7, 2-10, 2-11, 2-13, 2-14, 2-23 not
connected.

..TIMER: vector=0x31 pin1=2 pin2=0

number of MP IRQ sources: 36.

number of IO-APIC #2 registers: 24.

testing the IO APIC.......................

IO APIC #2......

.... register #00: 02000000

....... : physical APIC id: 02

....... : Delivery Type: 0

....... : LTS : 0

.... register #01: 00170011

....... : max redirection entries: 0017

....... : PRQ implemented: 0

....... : IO APIC version: 0011

.... register #02: 00000000

....... : arbitration: 00

.... IRQ redirection table:

NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:

00 000 00 1 0 0 0 0 0 0 00

01 003 03 0 0 0 0 0 1 1 39

02 003 03 0 0 0 0 0 1 1 31

03 003 03 0 0 0 0 0 1 1 41

04 003 03 0 0 0 0 0 1 1 49

05 000 00 1 0 0 0 0 0 0 00

06 003 03 0 0 0 0 0 1 1 51

07 000 00 1 0 0 0 0 0 0 00

08 003 03 0 0 0 0 0 1 1 59

09 003 03 0 0 0 0 0 1 1 61

0a 000 00 1 0 0 0 0 0 0 00

0b 000 00 1 0 0 0 0 0 0 00

0c 003 03 0 0 0 0 0 1 1 69

0d 000 00 1 0 0 0 0 0 0 00

0e 000 00 1 0 0 0 0 0 0 00

0f 003 03 0 0 0 0 0 1 1 71

10 003 03 1 1 0 1 0 1 1 79

11 003 03 1 1 0 1 0 1 1 81

12 003 03 1 1 0 1 0 1 1 89

13 003 03 1 1 0 1 0 1 1 91

14 003 03 1 1 0 1 0 1 1 99

15 003 03 1 1 0 1 0 1 1 A1

16 003 03 1 1 0 1 0 1 1 A9

17 000 00 1 0 0 0 0 0 0 00

IRQ to pin mappings:

IRQ0 -> 0:2

IRQ1 -> 0:1

IRQ3 -> 0:3

IRQ4 -> 0:4

IRQ6 -> 0:6

IRQ8 -> 0:8

IRQ9 -> 0:9

IRQ12 -> 0:12

IRQ15 -> 0:15

IRQ16 -> 0:16

IRQ17 -> 0:17

IRQ18 -> 0:18

IRQ19 -> 0:19

IRQ20 -> 0:20

IRQ21 -> 0:21

IRQ22 -> 0:22

.................................... done.

Using local APIC timer interrupts.

calibrating APIC timer ...

..... CPU clock speed is 448.8823 MHz.

..... host bus clock speed is 99.7513 MHz.

cpu: 0, clocks: 997513, slice: 332504

CPU0<T0:997504,T1:664992,D:8,S:332504,C:997513>

cpu: 1, clocks: 997513, slice: 332504

CPU1<T0:997504,T1:332496,D:0,S:332504,C:997513>

checking TSC synchronization across CPUs: passed.

Waiting on wait_init_idle (map = 0x2)

All processors have done init_idle

PCI: PCI BIOS revision 2.10 entry at 0xfcc0e, last bus=3

PCI: Using configuration type 1

PCI: Probing PCI hardware

PCI: Probing PCI hardware (bus 00)

PCI: Using IRQ router default [8086/7110] at 00:07.0

PCI->APIC IRQ transform: (B0,I8,P0) -> 20

PCI->APIC IRQ transform: (B0,I10,P0) -> 21

PCI->APIC IRQ transform: (B0,I14,P0) -> 17

PCI->APIC IRQ transform: (B2,I4,P0) -> 16

PCI->APIC IRQ transform: (B2,I6,P0) -> 16

PCI->APIC IRQ transform: (B2,I10,P0) -> 18

PCI: Cannot allocate resource region 4 of device 00:07.1

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

Journalled Block Device driver loaded

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled

Floppy drive(s): fd0 is 1.44M

FDC 0 is a National Semiconductor PC87306

eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html

eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others

eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:DE:A5:68, IRQ 20.

Board assembly 735190-002, Physical connectors present: RJ45

Primary interface chip i82555 PHY #1.

General self-test: passed.

Serial sub-system self-test: passed.

Internal registers self-test: passed.

ROM checksum self-test: passed (0x04f4518b).

Linux agpgart interface v0.99 (c) Jeff Hartmann

agpgart: Maximum main memory to use for agp memory: 816M

agpgart: Detected Intel 440GX chipset

agpgart: AGP aperture is 64M @ 0xf0000000

[drm] Initialized tdfx 1.0.0 20010216 on minor 0

[drm] AGP 0.99 Aperture @ 0xf0000000 64MB

[drm] Initialized radeon 1.7.0 20020828 on minor 1

[drm] AGP 0.99 Aperture @ 0xf0000000 64MB

[drm] Initialized i810 1.2.1 20020211 on minor 2

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

PIIX4: IDE controller at PCI slot 00:07.1

PCI: Enabling device 00:07.1 (0000 -> 0001)

PIIX4: chipset revision 1

PIIX4: not 100% native mode: will probe irqs later

PIIX4: neither IDE port enabled (BIOS)

SCSI subsystem driver Revision: 1.00

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

<Adaptec 2940 Ultra2 SCSI adapter>

aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

<Adaptec aic7890/91 Ultra2 SCSI adapter>

aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

<Adaptec aic7860 Ultra SCSI adapter>

aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)

Vendor: SONY Model: TSL-11000 Rev: L0u6

Type: Sequential-Access ANSI SCSI revision: 02

Vendor: SONY Model: TSL-11000 Rev: L0u6

Type: Medium Changer ANSI SCSI revision: 02

(scsi2:A:5): 20.000MB/s transfers (20.000MHz, offset 15)

Vendor: NEC Model: CD-ROM DRIVE:466 Rev: 1.06

Type: CD-ROM ANSI SCSI revision: 02

megaraid: v1.18k (Release Date: Thu Aug 28 10:05:11 EDT 2003)

megaraid: found 0x8086:0x1960:idx 0:bus 2:slot 10:func 1

scsi3 : Found a MegaRAID controller at 0xf881e000, IRQ: 18

megaraid: [3.13:1.43] detected 2 logical drives

megaraid: channel[1] is raid.

scsi3 : LSI Logic MegaRAID 3.13 254 commands 15 targs 4 chans 7 luns

scsi3: scanning virtual channel 0 for logical drives.

Vendor: MegaRAID Model: LD0 RAID5 34556R Rev: 3.13

Type: Direct-Access ANSI SCSI revision: 02

Vendor: MegaRAID Model: LD1 RAID5 17136R Rev: 3.13

Type: Direct-Access ANSI SCSI revision: 02

scsi3: scanning physical channel 0 for devices.

Vendor: DELL Model: 1x6 U2W SCSI BP Rev: 5.35

Type: Processor ANSI SCSI revision: 02

Attached scsi disk sda at scsi3, channel 0, id 0, lun 0

Attached scsi disk sdb at scsi3, channel 0, id 1, lun 0

SCSI device sda: 70770688 512-byte hdwr sectors (36235 MB)

Partition check:

sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >

SCSI device sdb: 35094528 512-byte hdwr sectors (17968 MB)

sdb: sdb1

es1371: version v0.32 time 10:17:33 May 24 2004

Linux Kernel Card Services 3.1.22

options: [pci] [cardbus] [pm]

usb.c: registered new driver hub

host/uhci.c: USB Universal Host Controller Interface driver v1.1

PCI: Enabling device 00:07.2 (0000 -> 0001)

PCI: No IRQ known for interrupt pin D of device 00:07.2. Probably buggy MP
table.

host/uhci.c: found UHCI device with no IRQ assigned. check BIOS settings!

Initializing USB Mass Storage driver...

usb.c: registered new driver usb-storage

USB Mass Storage support registered.

NET4: Linux TCP/IP 1.0 for NET4.0

IP: routing cache hash table of 8192 buckets, 64Kbytes

TCP: Hash tables configured (established 262144 bind 65536)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

ds: no socket drivers loaded!

VFS: Mounted root (ext2 filesystem) readonly.

Freeing unused kernel memory: 124k freed

Adding Swap: 248996k swap-space (priority -1)

raid5: measuring checksumming speed

8regs : 783.200 MB/sec

32regs : 516.400 MB/sec

pIII_sse : 894.000 MB/sec

pII_mmx : 988.800 MB/sec

p5_mmx : 1040.400 MB/sec

raid5: using function: pIII_sse (894.000 MB/sec)

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

md: raid5 personality registered as nr 4

ttyS0: LSR safety check engaged!

ttyS0: LSR safety check engaged!

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting. Commit interval 5 seconds

EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal

EXT3-fs: mounted filesystem with ordered data mode.

ip_tables: (C) 2000-2002 Netfilter core team

Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: f4fe2000 ecx: bffffdf8 edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffd68 esp: f4fe3fc0

ds: 0018 es: 0018 ss: 0018

Process sleep (pid: 261, stackpage=f4fe3000)

Stack: c0106ed3 00000000 bffffdf8 40046214 00000016 ffffffff bffffd68
00000109

0000002b 0000002b 00000109 40043e46 00000023 00000246 bffffd4c 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: f4fe2000 ecx: bffffda8 edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffd18 esp: f4fe3fc0

ds: 0018 es: 0018 ss: 0018

Process sleep (pid: 271, stackpage=f4fe3000)

Stack: c0106ed3 00000000 bffffda8 40046214 00000016 ffffffff bffffd18
00000109

0000002b 0000002b 00000109 40043e46 00000023 00000246 bffffcfc 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 0

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: f4b14000 ecx: bffffdf8 edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffd68 esp: f4b15fc0

ds: 0018 es: 0018 ss: 0018

Process sleep (pid: 297, stackpage=f4b15000)

Stack: c0106ed3 00000000 bffffdf8 40046214 00000016 ffffffff bffffd68
00000109

0000002b 0000002b 00000109 40043e46 00000023 00000246 bffffd4c 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: f3a7a000 ecx: 0806885c edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffc68 esp: f3a7bfc0

ds: 0018 es: 0018 ss: 0018

Process tar (pid: 372, stackpage=f3a7b000)

Stack: c0106ed3 00000000 0806885c 40024214 00000016 ffffffff bffffc68
00000109

0000002b 0000002b 00000109 40021e46 00000023 00000246 bffffc4c 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: f3b14000 ecx: 0806885c edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffdc8 esp: f3b15fc0

ds: 0018 es: 0018 ss: 0018

Process tar (pid: 373, stackpage=f3b15000)

Stack: c0106ed3 00000000 0806885c 40024214 00000016 ffffffff bffffdc8
00000109

0000002b 0000002b 00000109 40021e46 00000023 00000246 bffffdac 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: efbec000 ecx: bffffb50 edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffb18 esp: efbedfc0

ds: 0018 es: 0018 ss: 0018

Process ls (pid: 943, stackpage=efbed000)

Stack: c0106ed3 00000000 bffffb50 40024214 00000016 ffffffff bffffb18
00000109

0000002b 0000002b 00000109 40021e46 00000023 00000246 bffffafc 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.

<1>Unable to handle kernel paging request at virtual address 01e8c358

printing eip:

01e8c358

*pde = 00000000

Oops: 0000

CPU: 1

EIP: 0010:[<01e8c358>] Not tainted

EFLAGS: 00010293

eax: 00000109 ebx: edbc0000 ecx: bffffb50 edx: 00000018

esi: 00000016 edi: ffffffff ebp: bffffb18 esp: edbc1fc0

ds: 0018 es: 0018 ss: 0018

Process ls (pid: 975, stackpage=edbc1000)

Stack: c0106ed3 00000000 bffffb50 40024214 00000016 ffffffff bffffb18
00000109

0000002b 0000002b 00000109 40021e46 00000023 00000246 bffffafc 0000002b

Call Trace: [<c0106ed3>]

Code: Bad EIP value.


Todd Elsbernd
Computer Services Specialist
The University of Georgia
4-424 Forest Resources Building
Athens, GA 30602
telsbernd@sref.info
(706)-542-1078

