Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTKXOdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTKXOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:33:44 -0500
Received: from odin.sis.hu ([212.92.23.29]:36245 "EHLO odin.sis.hu")
	by vger.kernel.org with ESMTP id S263619AbTKXOdb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:33:31 -0500
Date: Mon, 24 Nov 2003 15:33:28 +0100
From: Gabor Burjan <buga@buvoshetes.hu>
To: linux-kernel@vger.kernel.org
Subject: Need help interpreting Oops
Message-ID: <20031124143328.GA30412@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:    

Mysterious kernel panic.

[2.] Full description of the problem/report:

It doesn't depend on load or memory/disk/network usage, etc.
Not easily reproducable.

[3.] Keywords (i.e., modules, networking, kernel):

kernel

[4.] Kernel version (from /proc/version):

Linux version 2.4.23-rc2 (root@mailserver) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Mon Nov 24 10:17:07 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i686 2.4.23-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-rc2/ (default)
     -m /boot/System.map-2.4.23-rc2 (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
mailserver login: Unable to handle kernel paging request at virtual address 0005001c
c010fb1f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c010fb1f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0005001c   ebx: 00050000   ecx: d26d2000   edx: d26d2000
esi: 0005001c   edi: c010fab4   ebp: 0005001c   esp: d26d204c
ds: 0018   es: 0018   ss: 0018
Process m“Dm“Dm“Lm“Lm“Tm“Tm“ (pid: 0, stackpage=d26d1000)
Stack: d26d2000 00000002 c010fab4 0005001c 00050000 00000000 d26d2000 00050000 
       00000000 00030001 00050000 00000000 00000000 00050000 00000000 00000000 
       00050000 00000000 00000000 00050000 00000000 00000000 00050000 00000000 
Call Trace:    [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>]
  [<c0108784>] [<c010fab4>] [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
  [<c010fb1f>] [<c010fab4>] [<c0108784>] [<c010fab4>]
Code: ff 00 0f 88 0d 04 00 00 55 53 e8 36 19 01 00 89 c7 83 c4 08 


>>EIP; c010fb1f <do_page_fault+6b/480>   <=====

>>eax; 0005001c Before first symbol
>>ebx; 00050000 Before first symbol
>>ecx; d26d2000 <END_OF_CODE+12372744/????>
>>edx; d26d2000 <END_OF_CODE+12372744/????>
>>esi; 0005001c Before first symbol
>>edi; c010fab4 <do_page_fault+0/480>
>>ebp; 0005001c Before first symbol
>>esp; d26d204c <END_OF_CODE+12372790/????>

Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c010fb1f <do_page_fault+6b/480>
Trace; c010fab4 <do_page_fault+0/480>
Trace; c0108784 <error_code+34/3c>
Trace; c010fab4 <do_page_fault+0/480>

Code;  c010fb1f <do_page_fault+6b/480>
00000000 <_EIP>:
Code;  c010fb1f <do_page_fault+6b/480>   <=====
   0:   ff 00                     incl   (%eax)   <=====
Code;  c010fb21 <do_page_fault+6d/480>
   2:   0f 88 0d 04 00 00         js     415 <_EIP+0x415> c010ff34 <.text.lock.fault+0/6c>
Code;  c010fb27 <do_page_fault+73/480>
   8:   55                        push   %ebp
Code;  c010fb28 <do_page_fault+74/480>
   9:   53                        push   %ebx
Code;  c010fb29 <do_page_fault+75/480>
   a:   e8 36 19 01 00            call   11945 <_EIP+0x11945> c0121464 <find_vma+0/54>
Code;  c010fb2e <do_page_fault+7a/480>
   f:   89 c7                     mov    %eax,%edi
Code;  c010fb30 <do_page_fault+7c/480>
  11:   83 c4 08                  add    $0x8,%esp

 <0>Kernel panic: Attempted to kill the idle task!

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
 
Linux mailserver 2.4.23-rc2 #2 Mon Nov 24 10:17:07 CET 2003 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
pcmcia-cs              3.1.33
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 9
cpu MHz		: 2398.888
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4784.12

[7.3.] Module information (from /proc/modules):

No modules.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0400-041f : Intel Corp. 82801EB SMBus Controller
0cf8-0cff : PCI conf1
e800-e8ff : 3Com Corporation Gigabit Ethernet Adapter
  e800-e8ff : SysKonnect SK-98xx
efa0-efaf : Alliance Semiconductor Corporation ProMotion AT3D
fc00-fc0f : Intel Corp. 82801EB Ultra ATA Storage Controller
  fc00-fc07 : ide0
  fc08-fc0f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c93ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-002761fd : Kernel code
  002761fe-002eb837 : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
20000000-200003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
fc4f0000-fc4fffff : LSI Logic / Symbios Logic PowerEdge Expandable RAID Controller 4
  fc4f0000-fc4f007f : MegaRAID: LSI Logic Corporation.
fd000000-fdffffff : Alliance Semiconductor Corporation ProMotion AT3D
fe6dc000-fe6dffff : 3Com Corporation Gigabit Ethernet Adapter
  fe6dc000-fe6dffff : SysKonnect SK-98xx
fe800000-febfffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
ffb80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fe800000 (32-bit, prefetchable) [size=4M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc600000-fe6fffff
	Prefetchable memory behind bridge: fc400000-fc4fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 0400 [size=32]

02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
	Subsystem: Asustek Computer, Inc.: Unknown device 80eb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5750ns min, 7750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe6dc000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at e800 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

02:09.0 VGA compatible controller: Alliance Semiconductor Corporation ProMotion AT3D (rev 02) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at efa0 [size=16]
	Expansion ROM at fe6f0000 [disabled] [size=64K]

02:0c.0 RAID bus controller: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1960 (rev 01)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0520
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fc4f0000 (32-bit, prefetchable) [size=64K]
	Expansion ROM at fe6e0000 [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID5 70006R Rev: 1L19
  Type:   Direct-Access                    ANSI SCSI revision: 02

G·bor
