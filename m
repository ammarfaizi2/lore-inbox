Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130058AbRBBVIv>; Fri, 2 Feb 2001 16:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRBBVId>; Fri, 2 Feb 2001 16:08:33 -0500
Received: from mail.gcecisp.com ([216.228.128.31]:61964 "HELO mail.gcecisp.com")
	by vger.kernel.org with SMTP id <S130058AbRBBVIT>;
	Fri, 2 Feb 2001 16:08:19 -0500
Message-ID: <3A7B225B.5BFE3771@gcecisp.com>
Date: Fri, 02 Feb 2001 15:10:51 -0600
From: virii <virii@gcecisp.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: svgalib problem
Content-Type: multipart/mixed;
 boundary="------------634AA90D0C68C0E3C7E114E6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------634AA90D0C68C0E3C7E114E6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit



--------------634AA90D0C68C0E3C7E114E6
Content-Type: text/plain; charset=iso-8859-15;
 name="report"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="report"

Can't view pictures in console with zgv or seejpeg

root@virii:/home/virii/images# seejpeg logo.jpg
svgalib: mmap error in paged screen memory.
root@virii:/home/virii/images# zgv logo.jpg
svgalib: mmap error in paged screen memory.

2.4.1 same problem in 2.4.0

svgalib: mmap error in paged screen memory.

zgv or seejpeg 

console 

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux virii 2.4.1 #2 SMP Fri Feb 2 13:27:47 CST 2001 i586 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79
Binutils               2.10.1.0.2
Linux C Library        2.2.1
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ppp_synctty pppox ppp_deflate ppp_async bsd_comp ppp_generic slip cmpci soundcore

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 522.818
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 1042.02

ppp_synctty             5184   0 (unused)
pppox                   1392   0 (unused)
ppp_deflate            39200   0
ppp_async               6128   1
bsd_comp                4144   0
ppp_generic            18304   3 [ppp_synctty pppox ppp_deflate ppp_async bsd_comp]
slip                    8192   0 (unused)
cmpci                  23456   0
soundcore               4240   4 [cmpci]

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0330-0331 : cmpci Midi
0376-0376 : ide1
0378-037a : parport0
0388-038b : cmpci FM
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  cc00-cc7f : Silicon Integrated Systems [SiS] 6306 3D-AGP
dc00-dcff : C-Media Electronics Inc CM8738
  dc00-dcff : cmpci
de00-de3f : C-Media Electronics Inc CM8738
ffa0-ffaf : Silicon Integrated Systems [SiS] 5513 [IDE]



00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e7e00000-e7efffff
	Prefetchable memory behind bridge: fec00000-ffcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CM8738
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at de00 [size=64]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk+ DSI- D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable+ DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev a3) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Region 0: Memory at ff000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at e7ef0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at cc00 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


--------------634AA90D0C68C0E3C7E114E6--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
