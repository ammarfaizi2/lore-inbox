Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRDQAnb>; Mon, 16 Apr 2001 20:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbRDQAnY>; Mon, 16 Apr 2001 20:43:24 -0400
Received: from eumenes.hosting.pacbell.net ([216.100.98.24]:16000 "EHLO
	eumenes.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S132471AbRDQAnI>; Mon, 16 Apr 2001 20:43:08 -0400
From: Dheeraj Reddy <dheeraj@tcs-america.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15067.37475.521188.293714@freak.tcs-america.com>
Date: Mon, 16 Apr 2001 17:46:27 -0700
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Real Audio doesn't work with 2.4.3 pre4
X-Mailer: VM 6.90 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am too inexperienced to file this, so pls excuse me. I am trying to follow
just the Documentation. 

1.> Audio doesn't work properly in linux-2.4.3 pre4 (i810_audio). [Real Audio]

2.> I tried to run it with patches applied on 2.4.2 kernel. I tested with pre1,
pre2 and pre4. The problem seems to be in pre4. I tried to use a console real
player. It just pops an error saying 
 i810_audio: DMA overrun on send.

3.> i810_audio, RealPlayer,  Sound. DMA

4.>cat /proc/version
  Linuxversion 2.4.3-pre4 (root@freak.tcs-america) gcc-version-2.96 20000731
  RedHAt Linux 7.0 #1

5.> Ooops.. I do not know how ??:-((

6.> use of trplayer. (A Terminal based RealPlayer).

7.>
  7.2> 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux freak.tcs-america.com 2.4.3-pre4 #1 Mon Apr 16 17:09:28 PDT 2001 i686 unknown
Kernel modules         2.3.14
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         


  7.3> NULL

  7.4> 
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d800-d8ff : Intel Corporation 82801AA AC'97 Audio
  d800-d8ff : Intel ICH 82801AA
dc80-dcbf : Intel Corporation 82801AA AC'97 Audio
  dc80-dcbf : Intel ICH 82801AA
dcd0-dcdf : Intel Corporation 82801AA SMBus
e000-efff : PCI Bus #01
  ec00-ec7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
    ec00-ec7f : eth0
  ecf8-ecff : CONEXANT 56K Winmodem
ff80-ff9f : Intel Corporation 82801AA USB
  ff80-ff9f : usb-uhci
ffa0-ffaf : Intel Corporation 82801AA IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1



00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-0feadfff : System RAM
  00100000-0021cd43 : Kernel code
  0021cd44-0028a517 : Kernel data
0feae000-0fefffff : reserved
0ff00000-0fffffff : reserved
f4000000-f7ffffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
f8000000-f9ffffff : PCI Bus #01
  f8000000-f9ffffff : nVidia Corporation Vanta [NV6]
fc000000-feffffff : PCI Bus #01
  fcfefc00-fcfefc7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  fcff0000-fcffffff : CONEXANT 56K Winmodem
  fd000000-fdffffff : nVidia Corporation Vanta [NV6]
ff000000-ff07ffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
ffb00000-ffffffff : reserved

7.5 > 

00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory Controller Hub] (rev 03)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4000000 (32-bit, prefetchable) [disabled] [size=64M]
	Region 1: Memory at ff000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
	Prefetchable memory behind bridge: f8000000-f9ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at dcd0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc80 [size=64]

01:07.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 0006
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f8000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Communication controller: CONEXANT 56K Winmodem (rev 08)
	Subsystem: GVC Corporation: Unknown device 020d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fcff0000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at ecf8 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=128]
	Region 1: Memory at fcfefc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fe000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

7.6 > No SCSI


As I said please excuse me if I am missing things.

Thanks in advance....

truely
dheeraj

PS: I shall be thankful if somebody tells me how better I could file a 
    report. Or if this is too stupid a big.
-- 
Tommorow's always better coz it means u've lived thru' today.
