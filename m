Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTFVA0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 20:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTFVA0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 20:26:06 -0400
Received: from web20201.mail.yahoo.com ([216.136.226.56]:9265 "HELO
	web20201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264924AbTFVAZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 20:25:53 -0400
Message-ID: <20030622003957.29782.qmail@web20201.mail.yahoo.com>
Date: Sat, 21 Jun 2003 17:39:57 -0700 (PDT)
From: Gerardo Arnaez <garnaez@yahoo.com>
Subject: new 2.5.72 breaks aumix
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] kernel 2.5.72 breaks aumix
[2.]I have been using 2.5.69-ac1 on a HP pavilion
ze5285us laptop. i 
maintain a how-to on installing debian on it. I have
upgraded to the 
2.5.72 kernel. Now aumix will not longer work
[3.] aumix kernel sound
[4.]Linux version 2.5.72 (root@brick) (gcc version
2.95.4 20011002 
(Debian prerelease)) #1 Sat Jun 21 16:41:33 PDT 2003
[5.]N/A
[6.]
dude@brick:~$ aumix 
aumix:  error opening mixer
[7.]
[7.1]
Linux brick 2.5.72 #1 Sat Jun 21 16:41:33 PDT 2003
i686 unknown
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 util-linux             2.11n
 mount                  2.11n
 module-init-tools      2.4.15
 e2fsprogs              1.27
 pcmcia-cs              3.1.33
 Linux C Library        2.3.1
 Dynamic linker (ldd)   2.3.1
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.11
 Modules Loaded         
 
[7.2]
brick:/usr/src/linux/scripts# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 7
cpu MHz         : 2659.333
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
ht tm pbe cid
bogomips        : 5210.11
[7.3]
brick:/usr/src/linux/scripts# cat /proc/modules 
brick:/usr/src/linux/scripts# 
[7.4]
brick:/usr/src/linux/scripts# cat /proc/ioports 
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
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : ALi Corporation M5451 PCI AC-Link Co
  1000-10ff : ALI 5451
1400-14ff : ALi Corporation M5457 AC-Link Modem 
2000-201f : VIA Technologies, In USB
  2000-201f : uhci-hcd
2020-203f : VIA Technologies, In USB (#2)
  2020-203f : uhci-hcd
2040-204f : ALi Corporation M5229 IDE
  2040-2047 : ide0
  2048-204f : ide1
2400-24ff : National Semiconduct DP83815 (MacPhyter) 
    2400-24ff : eth0
8000-803f : ALi Corporation M7101 PMU
8040-805f : ALi Corporation M7101 PMU
9000-9fff : PCI Bus #01
  9000-90ff : PCI device 1002:4337 (ATI Technologies
Inc)

brick:/# cat /proc/iomem 
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cf000-000cf7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1bf6ffff : System RAM
00100000-002ab15a : Kernel code
002ab15b-0036137f : Kernel data
1bf70000-1bf7bfff : ACPI Tables
1bf7c000-1bf7ffff : ACPI Non-volatile Storage
1bf80000-1bffffff : reserved
2bf80000-2bffffff : reserved
d0000000-d0000fff : ALi Corporation M5451 PCI AC-Link
Co
d0001000-d0001fff : ALi Corporation M5457 AC-Link
Modem 
d0002000-d0002fff : O2 Micro, Inc. OZ6912 Cardbus
Contr
d0003000-d00030ff : VIA Technologies, In USB 2.0
d0003000-d00030ff : ehci-hcd
d0003800-d0003fff : Texas Instruments TSB43AB21
IEEE-1394a
d0004000-d0007fff : Texas Instruments TSB43AB21
IEEE-1394a
d0008000-d0008fff : National Semiconduct DP83815
(MacPhyter) 
d0008000-d0008fff : eth0
d0009000-d0009fff : PCI device 1002:cbb2 (ATI
Technologies Inc)
d000a000-d000afff : Harris Semiconductor Prism 2.5
Wavelan ch
d0300000-d03fffff : PCI Bus #01
 d0300000-d030ffff : PCI device 1002:4337 (ATI
Technologies Inc)
 d4000000-d7ffffff : PCI device 1002:cbb2 (ATI
Technologies Inc)
 d8000000-dfffffff : PCI Bus #01
 d8000000-dfffffff : PCI device 1002:4337 (ATI
Technologies Inc)
 d8000000-dbfeffff : vesafb
fff80000-ffffffff : reserved
[7.5]

00:00.0 Host bridge: ATI Technologies Inc: Unknown
device cbb2 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable)
[size=64M]
	Region 1: Memory at d0009000 (32-bit, prefetchable)
[size=4K]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh-
GART64- HTrans- 64bit- 
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>

00:01.0 PCI bridge: ATI Technologies Inc: Unknown
device 7010 (prog-if 
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset-
FastB2B-

00:06.0 Multimedia audio controller: ALi Corporation
M5451 PCI AC-Link 
Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0000000 (32-bit,
non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA
Bridge [Aladdin 
IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA
Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: ALi Corporation Intel 537 [M5457
AC-Link Modem] (prog-if 
00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d0001000 (32-bit,
non-prefetchable) [disabled] 
[size=4K]
	Region 1: I/O ports at 1400 [disabled] [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: Harris Semiconductor Prism
2.5 Wavelan 
chipset (rev 01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device
0200
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d000a000 (32-bit, prefetchable)
[size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus
Controller
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow
>TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0002000 (32-bit,
non-prefetchable) [disabled] 
[size=4K]
	Bus: primary=00, secondary=02, subordinate=05,
sec-latency=176
	Memory window 0: d0200000-d02ff000 [disabled]
	Memory window 1: d0100000-d01ff000 [disabled]
	I/O window 0: 00001c00-00001cff [disabled]
	I/O window 1: 00001800-000018ff [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-
16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0b.0 USB Controller: VIA Technologies, Inc. USB
(rev 50) (prog-if 00 
[UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 2000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: VIA Technologies, Inc. USB
(rev 50) (prog-if 00 
[UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 2020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0
(rev 51) 
(prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 20
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d0003000 (32-bit,
non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 FireWire (IEEE 1394): Texas Instruments
TSB43AB21 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10
[OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0003800 (32-bit,
non-prefetchable) [disabled] 
[size=2K]
	Region 1: Memory at d0004000 (32-bit,
non-prefetchable) [disabled] 
[size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev
c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 2040 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 Ethernet controller: National Semiconductor
Corporation DP83815 
(MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at d0008000 (32-bit,
non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies
Inc Radeon IGP 340M 
(prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device
0850
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d8000000 (32-bit, prefetchable)
[size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0300000 (32-bit,
non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh-
GART64- HTrans- 64bit- 
FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit-
FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6]
brick:/home/dude# cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QSI      Model: CDRW/DVD SBW-241 Rev: VX08
  Type:   CD-ROM                           ANSI SCSI
revision: 02

[7.7] Dont know
[X.] None have worked

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
