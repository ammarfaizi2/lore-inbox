Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbTDBMlB>; Wed, 2 Apr 2003 07:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTDBMlB>; Wed, 2 Apr 2003 07:41:01 -0500
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:64959
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id <S262990AbTDBMky>; Wed, 2 Apr 2003 07:40:54 -0500
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: (CRASH) oops in ext3
Date: Wed, 2 Apr 2003 06:43:38 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QCVPWJDSSB5U6TP4VUDR"
Message-Id: <200304020643.38662.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QCVPWJDSSB5U6TP4VUDR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Please CC me on any replies as I am not subscribed.  I hope this is enough 
information.  Report follows specs posted on kernel.org.  Thanks.

1. crash in ext3 part of kernel.
2. I have no information as to what caused this.  The ext3 part of the kernel 
seems to have failed an assertion and crashed, necessitating reboot of the 
machine and making the machine inoperable until said reboot.
3.  keywords:  ext3, kernel, assertion failed
4.  Linux version 2.4.18 (root@truzzi) (gcc version 2.96 20000731 (Red Hat 
Linux 7.1 2.96-98)) #11 SMP Mon Apr 8 07:48:03 PDT 2002
5. oops attached - I ran through ksymoops.
6.  n/a
7.1 Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded

7.2 processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1900+
stepping        : 2
cpu MHz         : 1592.897
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3178.49

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1592.897
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3185.04

7.3 n/a
7.4 0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : ATI Technologies Inc Rage XL
1400-147f : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T]
  1400-147f : 00:0f.0
1480-14ff : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (#2)
  1480-14ff : 00:10.0
1810-1813 : PCI device 1022:700c (Advanced Micro Devices [AMD])
f000-f00f : Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c8800-000c8fff : Extension ROM
000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-765 [Viper] USB
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00299e66 : Kernel code
  00299e67-00319fbf : Kernel data
3fff0000-3fff6bff : ACPI Tables
3fff6c00-3fffffff : ACPI Non-volatile Storage
f0001000-f0001fff : ATI Technologies Inc Rage XL
f0002000-f000207f : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T]
f0002400-f000247f : 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (#2)
f0003000-f0003fff : PCI device 1022:700c (Advanced Micro Devices [AMD])
f1000000-f1ffffff : ATI Technologies Inc Rage XL
f4000000-f7ffffff : PCI device 1022:700c (Advanced Micro Devices [AMD])
f8000000-fbffffff : Distributed Processing Technology SmartRAID V Controller
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

7.5  00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c 
(rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f0003000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1810 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev 
01) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 
07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:09.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 01) 
(prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 00100000-000fffff
        Prefetchable memory behind bridge: 00100000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev 01) 
