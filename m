Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSKYSfC>; Mon, 25 Nov 2002 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSKYSfB>; Mon, 25 Nov 2002 13:35:01 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:12734 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S264628AbSKYSd5>; Mon, 25 Nov 2002 13:33:57 -0500
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Organization: INFN
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: e7500 and IRQ assignment
Date: Mon, 25 Nov 2002 19:41:53 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com> <Pine.LNX.4.50.0211251038280.1462-100000@montezuma.mastecende.com> <200211251934.47959.gabrielli@roma2.infn.it>
In-Reply-To: <200211251934.47959.gabrielli@roma2.infn.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x7m49471TXgHtKG"
Message-Id: <200211251941.53206.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_x7m49471TXgHtKG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 19:34, lunedì 25 novembre 2002, Emiliano Gabrielli wrote:

> I have downloaded the prepatched kernel from www.aslab.com (linux-2.4.19-1)
> (they affirm their servers use 7500) and even in this case no change
> appened...
>
> I have HT enabled in the BIOS; SMP and IO-APIC are compiled in the
> kernel...
>
> but I still receive some buggy messages in dmesg (see attachement), btw my
> full custom device has IRQ routed to 0 (see my lspci)
>
> If anybody as some IDEA ... I will happy ;P
>
> best regards,

sorry, I have forgotten to attach files ... 

my apologises

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

--Boundary-00=_x7m49471TXgHtKG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci"

03:0c.0 Class ff00: Altera Corporation: Unknown device 0005 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at fc200000 (32-bit, non-prefetchable) [size=1K]


--Boundary-00=_x7m49471TXgHtKG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

U:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Total of 2 processors activated (7969.17 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 6-0, 6-1, 6-2, 6-3, 6-4, 6-5, 6-6, 6-7, 6-8, 6-9, 6-10, 6-11, 6-12, 6-13, 6-14, 6-15, 6-16, 6-17, 6-18, 6-19, 6-20, 6-21, 6-22, 6-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
number of IO-APIC #5 registers: 24.
number of IO-APIC #6 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02008000
.......    : physical APIC id: 02
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    79
 0d 003 03  0    0    0   0   0    1    1    81
 0e 003 03  0    0    0   0   0    1    1    89
 0f 003 03  0    0    0   0   0    1    1    91
 10 003 03  1    1    0   1   0    1    1    99
 11 003 03  1    1    0   1   0    1    1    A1
 12 003 03  1    1    0   1   0    1    1    A9
 13 003 03  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 05000000
.......     : arbitration: 05
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #6......
.... register #00: 06000000
.......    : physical APIC id: 06
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 06000000
.......     : arbitration: 06
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
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
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1996.5784 MHz.
..... host bus clock speed is 99.8288 MHz.
cpu: 0, clocks: 998288, slice: 332762
CPU0<T0:998288,T1:665520,D:6,S:332762,C:998288>
cpu: 1, clocks: 998288, slice: 332762
CPU1<T0:998288,T1:332752,D:12,S:332762,C:998288>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfd875, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 10 [IRQ]
PCI: Discovered primary peer bus 11 [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B7,I1,P0) -> 16
PCI->APIC IRQ transform: (B7,I2,P0) -> 17
PCI->APIC IRQ transform: (B7,I3,P0) -> 18
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: num_physpages = 65504
aio_setup: sizeof(struct page) = 48
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.8 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably buggy MP table.
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c040aa24, I/O limit 4095Mb (mask 0xffffffff)
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
Partition check:
 hda: [PTBL] [5005/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2358.400 MB/sec
   32regs    :  1432.800 MB/sec
   pIII_sse  :  2574.000 MB/sec
   pII_mmx   :  2343.600 MB/sec
   p5_mmx    :  2314.800 MB/sec
raid5: using function: pIII_sse (2574.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Adding Swap: 1052248k swap-space (priority -1)
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU1 no microcode found! (sig=f24, pflags=2)
microcode: CPU0 no microcode found! (sig=f24, pflags=2)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:12:1E:82, IRQ 17.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:30:48:12:24:99, IRQ 18.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).

--Boundary-00=_x7m49471TXgHtKG--

