Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTDDUd7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTDDUd7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:33:59 -0500
Received: from mail.gmx.net ([213.165.65.60]:57196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261353AbTDDUdK convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:33:10 -0500
From: ra odigio <ra.odigio-news@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: sudden reboot without obvious reason (2.4.18-24.7.x)
Date: Fri, 4 Apr 2003 22:06:34 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304042206.34908.ra.odigio-news@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] sudden reboot without obvious reason

[2.] while running only a math ablication (folding@home) a sudden reboot 
appeared. Used the 2.4.18-24.7.x kernel from Red Hat(7.3) with some modules 
removed and the rest compiled into the kernel.

[3.] sudden reboot

[4.] Linux version 2.4.18-24.7.c (root@localhost.localdomain) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #4 三 4月 2 11:06:14 UTC 2003

[7.1]#########################################################################
Linux localhost.localdomain 2.4.18-24.7.c #4 三 4月 2 11:06:14 UTC 2003 i686 
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         slamrmo slmdm bc_cast bc_rijn bc_idea bc_3des bc_bf128 
bc_bf448 bc_twofish bc_gost bc_des bc_blowfish bc

[7.2]######################################################################### 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 10
cpu MHz		: 897.754
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
mmx fxsr sse
bogomips	: 1789.13

[7.3]######################################################################### 
slamrmo               190528   0 (unused)
slmdm                2367820   0 [slamrmo]
bc_cast                17568   0 (unused)
bc_rijn                32608   0 (unused)
bc_idea                 7744   0 (unused)
bc_3des                16192   0 (unused)
bc_bf128               10880   0 (unused)
bc_bf448               10848   1
bc_twofish             18976   0 (unused)
bc_gost                 6112   0 (unused)
bc_des                 15744   0 (unused)
bc_blowfish            10880   0 (unused)
bc                     17832   2 [bc_cast bc_rijn bc_idea bc_3des bc_bf128 
bc_bf448 bc_twofish bc_gost bc_des bc_blowfish]

[7.4]#########################################################################
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1100-110f : Silicon Integrated Systems [SiS] 5513 [IDE]
  1100-1107 : ide0
  1108-110f : ide1
3100-31ff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
3200-32ff : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 
compatible)
  3200-32ff : SiS630
3300-337f : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 
compatible)
  3300-337f : SiS630
3400-34ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
a000-afff : PCI Bus #01
  a000-a07f : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ccfff : Extension ROM
000cd000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0efeffff : System RAM
  00100000-002e7b84 : Kernel code
  002e7b85-003d3cc3 : Kernel data
0eff0000-0effffbf : ACPI Tables
0effffc0-0effffff : ACPI Non-volatile Storage
30000000-33ffffff : Silicon Integrated Systems [SiS] 630 Host
34001000-34001fff : Silicon Integrated Systems [SiS] 7001
34002000-34002fff : Silicon Integrated Systems [SiS] 7001 (#2)
34003000-34003fff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
34004000-340040ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
40000000-4f0fffff : PCI Bus #01
  40000000-47ffffff : Silicon Integrated Systems [SiS] SiS630 GUI 
Accelerator+3D
50000000-560fffff : PCI Bus #01
  50000000-5001ffff : Silicon Integrated Systems [SiS] SiS630 GUI 
Accelerator+3D
fffc0000-ffffffff : reserved

[7.5]#########################################################################
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 128
	Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x2

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 8a [Master SecP PriP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B 
step)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 1100 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (20000ns max)
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at 34001000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (20000ns max)
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at 34002000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI 
Audio Accelerator (rev 02)
	Subsystem: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (500ns min, 6000ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 3100 [size=256]
	Region 1: Memory at 34003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.6 Modem: Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link 
HAMR5600 compatible) (rev a0) (prog-if 00 [Generic])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at 3200 [size=256]
	Region 1: I/O ports at 3300 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: 50000000-560fffff
	Prefetchable memory behind bridge: 40000000-4f0fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C 
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3400 [size=256]
	Region 1: Memory at 34004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI 
Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	BIST result: 00
	Region 0: Memory at 40000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at 50000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at a000 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[X.] The modules of and slmdm-2.7.2, slmdm-amr-2.7.2 and BestCrypt-1.2.2 are 
used.
