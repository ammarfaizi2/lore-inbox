Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319415AbSH2X5t>; Thu, 29 Aug 2002 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319462AbSH2X5s>; Thu, 29 Aug 2002 19:57:48 -0400
Received: from web20702.mail.yahoo.com ([216.136.226.175]:62052 "HELO
	web20702.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319415AbSH2X5n>; Thu, 29 Aug 2002 19:57:43 -0400
Message-ID: <20020830000206.32051.qmail@web20702.mail.yahoo.com>
Date: Thu, 29 Aug 2002 17:02:06 -0700 (PDT)
From: abhishek Sinha <aby_sinha@yahoo.com>
Subject: AMD 768 USB Controller
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-348385312-1030665726=:30784"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-348385312-1030665726=:30784
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi list members

I have a Tyan 2468 motherboard and the lspci -v output
on the machine says something like this
02:00.0 USB Controller: Advanced Micro Devices [AMD]
AMD-768 [Opus] USB (rev 07)


I looked at some of the older posting on the net and
found out that AMD 765 USB controller was
blacklisted.Now i am trying to get a USB Segate Tape
drive to work which works on other motherboards.When i
tried to load the UHCI driver, the machine crashes
saying 

Interrupt handler killed.
and the error seems to come from uhci.c
i tried for look for any oops messages in
/var/log/messages so that i can run it through
ksymoops and send the output
I think this is due to the controller since the tape
drive seems to work on all other machines (non tyan).
I am using 2.4.19 kernel

Is this controller supported or do i have to try a new
kernel for this.

I am attaching the dmesg file for your kind perusal.

Please cc me the replies

Thanks for your help

Abhishek



__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
--0-348385312-1030665726=:30784
Content-Type: text/plain; name="dmesg-usb.txt"
Content-Description: dmesg-usb.txt
Content-Disposition: inline; filename="dmesg-usb.txt"

0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fef6000 (ACPI data)
 BIOS-e820: 000000003fef6000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
found SMP MP-table at 000f7180
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: ro root=/dev/sda2
Initializing CPU#0
Detected 1400.068 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2791.83 BogoMIPS
Memory: 1029996k/1048064k available (1224k kernel code, 17616k reserved, 839k data, 304k init, 130496k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 1600+ stepping 02
per-CPU timeslice cutoff: 731.32 usecs.
task migration cache decay timeout: 10 msecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2798.38 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (5590.22 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  0    0    0   0   0    1    1    A9
 11 003 03  0    0    0   0   0    1    1    B1
 12 003 03  0    0    0   0   0    1    1    B9
 13 003 03  0    0    0   0   0    1    1    C1
 14 003 03  0    0    0   0   0    1    1    C9
 15 003 03  1    1    0   1   0    1    1    D1
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1400.0195 MHz.
..... host bus clock speed is 266.6704 MHz.
cpu: 0, clocks: 2666704, slice: 888901
CPU0<T0:2666704,T1:1777792,D:11,S:888901,C:2666704>
cpu: 1, clocks: 2666704, slice: 888901
CPU1<T0:2666704,T1:888896,D:6,S:888901,C:2666704>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router default [1022/7443] at 00:07.3
BIOS failed to enable PCI standards compliance, fixing this error.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 179k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x3, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x8
SCSIPHASE = 0x0
STACK == 0x3, 0x108, 0x160, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xee, l 245, t 0xff) 2(c 0x0, s 0xbd, l 255, t 0xff) 3(c 0x0, s 0xdf, l 253, t 0xff) 4(c 0x0, s 0x0, l 0, t 0xff) 5(c 0x0, s 0xf6, l 255, t 0xff) 6(c 0x0, s 0xfe, l 255, t 0xff) 7(c 0x0, s 0xdf, l 173, t 0xff) 8(c 0x0, s 0xff, l 243, t 0xff) 9(c 0x0, s 0x7f, l 253, t 0xff) 10(c 0x0, s 0xf7, l 255, t 0xff) 11(c 0x0, s 0xfe, l 223, t 0xff) 12(c 0x0, s 0xbf, l 251, t 0xff) 13(c 0x0, s 0xff, l 22, t 0xff) 14(c 0x0, s 0xff, l 251, t 0xff) 15(c 0x0, s 0xf9, l 253, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0x7e, l 191, t 0xff) 18(c 0x0, s 0xff, l 223, t 0xff) 19(c 0x0, s 0xfd, l 255, t 0xff) 20(c 0x0, s 0x7f, l 239, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xb7, l 255, t 0xff) 23(c 0x0, s 0xeb, l 183, t 0xff) 24(c 0x0, s 0xfd, l 254, t 0xff) 25(c 0x0, s 0xef, l 253, t 0xff) 26(c 0x0, s 0xde, l 255, t 0xff) 27(c 0x0, s 0xff, l 191, t 0xff) 28(c 0x0, s 0x6e, l 249, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 239, t 0xff) 31(c 0x0, s 0xff, l 245, t 0xff) 
Pending list: 
Kernel Free SCB list: 3 1 0 
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x168
ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0xa0, SCSISIGI = 0xb6, SXFRCTL0 = 0x88
SSTAT0 = 0x2, SSTAT1 = 0x1
SCSIPHASE = 0x4
STACK == 0x175, 0x160, 0x0, 0xe7
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0x2) 1(c 0x0, s 0xee, l 245, t 0xff) 2(c 0x0, s 0xbd, l 255, t 0xff) 3(c 0x0, s 0xdf, l 253, t 0xff) 4(c 0x0, s 0x0, l 0, t 0xff) 5(c 0x0, s 0xf6, l 255, t 0xff) 6(c 0x0, s 0xfe, l 255, t 0xff) 7(c 0x0, s 0xdf, l 173, t 0xff) 8(c 0x0, s 0xff, l 243, t 0xff) 9(c 0x0, s 0x7f, l 253, t 0xff) 10(c 0x0, s 0xf7, l 255, t 0xff) 11(c 0x0, s 0xfe, l 223, t 0xff) 12(c 0x0, s 0xbf, l 251, t 0xff) 13(c 0x0, s 0xff, l 22, t 0xff) 14(c 0x0, s 0xff, l 251, t 0xff) 15(c 0x0, s 0xf9, l 253, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0x7e, l 191, t 0xff) 18(c 0x0, s 0xff, l 223, t 0xff) 19(c 0x0, s 0xfd, l 255, t 0xff) 20(c 0x0, s 0x7f, l 239, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xb7, l 255, t 0xff) 23(c 0x0, s 0xeb, l 183, t 0xff) 24(c 0x0, s 0xfd, l 254, t 0xff) 25(c 0x0, s 0xef, l 253, t 0xff) 26(c 0x0, s 0xde, l 255, t 0xff) 27(c 0x0, s 0xff, l 191, t 0xff) 28(c 0x0, s 0x6e, l 249, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 239, t 0xff) 31(c 0x0, s 0xff, l 245, t 0xff) 
Pending list: 2(c 0x40, s 0x7, l 0)
Kernel Free SCB list: 1 0 
Untagged Q(0): 2 
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:0:0): Abort Message Sent
(scsi0:A:0:0): SCB 2 - Abort Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
scsi0:A:3:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 71722776 512-byte hdwr sectors (36722 MB)
 sdb: sdb1
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 71722776 512-byte hdwr sectors (36722 MB)
 sdc: sdc1
(scsi0:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdd: 71722776 512-byte hdwr sectors (36722 MB)
 sdd: sdd1
Freeing unused kernel memory: 304k freed
Adding Swap: 1028120k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf88ed000, IRQ 10
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [??] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_conntrack (8188 buckets, 65504 max)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:08.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x2400. Vers LK1.1.16
02:09.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0x2480. Vers LK1.1.16

--0-348385312-1030665726=:30784--
