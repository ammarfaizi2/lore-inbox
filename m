Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBRGSF>; Sun, 18 Feb 2001 01:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRBRGR4>; Sun, 18 Feb 2001 01:17:56 -0500
Received: from immtapop3.bellatlantic.net ([199.45.40.140]:18585 "EHLO
	immtapop3.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S129175AbRBRGRk>; Sun, 18 Feb 2001 01:17:40 -0500
Message-ID: <3A8F6903.7D147CF@neuronet.pitt.edu>
Date: Sun, 18 Feb 2001 01:17:39 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LK <linux-kernel@vger.kernel.org>
Subject: Boot fails in Avanti AS 400 4/233, include boot log and sysrq dump
Content-Type: multipart/mixed;
 boundary="------------E0FC2423879F170DEF757757"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E0FC2423879F170DEF757757
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I compiled both kernel versions 2.4.2-pre4 and 2.4.1-ac18 on my Alpha
Station 400 4/233 and both stop when they are start init. I include the
boot log and sysrq dumps for 2.4.1-ac18, I passed init=/bin/bash as
kernel parameter. I'd appreciate any help.

Thanks.
-- 
     Rafael
--------------E0FC2423879F170DEF757757
Content-Type: text/plain; charset=us-ascii;
 name="bootmsg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmsg.txt"

Linux version 2.4.1-ac18 (root@alfa) (gcc version 2.95.2 19991024 (release)) #1 Sat Feb 17 19:19:561
Booting GENERIC on Avanti using machine vector Avanti from MILO
Command line: bootdevice=sda1 bootfile=2.4 root=/dev/sda3 debug init=/bin/bash console=ttyS0,19200n 
memcluster 0, usage 2, start        0, end        2
memcluster 1, usage 0, start        2, end      256
memcluster 2, usage 2, start      256, end      328
memcluster 3, usage 0, start      328, end     2065
memcluster 4, usage 2, start     2065, end     2066
memcluster 5, usage 0, start     2066, end     2068
memcluster 6, usage 2, start     2068, end     2069
memcluster 7, usage 0, start     2069, end    16384
freeing pages 2:256
freeing pages 328:384
freeing pages 776:2065
freeing pages 2066:2068
freeing pages 2069:16384
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: bootdevice=sda1 bootfile=2.4 root=/dev/sda3 debug init=/bin/bash console=ttyS0 
Using epoch = 1980
Console: colour VGA+ 80x25
Calibrating delay loop... 460.92 BogoMIPS
Memory: 125112k/131072k available (1764k kernel code, 5352k reserved, 524k data, 368k init)
Dentry-cache hash table entries: 16384 (order: 5, 262144 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 16384 (order: 4, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 131072 bytes)
POSIX conformance testing by UNIFIX
  got res[8000:80ff] for resource 0 of Symbios Logic Inc. (formerly NCR) 53c810
  got res[8400:84ff] for resource 0 of Realtek Semiconductor Co., Ltd. RTL-8139
  got res[2800000:2ffffff] for resource 1 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[2200000:220ffff] for resource 6 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[2210000:2213fff] for resource 0 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[2214000:22140ff] for resource 1 of Symbios Logic Inc. (formerly NCR) 53c810
  got res[2215000:22150ff] for resource 1 of Realtek Semiconductor Co., Ltd. RTL-8139
PCI enable device: (Symbios Logic Inc. (formerly NCR) 53c810)
  cmd reg 0x47
PCI enable device: (Intel Corporation 82378IB [SIO ISA Bridge])
  cmd reg 0x7
PCI enable device: (Matrox Graphics, Inc. MGA 2064W [Millennium])
  cmd reg 0x87
PCI enable device: (Realtek Semiconductor Co., Ltd. RTL-8139)
  cmd reg 0x147
isapnp: Scanning for Pnp cards...
isapnp: Card 'ESS ES1869 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 82858kB/27619kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: ARC console epoch (1980) detected
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
ncr53c8xx: at PCI bus 0, device 6, function 0
ncr53c8xx: 53c810 detected 
ncr53c810-0: rev 0x1 on pci bus 0 device 6 function 0 irq 11
ncr53c810-0: ID 7, Fast-10, Parity Checking
ncr53c810-0: restart (scsi reset).
scsi0 : ncr53c8xx - version 3.3b
ncr53c810-0-<0,0>: wide msgin: 1-2-3-1.
ncr53c810-0-<0,0>: wide: wide=0 chg=1.
ncr53c810-0-<0,0>: wide msgout: 8.
ncr53c810-0-<0,0>: sync msgin: 1-3-1-19-1e.
ncr53c810-0-<0,0>: sync: per=25 scntl3=0x10 ofs=8 fak=0 chg=1.
ncr53c810-0-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
ncr53c810-0-<0,0>: sync msgout: 1-3-1-19-8.
  Vendor: TANDEM    Model: 4255-1            Rev: 1011
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: NEC       Model: CD-ROM DRIVE:461  Rev: 2.3d
  Type:   CD-ROM                             ANSI SCSI revision: 02
ncr53c810-0-<0,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 4404489 512-byte hdwr sectors (2255 MB)
Partition check:
 sda: sda1 sda2 sda3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
ncr53c810-0-<4,0>: sync_msgout: 1-3-1-19-8.
ncr53c810-0-<4,0>: sync msgin: 1-3-1-1f-8.
ncr53c810-0-<4,0>: sync: per=31 scntl3=0x10 ofs=8 fak=1 chg=0.
ncr53c810-0-<4,*>: FAST-10 SCSI 8.0 MB/s (125 ns, offset 8)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack (512 buckets, 4096 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 368k freed

SysRq: Show Regs

ps: 0000 pc: [<fffffc0000312664>]
rp: [<fffffc0000312680>] sp: fffffc0000533fd0
 r0: 0000000000000000  r1: 0000000000000000  r2: fffffc00005ea0e0  r3: 0000000000000001
 r4: 000000000001474d  r5: fffffc00005868d0  r6: fffffffffffffc18  r7: fffffc00002e60c0
 r8: fffffc0000530000 r16: 0000000000000019 r17: 0000000000000032 r18: fffffc000035f5f8
r19: fffffc0000554080 r20: fffffc00005868d0 r21: fffffc0000530000 r22: 0000000000000000
r23: 00000000002e4000 r24: 000002f800000000 r25: 000006f800000000 r26: fffffc0000312680
r27: fffffc0000329180 r28: fffffc00005b7778 r29: fffffc00005af7f8 hae: 0000000000000000

SysRq: Show State

                                 free                        sibling
  task                 PC        stack   pid father child younger older
bash      D fffffc000031a718     0     1      0     6  (NOTLB)        
keventd   S fffffc000033f3c8     0     2      1        (L-TLB)       3
kswapd    S fffffc000032a520     0     3      1        (L-TLB)       4     2
kreclaimd  S fffffc000032ad04  7016     4      1        (L-TLB)       5     3
bdflush   S fffffc000035f4b0 14168     5      1        (L-TLB)       6     4
kupdate   S fffffc000032a520 14168     6      1        (L-TLB)             5

SysRq: Show Memory

Mem-info:
Free pages:      123592kB (     0kB HighMem)
( Active: 30, inactive_dirty: 0, inactive_clean: 0, free: 15449 (255 510 765) )
1*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 3*512kB 3*1024kB 2*2048kB 28*4096kB = 123592kB)
= 0kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
16384 pages of RAM
15555 free pages
699 reserved pages
18 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:       96kB




--------------E0FC2423879F170DEF757757--

