Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTDWOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTDWOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:32:59 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12239 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264059AbTDWOcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:32:47 -0400
Date: Wed, 23 Apr 2003 07:44:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: New: oups while running mc, not able to run xterm nor kterm in
 xfree86 
Message-ID: <15380000.1051109077@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=621

           Summary: oups while running mc, not able to run xterm nor kterm
                    in xfree86
    Kernel Version: 2.5.68-bk4
            Status: NEW
          Severity: blocking
             Owner: bugme-admin@osdl.org
         Submitter: gj@pointblue.com.pl


Distribution: Debian unstable 
Hardware Environment:  
p4 2 ghz, 512MB x86 computer 
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge (rev 01)          Subsystem: Intel Corp. 82845G/GL [Brookdale-G]
Chipset Host Bridge          Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR-  FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ 
> SERR- <PERR- 
        Latency: 0 
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M] 
        Capabilities: <available only to root> 
 
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 01) (prog-if 00  [Normal decode]) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping-  SERR+ FastB2B- 
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 64 
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32 
        I/O behind bridge: 0000f000-00000fff 
        Memory behind bridge: e6000000-e7ffffff 
        Prefetchable memory behind bridge: e4000000-e5ffffff 
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B- 
 
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if
00 [UHCI])          Subsystem: Intel Corp. 82801DB USB (Hub #1) 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin A routed to IRQ 12 
        Region 4: I/O ports at b800 [size=32] 
 
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if
00 [UHCI])          Subsystem: Intel Corp.: Unknown device 24c2 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin B routed to IRQ 12 
        Region 4: I/O ports at b000 [size=32] 
 
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if
00 [UHCI])          Subsystem: Intel Corp.: Unknown device 24c2 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin C routed to IRQ 11 
        Region 4: I/O ports at b400 [size=32] 
 
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
(prog-if 20 [EHCI])          Subsystem: Giga-byte Technology: Unknown
device 5004 
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin D routed to IRQ 9 
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=1K] 
        Capabilities: <available only to root> 
 
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) (prog-if
00 [Normal decode])          Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping-  SERR+ FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR+ 
        Latency: 0 
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32 
        I/O behind bridge: 0000a000-0000afff 
        Memory behind bridge: e8000000-e9ffffff 
        Prefetchable memory behind bridge: fff00000-000fffff 
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B- 
 
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping-  SERR- FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
 
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a
[Master SecP PriP])          Subsystem: Intel Corp.: Unknown device 24c2 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin A routed to IRQ 11 
        Region 0: I/O ports at <ignored> 
        Region 1: I/O ports at <ignored> 
        Region 2: I/O ports at <ignored> 
        Region 3: I/O ports at <ignored> 
        Region 4: I/O ports at cc00 [size=16] 
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K] 
 
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01) 
        Subsystem: Intel Corp.: Unknown device 24c2 
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Interrupt: pin B routed to IRQ 5 
        Region 4: I/O ports at 5000 [size=32] 
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev
01)          Subsystem: Giga-byte Technology: Unknown device a002 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 0 
        Interrupt: pin B routed to IRQ 5 
        Region 0: I/O ports at d400 [size=256] 
        Region 1: I/O ports at d800 [size=64] 
        Region 2: Memory at ea002000 (32-bit, non-prefetchable) [size=512] 
        Region 3: Memory at ea003000 (32-bit, non-prefetchable) [size=256] 
        Capabilities: <available only to root> 
 
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro]  (rev 15) (prog-if 00 [VGA]) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR-  FastB2B- 
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort-  <MAbort- >SERR- <PERR- 
        Latency: 32 (1250ns min, 250ns max) 
        Interrupt: pin A routed to IRQ 12 
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M] 
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M] 
        Expansion ROM at <unassigned> [disabled] [size=64K] 
        Capabilities: <available only to root> 
 
02:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)          Subsystem: Compaq Computer Corporation NC3123 Fast Ethernet
NIC (WOL)          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR-  FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- 
> SERR- <PERR- 
        Latency: 32 (2000ns min, 14000ns max), cache line size 08 
        Interrupt: pin A routed to IRQ 11 
        Region 0: Memory at e9100000 (32-bit, non-prefetchable) [size=4K] 
        Region 1: I/O ports at a000 [size=64] 
        Region 2: Memory at e9000000 (32-bit, non-prefetchable) [size=1M] 
        Expansion ROM at <unassigned> [disabled] [size=1M] 
        Capabilities: <available only to root> 
 
 
Software Environment: 
bash-2.05b$ gcc -v 
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs 
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,objc,ada --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.2  --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--enable-__cxa_atexit  --enable-clocale=gnu --enable-java-gc=boehm
--enable-objc-gc i386-linux  Thread model: posix 
gcc version 3.2.3 20030415 (Debian prerelease) 
 
Problem Description: 
seems like pty-s are somewhat broken.  
 
Steps to reproduce: 
try to run mc, xinit or kterm  
 
 
oups : 
 
Apr 23 14:51:40 gregs kernel: 
Apr 23 14:51:40 gregs kernel: Code: 8b 43 1c 89 04 24 e8 e3 fb ff ff 89 1c
24 e8 b6 eb ff ff 89  Apr 23 14:51:40 gregs kernel:  <6>note: mc[3688]
exited with preempt_count 2  Apr 23 14:51:40 gregs kernel: bad: scheduling
while atomic! 
Apr 23 14:51:40 gregs kernel: Call Trace: 
Apr 23 14:51:40 gregs kernel:  [schedule+935/940] schedule+0x3a7/0x3ac 
Apr 23 14:51:40 gregs kernel:  [unmap_page_range+73/135]
unmap_page_range+0x49/0x87  Apr 23 14:51:40 gregs kernel:
[unmap_vmas+441/551] unmap_vmas+0x1b9/0x227  Apr 23 14:51:40 gregs kernel:
[exit_mmap+124/401] exit_mmap+0x7c/0x191  Apr 23 14:51:40 gregs kernel:
[mmput+86/165] mmput+0x56/0xa5 
Apr 23 14:51:40 gregs kernel:  [do_exit+287/1041] do_exit+0x11f/0x411 
Apr 23 14:51:40 gregs kernel:  [do_divide_error+0/251]
do_divide_error+0x0/0xfb  Apr 23 14:51:40 gregs kernel:
[do_page_fault+282/1059] do_page_fault+0x11a/0x423  Apr 23 14:51:40 gregs
kernel:  [devfs_lookup+377/563] devfs_lookup+0x179/0x233  Apr 23 14:51:40
gregs kernel:  [d_alloc+32/454] d_alloc+0x20/0x1c6  Apr 23 14:51:40 gregs
kernel:  [_devfs_descend+132/193] _devfs_descend+0x84/0xc1  Apr 23 14:51:40
gregs kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423  Apr 23
14:51:40 gregs kernel:  [error_code+45/56] error_code+0x2d/0x38  Apr 23
14:51:40 gregs kernel:  [devfs_remove+104/133] devfs_remove+0x68/0x85  Apr
23 14:51:40 gregs kernel:  [iput+98/124] iput+0x62/0x7c 
Apr 23 14:51:40 gregs kernel:  [dput+34/483] dput+0x22/0x1e3 
Apr 23 14:51:40 gregs kernel:  [devpts_pty_kill+63/87]
devpts_pty_kill+0x3f/0x57  Apr 23 14:51:40 gregs kernel:
[pty_close+233/320] pty_close+0xe9/0x140  Apr 23 14:51:40 gregs kernel:
[release_dev+2001/2070] release_dev+0x7d1/0x816  Apr 23 14:51:40 gregs
kernel:  [__user_walk+92/94] __user_walk+0x5c/0x5e  Apr 23 14:51:40 gregs
kernel:  [vfs_stat+31/91] vfs_stat+0x1f/0x5b  Apr 23 14:51:40 gregs kernel:
[sys_statfs+158/188] sys_statfs+0x9e/0xbc  Apr 23 14:51:40 gregs kernel:
[tty_release+0/103] tty_release+0x0/0x67  Apr 23 14:51:40 gregs kernel:
[tty_release+45/103] tty_release+0x2d/0x67  Apr 23 14:51:40 gregs kernel:
[__fput+251/256] __fput+0xfb/0x100  Apr 23 14:51:40 gregs kernel:
[filp_close+153/208] filp_close+0x99/0xd0  Apr 23 14:51:40 gregs kernel:
[sys_close+100/152] sys_close+0x64/0x98  Apr 23 14:51:40 gregs kernel:
[syscall_call+7/11] syscall_call+0x7/0xb  Apr 23 14:51:40 gregs kernel: 
Apr 23 14:51:40 gregs modprobe: FATAL: Module /dev/pts/18 not found. 
Apr 23 14:51:40 gregs kernel: Unable to handle kernel NULL pointer
dereference at virtual address  0000001c 
Apr 23 14:51:40 gregs kernel:  printing eip: 
Apr 23 14:51:40 gregs kernel: c01c256f 
Apr 23 14:51:40 gregs kernel: *pde = 00000000 
Apr 23 14:51:40 gregs kernel: Oops: 0000 [#19] 
Apr 23 14:51:40 gregs kernel: CPU:    0 
Apr 23 14:51:40 gregs kernel: EIP:    0060:[devfs_remove+104/133]    Not
tainted  Apr 23 14:51:40 gregs kernel: EFLAGS: 00010202 
Apr 23 14:51:40 gregs kernel: EIP is at devfs_remove+0x68/0x85 
Apr 23 14:51:40 gregs kernel: eax: d3742000   ebx: 00000000   ecx: d3743ea6
edx: 00000000  Apr 23 14:51:40 gregs kernel: esi: daedae80   edi: 00000012
ebp: d608c000   esp: d3743e90  Apr 23 14:51:40 gregs kernel: ds: 007b   es:
007b   ss: 0068 
Apr 23 14:51:40 gregs kernel: Process mc (pid: 3691, threadinfo=d3742000
task=dc58b880)  Apr 23 14:51:40 gregs kernel: Stack: 00000000 00000000
00000000 d3743ef0 2f737470  df003831 db108200 db108200 
Apr 23 14:51:40 gregs kernel:        c016e727 db108200 dfdd4e80 dfdd4e80
c016b8f6 dfdd4e80  c063c8f0 d4dcd780 
Apr 23 14:51:40 gregs kernel:        daedae80 00000012 c018dc70 d4dcd780
d5021000 c0365775  c05d616b 00000012 
Apr 23 14:51:40 gregs kernel: Call Trace: 
Apr 23 14:51:40 gregs kernel:  [iput+98/124] iput+0x62/0x7c 
Apr 23 14:51:40 gregs kernel:  [dput+34/483] dput+0x22/0x1e3 
Apr 23 14:51:40 gregs kernel:  [devpts_pty_kill+63/87]
devpts_pty_kill+0x3f/0x57  Apr 23 14:51:40 gregs kernel:
[pty_close+233/320] pty_close+0xe9/0x140  Apr 23 14:51:40 gregs kernel:
[release_dev+2001/2070] release_dev+0x7d1/0x816  Apr 23 14:51:40 gregs
kernel:  [__user_walk+92/94] __user_walk+0x5c/0x5e  Apr 23 14:51:40 gregs
kernel:  [vfs_stat+31/91] vfs_stat+0x1f/0x5b  Apr 23 14:51:40 gregs kernel:
[sys_statfs+158/188] sys_statfs+0x9e/0xbc  Apr 23 14:51:40 gregs kernel:
[tty_release+0/103] tty_release+0x0/0x67  Apr 23 14:51:40 gregs kernel:
[tty_release+45/103] tty_release+0x2d/0x67  Apr 23 14:51:40 gregs kernel:
[__fput+251/256] __fput+0xfb/0x100  Apr 23 14:51:40 gregs kernel:
[filp_close+153/208] filp_close+0x99/0xd0  Apr 23 14:51:40 gregs kernel:
[sys_close+100/152] sys_close+0x64/0x98  Apr 23 14:51:40 gregs kernel:
[syscall_call+7/11] syscall_call+0x7/0xb  Apr 23 14:51:40 gregs kernel: 
Apr 23 14:51:40 gregs kernel: Code: 8b 43 1c 89 04 24 e8 e3 fb ff ff 89 1c
24 e8 b6 eb ff ff 89  Apr 23 14:51:40 gregs kernel:  <6>note: mc[3691]
exited with preempt_count 2  Apr 23 14:51:40 gregs kernel: bad: scheduling
while atomic! 
Apr 23 14:51:40 gregs kernel: Call Trace: 
Apr 23 14:51:40 gregs kernel:  [schedule+935/940] schedule+0x3a7/0x3ac 
Apr 23 14:51:40 gregs kernel:  [unmap_page_range+73/135]
unmap_page_range+0x49/0x87  Apr 23 14:51:40 gregs kernel:
[unmap_vmas+441/551] unmap_vmas+0x1b9/0x227  Apr 23 14:51:40 gregs kernel:
[exit_mmap+124/401] exit_mmap+0x7c/0x191  Apr 23 14:51:40 gregs kernel:
[mmput+86/165] mmput+0x56/0xa5 
Apr 23 14:51:40 gregs kernel:  [do_exit+287/1041] do_exit+0x11f/0x411 
Apr 23 14:51:40 gregs kernel:  [do_divide_error+0/251]
do_divide_error+0x0/0xfb  Apr 23 14:51:40 gregs kernel:
[do_page_fault+282/1059] do_page_fault+0x11a/0x423  Apr 23 14:51:40 gregs
kernel:  [devfs_lookup+377/563] devfs_lookup+0x179/0x233  Apr 23 14:51:40
gregs kernel:  [d_alloc+32/454] d_alloc+0x20/0x1c6  Apr 23 14:51:40 gregs
kernel:  [_devfs_descend+132/193] _devfs_descend+0x84/0xc1  Apr 23 14:51:40
gregs kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423  Apr 23
14:51:40 gregs kernel:  [error_code+45/56] error_code+0x2d/0x38  Apr 23
14:51:40 gregs kernel:  [devfs_remove+104/133] devfs_remove+0x68/0x85  Apr
23 14:51:40 gregs kernel:  [iput+98/124] iput+0x62/0x7c 
Apr 23 14:51:40 gregs kernel:  [dput+34/483] dput+0x22/0x1e3 
Apr 23 14:51:40 gregs kernel:  [devpts_pty_kill+63/87]
devpts_pty_kill+0x3f/0x57  Apr 23 14:51:40 gregs kernel:
[pty_close+233/320] pty_close+0xe9/0x140  Apr 23 14:51:40 gregs kernel:
[release_dev+2001/2070] release_dev+0x7d1/0x816  Apr 23 14:51:40 gregs
kernel:  [__user_walk+92/94] __user_walk+0x5c/0x5e  Apr 23 14:51:40 gregs
kernel:  [vfs_stat+31/91] vfs_stat+0x1f/0x5b  Apr 23 14:51:40 gregs kernel:
[sys_statfs+158/188] sys_statfs+0x9e/0xbc  Apr 23 14:51:40 gregs kernel:
[tty_release+0/103] tty_release+0x0/0x67  Apr 23 14:51:40 gregs kernel:
[tty_release+45/103] tty_release+0x2d/0x67  Apr 23 14:51:40 gregs kernel:
[__fput+251/256] __fput+0xfb/0x100  Apr 23 14:51:40 gregs kernel:
[filp_close+153/208] filp_close+0x99/0xd0  Apr 23 14:51:40 gregs kernel:
[sys_close+100/152] sys_close+0x64/0x98  Apr 23 14:51:40 gregs kernel:
[syscall_call+7/11] syscall_call+0x7/0xb  Apr 23 14:51:40 gregs kernel: 
Apr 23 14:51:41 gregs modprobe: FATAL: Module /dev/pts/19 not found. 
Apr 23 14:51:41 gregs kernel: Unable to handle kernel NULL pointer
dereference at virtual address  0000001c 
Apr 23 14:51:41 gregs kernel:  printing eip: 
Apr 23 14:51:41 gregs kernel: c01c256f 
Apr 23 14:51:41 gregs kernel: *pde = 00000000 
Apr 23 14:51:41 gregs kernel: Oops: 0000 [#20] 
Apr 23 14:51:41 gregs kernel: CPU:    0 
Apr 23 14:51:41 gregs kernel: EIP:    0060:[devfs_remove+104/133]    Not
tainted  Apr 23 14:51:41 gregs kernel: EFLAGS: 00010202 
Apr 23 14:51:41 gregs kernel: EIP is at devfs_remove+0x68/0x85 
Apr 23 14:51:41 gregs kernel: eax: d3742000   ebx: 00000000   ecx: d3743ea6
edx: 00000000  Apr 23 14:51:41 gregs kernel: esi: daeda400   edi: 00000013
ebp: d47ea000   esp: d3743e90  Apr 23 14:51:41 gregs kernel: ds: 007b   es:
007b   ss: 0068 
Apr 23 14:51:41 gregs kernel: Process mc (pid: 3694, threadinfo=d3742000
task=dc58b880)  Apr 23 14:51:41 gregs kernel: Stack: 00000000 00000000
00000000 d3743ef0 2f737470  df003931 db108080 db108080 
Apr 23 14:51:41 gregs kernel:        c016e727 db108080 dfdd4e80 dfdd4e80
c016b8f6 dfdd4e80  c063c8f0 d5196680 
Apr 23 14:51:41 gregs kernel:        daeda400 00000013 c018dc70 d5196680
dcb63000 c0365775  c05d616b 00000013 
Apr 23 14:51:41 gregs kernel: Call Trace: 
Apr 23 14:51:41 gregs kernel:  [iput+98/124] iput+0x62/0x7c 
Apr 23 14:51:41 gregs kernel:  [dput+34/483] dput+0x22/0x1e3 
Apr 23 14:51:41 gregs kernel:  [devpts_pty_kill+63/87]
devpts_pty_kill+0x3f/0x57  Apr 23 14:51:41 gregs kernel:
[pty_close+233/320] pty_close+0xe9/0x140  Apr 23 14:51:41 gregs kernel:
[release_dev+2001/2070] release_dev+0x7d1/0x816  Apr 23 14:51:41 gregs
kernel:  [__user_walk+92/94] __user_walk+0x5c/0x5e  Apr 23 14:51:41 gregs
kernel:  [vfs_stat+31/91] vfs_stat+0x1f/0x5b  Apr 23 14:51:41 gregs kernel:
[sys_statfs+158/188] sys_statfs+0x9e/0xbc  Apr 23 14:51:41 gregs kernel:
[tty_release+0/103] tty_release+0x0/0x67  Apr 23 14:51:41 gregs kernel:
[tty_release+45/103] tty_release+0x2d/0x67  Apr 23 14:51:41 gregs kernel:
[__fput+251/256] __fput+0xfb/0x100  Apr 23 14:51:41 gregs kernel:
[filp_close+153/208] filp_close+0x99/0xd0  Apr 23 14:51:41 gregs kernel:
[sys_close+100/152] sys_close+0x64/0x98  Apr 23 14:51:41 gregs kernel:
[syscall_call+7/11] syscall_call+0x7/0xb  Apr 23 14:51:41 gregs kernel: 
Apr 23 14:51:41 gregs kernel: Code: 8b 43 1c 89 04 24 e8 e3 fb ff ff 89 1c
24 e8 b6 eb ff ff 89  Apr 23 14:51:41 gregs kernel:  <6>note: mc[3694]
exited with preempt_count 2  Apr 23 14:51:41 gregs kernel: bad: scheduling
while atomic! 
Apr 23 14:51:41 gregs kernel: Call Trace: 
Apr 23 14:51:41 gregs kernel:  [schedule+935/940] schedule+0x3a7/0x3ac 
Apr 23 14:51:41 gregs kernel:  [unmap_page_range+73/135]
unmap_page_range+0x49/0x87  Apr 23 14:51:41 gregs kernel:
[unmap_vmas+441/551] unmap_vmas+0x1b9/0x227  Apr 23 14:51:41 gregs kernel:
[exit_mmap+124/401] exit_mmap+0x7c/0x191  Apr 23 14:51:41 gregs kernel:
[mmput+86/165] mmput+0x56/0xa5 
Apr 23 14:51:41 gregs kernel:  [do_exit+287/1041] do_exit+0x11f/0x411 
Apr 23 14:51:41 gregs kernel:  [do_divide_error+0/251]
do_divide_error+0x0/0xfb  Apr 23 14:51:41 gregs kernel:
[do_page_fault+282/1059] do_page_fault+0x11a/0x423  Apr 23 14:51:41 gregs
kernel:  [devfs_lookup+377/563] devfs_lookup+0x179/0x233  Apr 23 14:51:41
gregs kernel:  [d_alloc+32/454] d_alloc+0x20/0x1c6  Apr 23 14:51:41 gregs
kernel:  [_devfs_descend+132/193] _devfs_descend+0x84/0xc1  Apr 23 14:51:41
gregs kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423  Apr 23
14:51:41 gregs kernel:  [error_code+45/56] error_code+0x2d/0x38  Apr 23
14:51:41 gregs kernel:  [devfs_remove+104/133] devfs_remove+0x68/0x85  Apr
23 14:51:41 gregs kernel:  [iput+98/124] iput+0x62/0x7c 
Apr 23 14:51:41 gregs kernel:  [dput+34/483] dput+0x22/0x1e3 
Apr 23 14:51:41 gregs kernel:  [devpts_pty_kill+63/87]
devpts_pty_kill+0x3f/0x57  Apr 23 14:51:41 gregs kernel:
[pty_close+233/320] pty_close+0xe9/0x140  Apr 23 14:51:41 gregs kernel:
[release_dev+2001/2070] release_dev+0x7d1/0x816  Apr 23 14:51:41 gregs
kernel:  [__user_walk+92/94] __user_walk+0x5c/0x5e  Apr 23 14:51:41 gregs
kernel:  [vfs_stat+31/91] vfs_stat+0x1f/0x5b  Apr 23 14:51:41 gregs kernel:
[sys_statfs+158/188] sys_statfs+0x9e/0xbc  Apr 23 14:51:41 gregs kernel:
[tty_release+0/103] tty_release+0x0/0x67  Apr 23 14:51:41 gregs kernel:
[tty_release+45/103] tty_release+0x2d/0x67  Apr 23 14:51:41 gregs kernel:
[__fput+251/256] __fput+0xfb/0x100  Apr 23 14:51:41 gregs kernel:
[filp_close+153/208] filp_close+0x99/0xd0  Apr 23 14:51:41 gregs kernel:
[sys_close+100/152] sys_close+0x64/0x98  Apr 23 14:51:41 gregs kernel:
[syscall_call+7/11] syscall_call+0x7/0xb  Apr 23 14:51:41 gregs kernel:

