Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDVq5>; Mon, 4 Dec 2000 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLDVqs>; Mon, 4 Dec 2000 16:46:48 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:16389
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129183AbQLDVqm>; Mon, 4 Dec 2000 16:46:42 -0500
Date: Mon, 4 Dec 2000 16:26:42 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre4 boot failure (better than pre3 and lower)
Message-ID: <20001204162642.A5553@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii

PCI patches that were added between pre3 and pre4 allow me to boot the
kernel on my noritake alpha.  Once it boots, however, it oops's in the
swapper.  I've tried a few times in the past to use ksymoops on oops's on
the alpha arch, but it doesn't appear to work.  (I'm using the ksymoops
that's part of the debian potato dist)

I have attached the boot log.

Keep my name in the CC

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=240t12p4-boot

Linux version 2.4.0-test12-pre4 (wakko@kakarot) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #2 Mon Dec 4 09:07:20 EST 2000
Booting on Noritake using machine vector Noritake from SRM
Command line: root=/dev/sda1 ro single console=ttyS0
memcluster 0, usage 1, start        0, end      171
memcluster 1, usage 0, start      171, end    20403
memcluster 2, usage 1, start    20403, end    20480
freeing pages 171:384
freeing pages 625:20403
On node 0 totalpages: 20480
zone(0): 20480 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 ro single console=ttyS0
Using epoch = 1900
Console: colour VGA+ 80x25
Calibrating delay loop... 525.34 BogoMIPS
Memory: 157168k/163224k available (1114k kernel code, 4688k reserved, 241k data, 208k init)
Dentry-cache hash table entries: 32768 (order: 6, 524288 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
  got res[2800000:2ffffff] for resource 1 of 3DLabs Permedia II 2D+3D
  got res[3000000:37fffff] for resource 2 of 3DLabs Permedia II 2D+3D
  got res[2200000:221ffff] for resource 0 of 3DLabs Permedia II 2D+3D
  got res[2220000:222ffff] for resource 6 of 3DLabs Permedia II 2D+3D
  got res[9000:90ff] for resource 0 of Q Logic ISP1020
  got res[9400:947f] for resource 0 of Digital Equipment Corporation DECchip 21142/43
  got res[9480:94bf] for resource 0 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3800000:383ffff] for resource 6 of Digital Equipment Corporation DECchip 21142/43
  got res[3840000:384ffff] for resource 6 of Q Logic ISP1020
  got res[3850000:385ffff] for resource 6 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3860000:3860fff] for resource 1 of Q Logic ISP1020
  got res[3861000:386107f] for resource 1 of Digital Equipment Corporation DECchip 21142/43
PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21050
  IO window: 1000-9fff
  MEM window: 03800000-038fffff
PCI enable device: (Intel Corporation 82375EB)
  cmd reg 0x7
PCI enable device: (Digital Equipment Corporation DECchip 21050)
  cmd reg 0x107
PCI enable device: (3DLabs Permedia II 2D+3D)
  cmd reg 0x7
PCI enable device: (Q Logic ISP1020)
  cmd reg 0x47
PCI enable device: (Digital Equipment Corporation DECchip 21142/43)
  cmd reg 0x47
PCI enable device: (3Com Corporation 3c905 100BaseTX [Boomerang])
  cmd reg 0x47
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (2)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 00 irq 17 I/O base 0x9000
  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 25501-XXX  Rev: 2.54
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0
SCSI device sda: 4254819 512-byte hdwr sectors (2178 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5
SCSI device sdb: 4110480 512-byte hdwr sectors (2105 MB)
 sdb: unknown partition table
SCSI device sdc: 4110480 512-byte hdwr sectors (2105 MB)
 sdc: unknown partition table
SCSI device sdd: 4110480 512-byte hdwr sectors (2105 MB)
 sdd: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(53): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(54): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(56): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(57): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323658 323600 

--n8g4imXOkfNTN/H1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
