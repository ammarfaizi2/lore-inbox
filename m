Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUDVUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUDVUzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUDVUzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:55:21 -0400
Received: from mail-ash.bigfish.com ([206.16.192.253]:60077 "EHLO
	mail45-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S264672AbUDVUyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:54:21 -0400
Message-ID: <408830F2.1040708@lehman.com>
Date: Thu, 22 Apr 2004 16:54:10 -0400
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Len Brown" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z
 aka Newisys 2100
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
 <1082653547.16336.335.camel@dhcppc4> <408820D7.10400@lehman.com>
 <1082666116.16336.391.camel@dhcppc4>
In-Reply-To: <1082666116.16336.391.camel@dhcppc4>
X-WSS-ID: 6C96EF7E1350047-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

Another data point.  I am able to boot the fedora x86_64 kernel as well, 
if that helps any.  The output is below.

Thanks,
Shantanu

ok
Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
debug)
Linux version 2.4.22-1.2174.nptlsmp (root@doppler) (gcc version 3.2.3 
20030422 (Red Hat Linux 3.2.3-6)) #1 SMP Thu Feb 19 11:08:12 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-d000
ACPI: have wakeup address 0x10000002000
Scan SMP from 0000010000000000 for 1024 bytes.
Scan SMP from 000001000009fc00 for 1024 bytes.
Scan SMP from 00000100000f0000 for 65536 bytes.
found SMP MP-table at 00000000000f7d60
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009b000 reserved twice.
hm, page 0009c000 reserved twice.
On node 0 totalpages: 524144
zone(0): 4096 pages.
zone(1): 520048 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 PTLTD                                     ) @ 
0x00000000000f7d00
ACPI: XSDT (v001 PTLTD       XSDT   0x06040000  LTP 0x00000000) @ 
0x000000007ff7108b
ACPI: FADT (v003 NWS    1U2P     0x06040000 PTEC 0x000f4240) @ 
0x000000007ff72e46
ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @ 
0x000000007ff72f3a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 
0x000000007ff72fb0
ACPI: DSDT (v001    NWS   1U2P   0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
ACPI: Parsing Local APIC info in MADT
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: IOAPIC (id[0x03] address[0xfd000000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfd000000, IRQ 24-27
ACPI: IOAPIC (id[0x04] address[0xfd001000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfd001000, IRQ 28-31
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] 
trigger[0x1])
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Kernel command line: ro root=LABEL=/ console=ttyS0 console=tty0 debug
Initializing CPU#0
time.c: Detected 1.193182 MHz PIT timer.
time.c: Detected 1992.400 MHz TSC timer.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 2045280k/2096576k available (1859k kernel code, 50888k reserved, 
1603k data, 160k init)
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 9, 2097152 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 8, 1048576 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#0
POSIX conformance testing by UNIFIX
mtrr: v2.02 (20020716))
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 5119.17 usecs.
task migration cache decay timeout: 10 msecs.
Booting processor 1/1 rip 6000 page 000001007ff66000
Initializing CPU#1
Calibrating delay loop... 3971.48 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 
way)
CPU: L2 Cache: 1024K (64 bytes/line/1 way)
Machine Check Reporting enabled for CPU#1
CPU1: AMD Engineering Sample 00 stepping 08
Total of 2 processors activated (7942.96 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
Using local APIC timer interrupts.
Detected 12.452 MHz APIC timer.
cpu: 0, clocks: 1992399, slice: 664133
CPU0<T0:1992384,T1:1328240,D:11,S:664133,C:1992399>
cpu: 1, clocks: 1992399, slice: 664133
CPU1<T0:1992384,T1:664112,D:6,S:664133,C:1992399>
checking TSC synchronization across CPUs: passed.
testing NMI watchdog ... OK.
time.c: Using PIT/TSC based timekeeping.
Starting migration thread for cpu 0
smp_num_cpus: 2.
Starting migration thread for cpu 1
ACPI: Subsystem revision 20031002
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.THOR._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z000._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z002._PRT]
PCI: Using configuration type 1
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16) Mode:1 Active:1
00:01:00[A] -> 2-16 -> vector 0xa9 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17) Mode:1 Active:1
00:01:00[B] -> 2-17 -> vector 0xb1 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18) Mode:1 Active:1
00:01:00[C] -> 2-18 -> vector 0xb9 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19) Mode:1 Active:1
00:01:00[D] -> 2-19 -> vector 0xc1 -> IRQ 19
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xc9 -> IRQ 25) Mode:1 Active:1
00:02:02[A] -> 3-1 -> vector 0xc9 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xd1 -> IRQ 26) Mode:1 Active:1
00:02:03[A] -> 3-2 -> vector 0xd1 -> IRQ 26
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xd9 -> IRQ 27) Mode:1 Active:1
00:02:04[A] -> 3-3 -> vector 0xd9 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xe1 -> IRQ 24) Mode:1 Active:1
00:02:05[A] -> 3-0 -> vector 0xe1 -> IRQ 24
Pin 3-1 already programmed
Pin 3-2 already programmed
Pin 3-3 already programmed
IOAPIC[2]: Set PCI routing entry (4-0 -> 0xe9 -> IRQ 28) Mode:1 Active:1
00:03:01[A] -> 4-0 -> vector 0xe9 -> IRQ 28
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x32 -> IRQ 29) Mode:1 Active:1
00:03:01[B] -> 4-1 -> vector 0x32 -> IRQ 29
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x3a -> IRQ 30) Mode:1 Active:1
00:03:01[C] -> 4-2 -> vector 0x3a -> IRQ 30
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x42 -> IRQ 31) Mode:1 Active:1
00:03:01[D] -> 4-3 -> vector 0x42 -> IRQ 31
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: no supported devices found.
PCI-DMA: Disabling IOMMU.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
IA32 emulation $Id: sys_ia32.c,v 1.62 2003/09/22 04:25:53 ak Exp $
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) UDMA100 
controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
Fusion MPT base driver 2.05.05+
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: 1 MPT adapter found, 1 installed.
Fusion MPT SCSI Host driver 2.05.05+
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=27
blk: queue 0000010037f1c030, no I/O memory limit
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue 0000010003dc9e30, no I/O memory limit
mptscsih: ioc0: scsi0: Id=1 Lun=0: Queue depth=31
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 160k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xffffff000001a000, IRQ 19
usb-ohci.c: usb-01:00.0, Advanced Micro Devices [AMD] AMD-8111 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
usb-ohci.c: USB OHCI at membase 0xffffff000001c000, IRQ 19
usb-ohci.c: usb-01:00.1, Advanced Micro Devices [AMD] AMD-8111 USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
Adding Swap: 2048276k swap-space (priority -1)
Adding Swap: 2048248k swap-space (priority -2)
Adding Swap: 2048248k swap-space (priority -3)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 424 bytes per conntrack
tg3.c:v2.2 (August 24, 2003)
divert: allocating divert_blk for eth0
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] 
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:12:2c
divert: allocating divert_blk for eth1
eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] 
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:14:20
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]



------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the
designated recipient(s) named above.  If you are not the intended recipient of
this message you are hereby notified that any review, dissemination,
distribution or copying of this message is strictly prohibited.  This
communication is for information purposes only and should not be regarded as
an offer to sell or as a solicitation of an offer to buy any financial
product, an official confirmation of any transaction, or as an official
statement of Lehman Brothers.  Email transmission cannot be guaranteed to be
secure or error-free.  Therefore, we do not represent that this information is
complete or accurate and it should not be relied upon as such.  All
information is subject to change without notice.