(prog-if 01)
        Subsystem: Distributed Processing Technology: Unknown device c065
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=32K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Region 0: Memory at f1000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at f0001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server Cyclone 
(rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1400 [size=128]
        Region 1: Memory at f0002000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server Cyclone 
(rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1480 [size=128]
        Region 1: Memory at f0002400 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

7.6 Attached devices:
Host: scsi0 Channel: 01 Id: 00 Lun: 00
  Vendor: ADAPTEC  Model: RAID-5           Rev: 370F
  Type:   Direct-Access                    ANSI SCSI revision: 02

--------------Boundary-00=_QCVPWJDSSB5U6TP4VUDR
Content-Type: text/plain;
  charset="us-ascii";
  name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops"

 Assertion failure in do_get_write_access() at transaction.c:611: "!(((jh2bh(jh))->b_state & (1UL << BH_Lock)) != 0)"
 invalid operand: 0000                            Apr  2 01:38:36 truzzi kernel: CPU:    0
 EIP:    0010:[do_get_write_access+458/1472]    Not tainted
 EIP:    0010:[<c016447a>]    Not tainted         Apr  2 01:38:36 truzzi kernel: EFLAGS: 00010296
 eax: 00000078   ebx: f7e2c094   ecx: d0884000   edx: f73fbf64
 esi: f7e2c000   edi: f74d09a0   ebp: f7e2c000   esp: d0885ddc
 ds: 0018   es: 0018   ss: 0018                   Apr  2 01:38:36 truzzi kernel: Process httpd (pid: 30860, stackpage=d0885000)
 Stack: c02abf60 c02a8a46 c02a89b4 00000263 c02adfa0 00000000 00000000 c016a261
        d587f9c0 f7e2c094 f7e2c000 f74d09a0 ecd55820 c01648a7 f74d09a0 ecd55820
        00000000 00000000 f74d09a0 d0885e9c cb0654a0 c015ed31 f74d09a0 eac3e5c0
 Call Trace: [journal_alloc_journal_head+17/128] [journal_get_write_access+55/96] [ext3_reserve_inode_write+49/176] [link_path_walk+1864/2048] [vfs_follow_link+269/384]
 Call Trace: [<c016a261>] [<c01648a7>] [<c015ed31>] [<c01416b8>] [<c0143c3d>]
    [__jbd_kmalloc+39/128] [ext3_mark_inode_dirty+24/64] [ext3_dirty_inode+152/256] [cached_lookup+16/80] [get_unmapped_area+218/288] [__mark_inode_dirty+46/160]
    [<c016a137>] [<c015edc8>] [<c015ee88>] [<c0140d10>] [<c01267fa>] [<c014a88e>]
    [update_atime+81/85] [generic_file_mmap+74/96] [do_mmap_pgoff+970/1264] [dentry_open+230/400] [sys_mmap2+103/160] [getname+94/160]
    [<c014be61>] [<c01298ea>] [<c01265fa>] [<c0136196>] [<c010c957>] [<c0140a5e>]
    [sys_open+129/192] [system_call+51/56]
    [<c0136421>] [<c0106ffb>]

Code: 0f 0b 83 c4 14 c7 44 24 08 e2 ff ff ff 8b 54 24 24 b8 01 00

 invalid operand: 0000                            Apr  2 01:38:36 truzzi kernel: CPU:    0
 EIP:    0010:[do_get_write_access+458/1472]    Not tainted
 EIP:    0010:[<c016447a>]    Not tainted         Apr  2 01:38:36 truzzi kernel: EFLAGS: 00010296
Using defaults from ksymoops -t elf32-i386 -a i386
 eax: 00000078   ebx: f7e2c094   ecx: d0884000   edx: f73fbf64
 esi: f7e2c000   edi: f74d09a0   ebp: f7e2c000   esp: d0885ddc
 ds: 0018   es: 0018   ss: 0018                   Apr  2 01:38:36 truzzi kernel: Process httpd (pid: 30860, stackpage=d0885000)
 Stack: c02abf60 c02a8a46 c02a89b4 00000263 c02adfa0 00000000 00000000 c016a261
        d587f9c0 f7e2c094 f7e2c000 f74d09a0 ecd55820 c01648a7 f74d09a0 ecd55820
        00000000 00000000 f74d09a0 d0885e9c cb0654a0 c015ed31 f74d09a0 eac3e5c0
 Call Trace: [journal_alloc_journal_head+17/128] [journal_get_write_access+55/96] [ext3_reserve_inode_write+49/176] [link_path_walk+1864/2048] [vfs_follow_link+269/384]
 Call Trace: [<c016a261>] [<c01648a7>] [<c015ed31>] [<c01416b8>] [<c0143c3d>]
    [<c016a137>] [<c015edc8>] [<c015ee88>] [<c0140d10>] [<c01267fa>] [<c014a88e>]
    [<c014be61>] [<c01298ea>] [<c01265fa>] [<c0136196>] [<c010c957>] [<c0140a5e>]
    [<c0136421>] [<c0106ffb>]
Code: 0f 0b 83 c4 14 c7 44 24 08 e2 ff ff ff 8b 54 24 24 b8 01 00

>>EIP; c016447a <do_get_write_access+1ca/5c0>   <=====
Trace; c016a261 <journal_alloc_journal_head+11/80>
Trace; c01648a7 <journal_get_write_access+37/60>
Trace; c015ed31 <ext3_reserve_inode_write+31/b0>
Trace; c01416b8 <link_path_walk+748/800>
Trace; c0143c3d <vfs_follow_link+10d/180>
Trace; c016a137 <__jbd_kmalloc+27/80>
Trace; c015edc8 <ext3_mark_inode_dirty+18/40>
Trace; c015ee88 <ext3_dirty_inode+98/100>
Trace; c0140d10 <cached_lookup+10/50>
Trace; c01267fa <get_unmapped_area+da/120>
Trace; c014a88e <__mark_inode_dirty+2e/a0>
Trace; c014be61 <update_atime+51/55>
Trace; c01298ea <generic_file_mmap+4a/60>
Trace; c01265fa <do_mmap_pgoff+3ca/4f0>
Trace; c0136196 <dentry_open+e6/190>
Trace; c010c957 <sys_mmap2+67/a0>
Trace; c0140a5e <getname+5e/a0>
Trace; c0136421 <sys_open+81/c0>
Trace; c0106ffb <system_call+33/38>
Code;  c016447a <do_get_write_access+1ca/5c0>
00000000 <_EIP>:
Code;  c016447a <do_get_write_access+1ca/5c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016447c <do_get_write_access+1cc/5c0>
   2:   83 c4 14                  add    $0x14,%esp
Code;  c016447f <do_get_write_access+1cf/5c0>
   5:   c7 44 24 08 e2 ff ff      movl   $0xffffffe2,0x8(%esp,1)
Code;  c0164486 <do_get_write_access+1d6/5c0>
   c:   ff
Code;  c0164487 <do_get_write_access+1d7/5c0>
   d:   8b 54 24 24               mov    0x24(%esp,1),%edx
Code;  c016448b <do_get_write_access+1db/5c0>
  11:   b8 01 00 00 00            mov    $0x1,%eax


--------------Boundary-00=_QCVPWJDSSB5U6TP4VUDR--

