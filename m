Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTGBAq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTGBAq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:46:27 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:48107 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S264436AbTGBAp1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:45:27 -0400
Date: Wed, 2 Jul 2003 02:59:25 +0200
Message-ID: <3EE04F600002D6F2@mail-7.tiscali.it>
From: federicobriata@tiscali.it
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I've test this system [SPARCStation 20 MP (2 x SuperSPARC-11) ROM Rev. 2.22,
128 MB memory] with a lot of kernel (2.4.18, 2.4.19, 2.4.21). 
All the kernel image has the same Opps :(
This is a Opps with 2.4.21.

Messages of kernel when Oops:

Jul  1 17:57:21 sparc20 syslogd 1.4.1#10: restart.
Jul  1 17:57:22 sparc20 kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
Jul  1 17:57:22 sparc20 kernel: Inspecting /boot/System.map-2.4.21
Jul  1 17:57:23 sparc20 lpd[179]: restarted
Jul  1 17:57:23 sparc20 kernel: Loaded 11279 symbols from /boot/System.map-2.4.21.
Jul  1 17:57:23 sparc20 kernel: Symbols match kernel version 2.4.21.
Jul  1 17:57:23 sparc20 kernel: Loaded 6 symbols from 1 module.
Jul  1 17:57:23 sparc20 kernel: PROMLIB: Sun Boot Prom Version 3 Revision
2
Jul  1 17:57:23 sparc20 kernel: Linux version 2.4.21 (root@sparc20) (gcc
version 2.95.4 20011002 (Debian prerelease)) #1 SMP Tue Jul 1 14:24:20 CEST
2003
Jul  1 17:57:23 sparc20 kernel: ARCH: SUN4M
Jul  1 17:57:23 sparc20 kernel: TYPE: Sun4m SparcStation10/20
Jul  1 17:57:23 sparc20 kernel: Ethernet address: 8:0:20:7b:46:8
Jul  1 17:57:23 sparc20 kernel: Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek
(jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu
Jul  1 17:57:23 sparc20 kernel: 16202MB HIGHMEM available.
Jul  1 17:57:23 sparc20 kernel: On node 0 totalpages: 32008
Jul  1 17:57:23 sparc20 kernel: zone(0): 45056 pages.
Jul  1 17:57:23 sparc20 kernel: zone(1): 0 pages.
Jul  1 17:57:23 sparc20 kernel: zone(2): 48970 pages.
Jul  1 17:57:23 sparc20 kernel: Found CPU 0 <node=ffd6f150,mid=8>
Jul  1 17:57:23 sparc20 kernel: Found CPU 1 <node=ffd6f510,mid=10>
Jul  1 17:57:23 sparc20 kernel: Found 2 CPU prom device tree node(s).
Jul  1 17:57:23 sparc20 kernel: Power off control detected.
Jul  1 17:57:23 sparc20 kernel: Kernel command line: root=/dev/sdb5 ro
Jul  1 17:57:23 sparc20 kernel: Console: colour dummy device 80x25
Jul  1 17:57:23 sparc20 kernel: Calibrating delay loop... 74.75 BogoMIPS
Jul  1 17:57:23 sparc20 kernel: Memory: 120512k available (1472k kernel
code, 292k data, 132k init, 64808k highmem) [f0000000,16f4a000]
Jul  1 17:57:23 sparc20 kernel: Dentry cache hash table entries: 8192 (order:
4, 65536 bytes)
Jul  1 17:57:23 sparc20 kernel: Inode cache hash table entries: 4096 (order:
3, 32768 bytes)
Jul  1 17:57:23 sparc20 kernel: Mount cache hash table entries: 512 (order:
0, 4096 bytes)
Jul  1 17:57:23 sparc20 kernel: Buffer-cache hash table entries: 1024 (order:
0, 4096 bytes)
Jul  1 17:57:23 sparc20 kernel: Page-cache hash table entries: 16384 (order:
4, 65536 bytes)
Jul  1 17:57:23 sparc20 kernel: POSIX conformance testing by UNIFIX
Jul  1 17:57:23 sparc20 kernel: Entering SMP Mode...
Jul  1 17:57:23 sparc20 kernel: Starting CPU 1 at f01c70e4
Jul  1 17:57:23 sparc20 kernel: Calibrating delay loop... 74.95 BogoMIPS
Jul  1 17:57:23 sparc20 kernel: Total of 2 Processors activated (149.70
BogoMIPS).
Jul  1 17:57:23 sparc20 kernel: Waiting on wait_init_idle (map = 0x2)
Jul  1 17:57:23 sparc20 kernel: All processors have done init_idle
Jul  1 17:57:23 sparc20 kernel: IOMMU: impl 1 vers 3 page table at fafc0000
of size 262144 bytes
Jul  1 17:57:23 sparc20 kernel: sbus0: Clock 25.0 MHz
Jul  1 17:57:23 sparc20 kernel: dma0: Revision 2 
Jul  1 17:57:23 sparc20 kernel: dma1: Revision 2 
Jul  1 17:57:23 sparc20 kernel: Sparc Zilog8530 serial driver version 1.68.2.2
Jul  1 17:57:23 sparc20 kernel: Sun Mouse-Systems mouse driver version 1.00
Jul  1 17:57:23 sparc20 kernel: tty00 at 0xffede004 (irq = 44) is a Zilog8530
Jul  1 17:57:23 sparc20 kernel: tty01 at 0xffede000 (irq = 44) is a Zilog8530
Jul  1 17:57:23 sparc20 kernel: tty02 at 0xffedb004 (irq = 44) is a Zilog8530
Jul  1 17:57:23 sparc20 kernel: tty03 at 0xffedb000 (irq = 44) is a Zilog8530
Jul  1 17:57:23 sparc20 kernel: Sun TYPE 5 keyboard detected without keyclick
Jul  1 17:57:23 sparc20 kernel: Linux NET4.0 for Linux 2.4
Jul  1 17:57:23 sparc20 kernel: Based upon Swansea University Computer Society
NET3.039
Jul  1 17:57:23 sparc20 kernel: Initializing RT netlink socket
Jul  1 17:57:23 sparc20 kernel: Starting kswapd
Jul  1 17:57:23 sparc20 kernel: allocated 32 pages and 32 bhs reserved for
the highmem bounces
Jul  1 17:57:23 sparc20 kernel: ioremap: done with statics, switching to
malloc
Jul  1 17:57:23 sparc20 kernel: Console: switching to colour frame buffer
device 128x54
Jul  1 17:57:23 sparc20 kernel: fb0: cgsix at e.20000000 TEC Rev 4 CPU sparc
Rev b [TGX+]
Jul  1 17:57:23 sparc20 kernel: pty: 256 Unix98 ptys configured
Jul  1 17:57:23 sparc20 kernel: Floppy drive(s): fd0 is 1.44M
Jul  1 17:57:23 sparc20 kernel: FDC 0 is a National Semiconductor PC87306
Jul  1 17:57:23 sparc20 kernel: RAMDISK driver initialized: 16 RAM disks
of 4096K size 1024 blocksize
Jul  1 17:57:23 sparc20 kernel: sunlance.c:v2.01 08/Nov/01 Miguel de Icaza
(miguel@nuclecu.unam.mx)
Jul  1 17:57:23 sparc20 kernel: eth0: LANCE 08:00:20:7b:46:08 
Jul  1 17:57:23 sparc20 kernel: eth0: using auto-carrier-detection.
Jul  1 17:57:23 sparc20 kernel: SCSI subsystem driver Revision: 1.00
Jul  1 17:57:23 sparc20 kernel: esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC=25000
CCF=8 TOut 167 NCR53C9XF(espfast)
Jul  1 17:57:23 sparc20 kernel: ESP: Total of 1 ESP hosts found, 1 actually
in use.
Jul  1 17:57:23 sparc20 kernel: scsi0 : Sparc ESP100A-FAST
Jul  1 17:57:23 sparc20 kernel:   Vendor: UNISYS    Model: ST32550W    
     Rev: 2804
Jul  1 17:57:23 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:23 sparc20 kernel: esp0: hoping for msgout
Jul  1 17:57:23 sparc20 kernel: esp0: yieee, bytes_sent < 0!
Jul  1 17:57:23 sparc20 kernel: esp0: csz=0 ptr=f0007cf8 this_residual=0
Jul  1 17:57:23 sparc20 kernel: esp0: use_sg=0 ptr=f0007cf8 this_residual=0
Jul  1 17:57:23 sparc20 kernel: esp0: forcing async for target2
Jul  1 17:57:23 sparc20 kernel:   Vendor: HP        Model: 4.26 GB rev 0632
 Rev: 0632
Jul  1 17:57:23 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:23 sparc20 kernel:   Vendor: SEAGATE   Model: ST32550W    
     Rev: 5108
Jul  1 17:57:23 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:23 sparc20 kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS
   Rev: 1.11
Jul  1 17:57:23 sparc20 kernel:   Type:   CD-ROM                       
     ANSI SCSI revision: 02
Jul  1 17:57:23 sparc20 kernel:   Vendor: TOSHIBA   Model: XM-4101TASUNSLCD
 Rev: 1084
Jul  1 17:57:23 sparc20 kernel:   Type:   CD-ROM                       
     ANSI SCSI revision: 02
Jul  1 17:57:23 sparc20 kernel: Unable to handle kernel paging request in
mna handler <1> at virtual address 0f0ffa77
Jul  1 17:57:23 sparc20 kernel: current->(mm,active_mm)->context=ffffffff
Jul  1 17:57:23 sparc20 kernel: current->(mm,active_mm)->pgd=fc000000
Jul  1 17:57:23 sparc20 kernel:                                        
   \|/ ____ \|/
Jul  1 17:57:23 sparc20 kernel:                                        
   "@'/ ,. \`@"
Jul  1 17:57:23 sparc20 kernel:                                        
   /_| \__/ |_\
Jul  1 17:57:23 sparc20 kernel:                                        
      \__U_/
Jul  1 17:57:23 sparc20 kernel: 
Jul  1 17:57:23 sparc20 kernel: swapper(1): Oops
Jul  1 17:57:23 sparc20 kernel: PSR:404010c5 PC:f00d72b4 NPC:f00d72b8  Y:00000000
  not tainted
Jul  1 17:57:23 sparc20 kernel:  g0:570ff9ff g1:40801fe4  g2:00000000 g3:00000000
g4:f00d5aa4 g5:00005800 g6:f0006000 g7:00000000
Jul  1 17:57:23 sparc20 kernel:  o0:faf85800 o1:00000001  o2:00000007 o3:00000001
o4:00000000 o5:f01713e0 sp:f0007d00 o7:f00d72ac
Jul  1 17:57:23 sparc20 kernel:  l0:170ff9ff l1:130ff9ff  l2:0f0ff9ff l3:0b0ff9ff
l4:070ff9ff l5:030ff9ff l6:ff0ef9ff l7:fb0ef9ff
Jul  1 17:57:23 sparc20 kernel:  i0:f70ef9ff i1:f30ef9ff  i2:ef0ef9ff i3:eb0ef9ff
i4:e70ef9ff i5:e30ef9ff fp:df0ef9ff i7:db0ef9ff
Jul  1 17:57:23 sparc20 kernel: Caller[db0ef9ff]
Jul  1 17:57:23 sparc20 kernel: Instruction DUMP: 96102000  400027fc  98102000
<d404a078> 80a2a000  22800006  e4048000  d204a004  9fc28000
Jul  1 17:57:23 sparc20 kernel: Kernel panic: Attempted to kill init!
Jul  1 17:57:23 sparc20 kernel:  Press L1-A to return to the boot prom
Jul  1 17:57:23 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:24 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:25 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:26 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:27 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:28 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:29 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:30 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Jul  1 17:57:31 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)

QUESTION:
what does mean this line?
esp0: yieee, bytes_sent < 0!
esp0: csz=0 ptr=f0007cf8 this_residual=0
esp0: use_sg=0 ptr=f0007cf8 this_residual=0
esp0: forcing async for target2


Output of ksymoops with kernel's messages.

ksymoops 2.4.5 on sparc 2.2.20.  Options used
     -v /boot/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.20/ (default)
     -m /boot/System.map (specified)

[...CUT....]
Jul  1 17:57:23 sparc20 kernel: Unable to handle kernel paging request in
mna handler <1> at virtual address 0f0ffa77
Jul  1 17:57:23 sparc20 kernel:                                        
   \|/ ____ \|/
Jul  1 17:57:23 sparc20 kernel:                                        
   "@'/ ,. \`@"
Jul  1 17:57:23 sparc20 kernel:                                        
   /_| \__/ |_\
Jul  1 17:57:23 sparc20 kernel:                                        
      \__U_/
Jul  1 17:57:23 sparc20 kernel: swapper(1): Oops
Jul  1 17:57:23 sparc20 kernel: PSR:404010c5 PC:f00d72b4 NPC:f00d72b8  Y:00000000
  not tainted
Jul  1 17:57:23 sparc20 kernel: Caller[db0ef9ff]
Jul  1 17:57:23 sparc20 kernel: Instruction DUMP: 96102000  400027fc  98102000
<d404a078> 80a2a000  22800006  e4048000  d204a004  9fc28000
Using defaults from ksymoops -t elf32-sparc -a sparc


Trace; db0ef9ff Before first symbol

Code;  fffffff4 <END_OF_CODE+1cf3529/????>
00000000 <_PC>:
Code;  fffffff4 <END_OF_CODE+1cf3529/????>
   0:   96 10 20 00       clr  %o3
Code;  fffffff8 <END_OF_CODE+1cf352d/????>
   4:   40 00 27 fc       call  9ff4 <_PC+0x9ff4> 00009fe8 Before first
symbol
Code;  fffffffc <END_OF_CODE+1cf3531/????>
   8:   98 10 20 00       clr  %o4
Code;  00000000 Before first symbol
   c:   d4 04 a0 78       ld  [ %l2 + 0x78 ], %o2
Code;  00000004 Before first symbol
  10:   80 a2 a0 00       cmp  %o2, 0
Code;  00000008 Before first symbol
  14:   22 80 00 06       be,a   2c <_PC+0x2c> 00000020 Before first symbol
Code;  0000000c Before first symbol
  18:   e4 04 80 00       ld  [ %l2 ], %l2
Code;  00000010 Before first symbol
  1c:   d2 04 a0 04       ld  [ %l2 + 4 ], %o1
Code;  00000014 Before first symbol
  20:   9f c2 80 00       call  %o2
Code;  00000018 Before first symbol
  24:   00 00 00 00       unimp  0

Jul  1 17:57:23 sparc20 kernel: Kernel panic: Attempted to kill init!
Jul  1 17:57:23 sparc20 kernel: spin_lock(f01e3000) CPU#1 stuck at f005e720,
owner PC(f002bab4):CPU(0)
Warning (Oops_read): Code line not seen, dumping what data is available


>>PC;  f005e720 <sync_old_buffers+24/cc>   <=====
>>PC;  f002bab4 <here+118/138>   <=====

Trace; f01e3000 <__init_end+0/0>


953 warnings issued.  Results may not be reliable.


MESSAGES of the same kernel image where it has accidentally worked:

Jul  1 17:57:46 sparc20 syslogd 1.4.1#10: restart.
Jul  1 17:57:47 sparc20 kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
Jul  1 17:57:47 sparc20 kernel: Inspecting /boot/System.map-2.4.21
Jul  1 17:57:48 sparc20 lpd[179]: restarted
Jul  1 17:57:48 sparc20 kernel: Loaded 11279 symbols from /boot/System.map-2.4.21.
Jul  1 17:57:48 sparc20 kernel: Symbols match kernel version 2.4.21.
Jul  1 17:57:48 sparc20 kernel: Loaded 6 symbols from 1 module.
Jul  1 17:57:48 sparc20 kernel: PROMLIB: Sun Boot Prom Version 3 Revision
2
Jul  1 17:57:48 sparc20 kernel: Linux version 2.4.21 (root@sparc20) (gcc
version 2.95.4 20011002 (Debian prerelease)) #1 SMP Tue Jul 1 14:24:20 CEST
2003
Jul  1 17:57:48 sparc20 kernel: ARCH: SUN4M
Jul  1 17:57:48 sparc20 kernel: TYPE: Sun4m SparcStation10/20
Jul  1 17:57:48 sparc20 kernel: Ethernet address: 8:0:20:7b:46:8
Jul  1 17:57:48 sparc20 kernel: Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek
(jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu
Jul  1 17:57:48 sparc20 kernel: 16202MB HIGHMEM available.
Jul  1 17:57:48 sparc20 kernel: On node 0 totalpages: 32008
Jul  1 17:57:48 sparc20 kernel: zone(0): 45056 pages.
Jul  1 17:57:48 sparc20 kernel: zone(1): 0 pages.
Jul  1 17:57:48 sparc20 kernel: zone(2): 48970 pages.
Jul  1 17:57:48 sparc20 kernel: Found CPU 0 <node=ffd6f150,mid=8>
Jul  1 17:57:48 sparc20 kernel: Found CPU 1 <node=ffd6f510,mid=10>
Jul  1 17:57:48 sparc20 kernel: Found 2 CPU prom device tree node(s).
Jul  1 17:57:48 sparc20 kernel: Power off control detected.
Jul  1 17:57:48 sparc20 kernel: Kernel command line: root=/dev/sdb5 ro
Jul  1 17:57:48 sparc20 kernel: Console: colour dummy device 80x25
Jul  1 17:57:48 sparc20 kernel: Calibrating delay loop... 74.75 BogoMIPS
Jul  1 17:57:48 sparc20 kernel: Memory: 120512k available (1472k kernel
code, 292k data, 132k init, 64808k highmem) [f0000000,16f4a000]
Jul  1 17:57:48 sparc20 kernel: Dentry cache hash table entries: 8192 (order:
4, 65536 bytes)
Jul  1 17:57:48 sparc20 kernel: Inode cache hash table entries: 4096 (order:
3, 32768 bytes)
Jul  1 17:57:48 sparc20 kernel: Mount cache hash table entries: 512 (order:
0, 4096 bytes)
Jul  1 17:57:48 sparc20 kernel: Buffer-cache hash table entries: 1024 (order:
0, 4096 bytes)
Jul  1 17:57:48 sparc20 kernel: Page-cache hash table entries: 16384 (order:
4, 65536 bytes)
Jul  1 17:57:48 sparc20 kernel: POSIX conformance testing by UNIFIX
Jul  1 17:57:48 sparc20 kernel: Entering SMP Mode...
Jul  1 17:57:48 sparc20 kernel: Starting CPU 1 at f01c70e4
Jul  1 17:57:48 sparc20 kernel: Calibrating delay loop... 74.95 BogoMIPS
Jul  1 17:57:48 sparc20 kernel: Total of 2 Processors activated (149.70
BogoMIPS).
Jul  1 17:57:48 sparc20 kernel: Waiting on wait_init_idle (map = 0x2)
Jul  1 17:57:48 sparc20 kernel: All processors have done init_idle
Jul  1 17:57:48 sparc20 kernel: IOMMU: impl 1 vers 3 page table at fafc0000
of size 262144 bytes
Jul  1 17:57:48 sparc20 kernel: sbus0: Clock 25.0 MHz
Jul  1 17:57:48 sparc20 kernel: dma0: Revision 2 
Jul  1 17:57:48 sparc20 kernel: dma1: Revision 2 
Jul  1 17:57:48 sparc20 kernel: Sparc Zilog8530 serial driver version 1.68.2.2
Jul  1 17:57:48 sparc20 kernel: Sun Mouse-Systems mouse driver version 1.00
Jul  1 17:57:48 sparc20 kernel: tty00 at 0xffede004 (irq = 44) is a Zilog8530
Jul  1 17:57:48 sparc20 kernel: tty01 at 0xffede000 (irq = 44) is a Zilog8530
Jul  1 17:57:48 sparc20 kernel: tty02 at 0xffedb004 (irq = 44) is a Zilog8530
Jul  1 17:57:48 sparc20 kernel: tty03 at 0xffedb000 (irq = 44) is a Zilog8530
Jul  1 17:57:48 sparc20 kernel: Sun TYPE 5 keyboard detected without keyclick
Jul  1 17:57:48 sparc20 kernel: Linux NET4.0 for Linux 2.4
Jul  1 17:57:48 sparc20 kernel: Based upon Swansea University Computer Society
NET3.039
Jul  1 17:57:48 sparc20 kernel: Initializing RT netlink socket
Jul  1 17:57:48 sparc20 kernel: Starting kswapd
Jul  1 17:57:48 sparc20 kernel: allocated 32 pages and 32 bhs reserved for
the highmem bounces
Jul  1 17:57:48 sparc20 kernel: ioremap: done with statics, switching to
malloc
Jul  1 17:57:48 sparc20 kernel: Console: switching to colour frame buffer
device 128x54
Jul  1 17:57:48 sparc20 kernel: fb0: cgsix at e.20000000 TEC Rev 4 CPU sparc
Rev b [TGX+]
Jul  1 17:57:48 sparc20 kernel: pty: 256 Unix98 ptys configured
Jul  1 17:57:48 sparc20 kernel: Floppy drive(s): fd0 is 1.44M
Jul  1 17:57:48 sparc20 kernel: FDC 0 is a National Semiconductor PC87306
Jul  1 17:57:48 sparc20 kernel: RAMDISK driver initialized: 16 RAM disks
of 4096K size 1024 blocksize
Jul  1 17:57:48 sparc20 kernel: sunlance.c:v2.01 08/Nov/01 Miguel de Icaza
(miguel@nuclecu.unam.mx)
Jul  1 17:57:48 sparc20 kernel: eth0: LANCE 08:00:20:7b:46:08 
Jul  1 17:57:48 sparc20 kernel: eth0: using auto-carrier-detection.
Jul  1 17:57:48 sparc20 kernel: SCSI subsystem driver Revision: 1.00
Jul  1 17:57:48 sparc20 kernel: esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC=25000
CCF=8 TOut 167 NCR53C9XF(espfast)
Jul  1 17:57:48 sparc20 kernel: ESP: Total of 1 ESP hosts found, 1 actually
in use.
Jul  1 17:57:48 sparc20 kernel: scsi0 : Sparc ESP100A-FAST
Jul  1 17:57:48 sparc20 kernel:   Vendor: UNISYS    Model: ST32550W    
     Rev: 2804
Jul  1 17:57:48 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:48 sparc20 kernel: esp0: hoping for msgout
Jul  1 17:57:48 sparc20 kernel:   Vendor: HP        Model: 4.26 GB rev 0632
 Rev: 0632
Jul  1 17:57:48 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:48 sparc20 kernel:   Vendor: SEAGATE   Model: ST32550W    
     Rev: 5108
Jul  1 17:57:48 sparc20 kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 02
Jul  1 17:57:48 sparc20 kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS
   Rev: 1.11
Jul  1 17:57:48 sparc20 kernel:   Type:   CD-ROM                       
     ANSI SCSI revision: 02
Jul  1 17:57:48 sparc20 kernel:   Vendor: TOSHIBA   Model: XM-4101TASUNSLCD
 Rev: 1084
Jul  1 17:57:48 sparc20 kernel:   Type:   CD-ROM                       
     ANSI SCSI revision: 02
Jul  1 17:57:48 sparc20 kernel: Attached scsi disk sda at scsi0, channel
0, id 1, lun 0
Jul  1 17:57:48 sparc20 kernel: Attached scsi disk sdb at scsi0, channel
0, id 2, lun 0
Jul  1 17:57:48 sparc20 kernel: Attached scsi disk sdc at scsi0, channel
0, id 3, lun 0
Jul  1 17:57:48 sparc20 kernel: esp0: target 1 [period 100ns offset 15 10.00MHz
FAST SCSI-II]
Jul  1 17:57:48 sparc20 kernel: SCSI device sda: 4194058 512-byte hdwr sectors
(2147 MB)
Jul  1 17:57:48 sparc20 kernel: Partition check:
Jul  1 17:57:48 sparc20 kernel:  sda: sda1 sda2 sda3
Jul  1 17:57:48 sparc20 kernel: SCSI device sdb: 8330543 512-byte hdwr sectors
(4265 MB)
Jul  1 17:57:48 sparc20 kernel:  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
Jul  1 17:57:48 sparc20 kernel: esp0: target 3 [period 100ns offset 15 10.00MHz
FAST SCSI-II]
Jul  1 17:57:48 sparc20 kernel: SCSI device sdc: 4194058 512-byte hdwr sectors
(2147 MB)
Jul  1 17:57:48 sparc20 kernel:  sdc: sdc1 sdc2 sdc3
Jul  1 17:57:48 sparc20 kernel: Attached scsi CD-ROM sr0 at scsi0, channel
0, id 5, lun 0
Jul  1 17:57:48 sparc20 kernel: Attached scsi CD-ROM sr1 at scsi0, channel
0, id 6, lun 0
Jul  1 17:57:48 sparc20 kernel: esp0: target 5 asynchronous
Jul  1 17:57:48 sparc20 kernel: sr0: scsi-1 drive
Jul  1 17:57:48 sparc20 kernel: Uniform CD-ROM driver Revision: 3.12
Jul  1 17:57:48 sparc20 kernel: esp0: target 6 asynchronous
Jul  1 17:57:48 sparc20 kernel: sr1: scsi-1 drive
Jul  1 17:57:48 sparc20 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul  1 17:57:48 sparc20 kernel: IP Protocols: ICMP, UDP, TCP
Jul  1 17:57:48 sparc20 kernel: IP: routing cache hash table of 16 buckets,
2Kbytes
Jul  1 17:57:48 sparc20 kernel: TCP: Hash tables configured (established
128 bind 2730)
Jul  1 17:57:48 sparc20 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jul  1 17:57:48 sparc20 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jul  1 17:57:48 sparc20 kernel: Freeing unused kernel memory: 132k freed
Jul  1 17:57:48 sparc20 kernel: sunhme.c:v2.01 26/Mar/2002 David S. Miller
(davem@redhat.com)
Jul  1 17:57:48 sparc20 kernel: eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet
08:00:20:7b:46:08 
Jul  1 17:57:48 sparc20 kernel: eth0: Carrier Lost, trying TPE
Jul  1 17:57:48 sparc20 kernel: eth1: Link is up using internal transceiver
at 100Mb/s, Full Duplex.

DMESG OUTPUT

PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.4.21 (root@sparc20) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 SMP Tue Jul 1 14:24:20 CEST 2003
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:7b:46:8
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching
kernel for srmmu[TI Viking/MXCC]/iommu
16202MB HIGHMEM available.
On node 0 totalpages: 32008
zone(0): 45056 pages.
zone(1): 0 pages.
zone(2): 48970 pages.
Found CPU 0 <node=ffd6f150,mid=8>
Found CPU 1 <node=ffd6f510,mid=10>
Found 2 CPU prom device tree node(s).
Power off control detected.
Kernel command line: root=/dev/sdb5 ro
Console: colour dummy device 80x25
Calibrating delay loop... 74.75 BogoMIPS
Memory: 120512k available (1472k kernel code, 292k data, 132k init, 64808k
highmem) [f0000000,16f4a000]
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Starting CPU 1 at f01c70e4
Calibrating delay loop... 74.95 BogoMIPS
Total of 2 Processors activated (149.70 BogoMIPS).
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
IOMMU: impl 1 vers 3 page table at fafc0000 of size 262144 bytes
sbus0: Clock 25.0 MHz
dma0: Revision 2 
dma1: Revision 2 
Sparc Zilog8530 serial driver version 1.68.2.2
Sun Mouse-Systems mouse driver version 1.00
tty00 at 0xffede004 (irq = 44) is a Zilog8530
tty01 at 0xffede000 (irq = 44) is a Zilog8530
tty02 at 0xffedb004 (irq = 44) is a Zilog8530
tty03 at 0xffedb000 (irq = 44) is a Zilog8530
Sun TYPE 5 keyboard detected without keyclick
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
ioremap: done with statics, switching to malloc
Console: switching to colour frame buffer device 128x54
fb0: cgsix at e.20000000 TEC Rev 4 CPU sparc Rev b [TGX+]
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
sunlance.c:v2.01 08/Nov/01 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:7b:46:08 
eth0: using auto-carrier-detection.
SCSI subsystem driver Revision: 1.00
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: UNISYS    Model: ST32550W          Rev: 2804
  Type:   Direct-Access                      ANSI SCSI revision: 02
esp0: hoping for msgout
  Vendor: HP        Model: 4.26 GB rev 0632  Rev: 0632
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST32550W          Rev: 5108
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 1084
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 3, lun 0
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 4194058 512-byte hdwr sectors (2147 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 8330543 512-byte hdwr sectors (4265 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdc: 4194058 512-byte hdwr sectors (2147 MB)
 sdc: sdc1 sdc2 sdc3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
esp0: target 5 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
esp0: target 6 asynchronous
sr1: scsi-1 drive
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16 buckets, 2Kbytes
TCP: Hash tables configured (established 128 bind 2730)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 132k freed
sunhme.c:v2.01 26/Mar/2002 David S. Miller (davem@redhat.com)
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:7b:46:08 
eth1: Link is up using internal transceiver at 100Mb/s, Full Duplex.

For other details please mail me..
Tanks for Help...
Fred

__________________________________________________________________
Il Numero di Accesso ad Internet sta cambiando!
Modifica subito il tuo numero di accesso con Tiscali: il nuovo 
numero e' 7023456789 oppure vai alla pagina
http://assistenza.tiscali.it/connessione/mail.html
e scarica il file di configurazione automatica.



