Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272479AbTGaNqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272480AbTGaNqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:46:33 -0400
Received: from mx0.gmx.de ([213.165.64.100]:51864 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S272479AbTGaNoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:44:03 -0400
Date: Thu, 31 Jul 2003 15:44:01 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
MIME-Version: 1.0
References: <1059656582.16608.14.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: [2.4.22-pre9] Unexpected IO-APIC (works)...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <15312.1059659041@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Here is the information you requested; let me know if you need anything
further.

Thanks!

---

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178014
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0014
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... register #02: 02000000
.......     : arbitration: 02

> On Iau, 2003-07-31 at 11:24, Daniel Blueman wrote:
> 
> > ..TIMER: vector=0x31 pin1=2 pin2=0
> > testing the IO APIC.......................
> > 
> > An unexpected IO-APIC was found. If this kernel release is less than
> 
> I need to see the debug messages as well to do that. After you boot 
> do something like "dmesg >logfile" and it should contain those too

--- [ full boot logs ]

Linux version 2.4.22-pre9 (root@phlox) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r1, propolice)) #1 Thu Jul 31 10:22:32 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fbf0000 (usable)
 BIOS-e820: 000000003fbf0000 - 000000003fbf3000 (ACPI NVS)
 BIOS-e820: 000000003fbf3000 - 000000003fc00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5650
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 1
Kernel command line: root=/dev/hda1 console=ttyS0,115200
Initializing CPU#0
Detected 2004.569 MHz processor.
Calibrating delay loop... 3997.69 BogoMIPS
Memory: 905128k/917504k available (1276k kernel code, 11992k reserved, 321k
data, 260k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-3, 2-7, 2-9, 2-10, 2-11, 2-12, 2-15, 2-23 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178014
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0014
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 000 00  1    0    0   0   0    0    0    00
 04 001 01  0    0    0   0   0    1    1    41
 05 001 01  0    0    0   0   0    1    1    49
 06 001 01  0    0    0   0   0    1    1    51
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  0    0    0   0   0    1    1    59
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    61
 0e 001 01  0    0    0   0   0    1    1    69
 0f 000 00  1    0    0   0   0    0    0    00
 10 001 01  1    1    0   1   0    1    1    71
 11 001 01  1    1    0   1   0    1    1    79
 12 001 01  1    1    0   1   0    1    1    81
 13 001 01  1    1    0   1   0    1    1    89
 14 001 01  1    1    0   1   0    1    1    91
 15 001 01  1    1    0   1   0    1    1    99
 16 001 01  1    1    0   1   0    1    1    A1
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
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
..... CPU clock speed is 2004.6589 MHz.
..... host bus clock speed is 100.2328 MHz.
cpu: 0, clocks: 1002328, slice: 501164
CPU0<T0:1002320,T1:501152,D:4,S:501164,C:1002328>
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I3,P0) -> 20
PCI->APIC IRQ transform: (B0,I3,P1) -> 21
PCI->APIC IRQ transform: (B0,I3,P2) -> 22
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xf8800000, 00:30:1b:ab:9e:71, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
hda: Maxtor 6Y160P0, ATA DISK drive
blk: queue c02ffb60, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63,
UDMA(133)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,1)) ...
for (ide0(3,1))
ide0(3,1):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 260k freed
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,2)) ...
for (ide0(3,2))
ide0(3,2):Using r5 hash to sort names
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability
41e1.

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

