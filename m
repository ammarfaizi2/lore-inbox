Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRBIKpU>; Fri, 9 Feb 2001 05:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130102AbRBIKpL>; Fri, 9 Feb 2001 05:45:11 -0500
Received: from brooks.civeng.adelaide.edu.au ([129.127.78.254]:20869 "EHLO
	brooks.civeng.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129837AbRBIKpE>; Fri, 9 Feb 2001 05:45:04 -0500
From: "Stephen Carr" <sgcarr@civeng.adelaide.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Feb 2001 21:13:44 +1030
Subject: Panic from 2.4.2-pre2 kernel - output #1
Reply-to: sgcarr@civeng.adelaide.edu.au
Message-ID: <3A845D88.31616.2305D94@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All

As requested here is the output from a panic while doing a backup -
 At the time of the panic the system was not doing a network 
backup but the host system.

I am going to attempt a few more backups as the panics tend to 
vary. Also I have had the system lock up hard with no panic 
message.


This machine has had uptimes of 100+ days with the 2.2.16 kernel -
 I wonder if I have a memory fault (I have reseated the ram and I/O 
cards) ?

Thanks
Stephen Carr

------------------------

LILO boot:
LILO Loading Linux................
Linux version 2.4.2-pre2 (root@elizabeth) (gcc version egcs-2.91.66 
19990314/Lin
ux (egcs-1.1.2 release)) #13 SMP Fri Feb 9 20:44:29 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000ff00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5570
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 
0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 13
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 
console=ttyS0,9600 tty0
Initializing CPU#0
Detected 501.149 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 255200k/262144k available (1234k kernel code, 6556k 
reserved, 439k data,
 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor 
= 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor 
= 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 02
per-CPU timeslice cutoff: 1462.08 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 0) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 999.42 BogoMIPS
Stack at about c15fffbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor 
= 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 02
CPU has booted.
Before bogomips.
Total of 2 processors activated (1998.84 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 501.1172 MHz.
..... host bus clock speed is 100.2228 MHz.
cpu: 0, clocks: 1002228, slice: 334076
CPU0<T0:1002224,T1:668144,D:4,S:334076,C:1002228>
cpu: 1, clocks: 1002228, slice: 334076
CPU1<T0:1002224,T1:334064,D:8,S:334076,C:1002228>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb290, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
34 structures occupying 866 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 02/12/99
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169506kB/56502kB, 512 slots per 
queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, 
hdd:DMA
hdb: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS 
SHARE_IRQ SERIAL_PCI ena
bled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at 
PCI 0/13/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 
5.2.1/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: WDIGTL    Model: WDE9180 ULTRA2    Rev: 1.30
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 32.
  Vendor: HP        Model: C1537A            Rev: L907
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 6, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17873040 512-byte hdwr sectors (9151 MB)
Partition check:
 sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Warning: unable to open an initial console.
Adding Swap: 265064k swap-space (priority -1)
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.4.21
Copyright (c) 2001 Intel Corporation
Using specified value of 1024 TxDescriptors
Using specified value of 1024 RxDescriptors

eth0: Intel(R) PRO/100+ Management Adapter
  Mem:0xee101000  IRQ:10  Speed:100 Mbps  Dx:Full
  Hardware receive checksums enabled


Welcome to Linux 2.4.2-pre2.

elizabeth login: sgcarr
Password:
Linux 2.4.2-pre2.
Last login: Fri Feb  9 20:43:15 +1030 2001 on tty2.
No mail.
elizabeth.[~] sudo -s
Password:
elizabeth.[~] /usr/local/scripts/level0l
st0: Block limits 1 - 16777215 bytes.
Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c031d0c0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c031d0c0>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 000000ff
esi: c1570600   edi: c1570600   ebp: 00000000   esp: c02a5ea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: c01c3315 c1570600 ffffff8b 00000076 00000001 00000001 
00000001 c1570600
       00000078 c02a5f34 c031d0c4 c031d0c8 00000010 c15e8c78 
00000078 00000000
       c01e62f0 c1570600 00000078 00000001 c1570600 00000000 
00000bb8 c01c265e
Call Trace: [<c01c3315>] [<c01e62f0>] [<c01c265e>] 
[<c01d3ce0>] [<c01c8724>] [<c
01d3fa1>] [<c010a769>]
       [<c010a95e>] [<c01071c0>] [<c01071c0>] [<c01090b8>] 
[<c01071c0>] [<c01071
c0>] [<c0100018>] [<c01071ec>]
       [<c010724e>] [<c0105000>] [<c01001d0>]

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


-----------------
Computing Officer
Department of Civil and Environmental Engineering
University of Adelaide
Adelaide, South Australia,
Australia 5005
Phone +618 8303-4313
Fax   +618 8303-4359
Email sgcarr@civeng.adelaide.edu.au
-----------------------------------------------------------
This email message is intended only for the addressee(s)
and contains information which may be confidential and/or
copyright.  If you are not the intended recipient please
do not read, save, forward, disclose, or copy the contents
of this email. If this email has been sent to you in error,
please notify the sender by reply email and delete this
email and any copies or links to this email completely and
immediately from your system.  No representation is made
that this email is free of viruses.  Virus scanning is
recommended and is the responsibility of the recipient.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
