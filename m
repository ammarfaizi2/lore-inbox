Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRBDWZV>; Sun, 4 Feb 2001 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRBDWZL>; Sun, 4 Feb 2001 17:25:11 -0500
Received: from smtp.sunflower.com ([24.124.0.137]:33298 "EHLO
	smtp.sunflower.com") by vger.kernel.org with ESMTP
	id <S130777AbRBDWZB>; Sun, 4 Feb 2001 17:25:01 -0500
From: "Steve 'Denali' McKnelly" <denali@sunflower.com>
To: <linux-kernel@vger.kernel.org>
Subject: Motherboard Misdetect
Date: Sun, 4 Feb 2001 16:24:55 -0600
Message-ID: <PGEDKPCOHCLFJBPJPLNMAEHPCBAA.denali@sunflower.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy everyone,

	I own a M-Technology M-668DS motherboard.  Linux 2.4.1
	identifies my board as a Soyo SY-6KD.  They're not really
	the same board, and they each have features the other doesn't
	have. (The 668DS has onboard SCSI, where as the 6KD doesn't.
	The 6KD can be upgraded for I20 compatibiliy, whereas the 668DS
	can't.)

	Is this going to be a problem for me?  I will admit to knowing
	nothing about kernel programming, but I'm willing to help
	in any way.  Below is a copy of my dmesg output.

Thanks,
Steve

[root@shadowforge denali]: dmesg
achine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1463.01 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
activating NMI Watchdog ... done.
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
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
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 001 01  1    1    0   1   0    1    1    A1
 11 001 01  1    1    0   1   0    1    1    A9
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 300.6844 MHz.
..... host bus clock speed is 66.8185 MHz.
cpu: 0, clocks: 668185, slice: 334092
CPU0<T0:668176,T1:334080,D:4,S:334092,C:668185>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdba1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 16
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
34 structures occupying 820 bytes.
DMI table at 0x000F748B.
BIOS Vendor: American Megatrends, Inc.
BIOS Version: 0627
BIOS Release: 07/15/95
Board Vendor: SOYO Computer Inc..
Board Name: SY-6KD.
Board Version: 0.00.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 211893kB/80821kB, 640 slots per queue
loop: enabling 8 loop devices
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/11/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST318416N         Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST32550N          Rev: 0021
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: EXABYTE   Model: EXB-8200          Rev: 2618
  Type:   Sequential-Access                  ANSI SCSI revision: 01
  Vendor: TEXEL     Model: CD-ROM DM-XX28    Rev: 3.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
SCSI device sdb: 4194058 512-byte hdwr sectors (2147 MB)
 sdb: sdb1
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xdc00, IRQ 19
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 128480k swap-space (priority -1)
Detected scsi tape st0 at scsi0, channel 0, id 2, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
NET4: Linux IPX 0.43 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21140 Tulip rev 34 at 0xda00, 00:00:E8:50:08:8C, IRQ 17.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
[root@shadowforge denali]:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
