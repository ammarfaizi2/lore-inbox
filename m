Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132523AbRAPTuq>; Tue, 16 Jan 2001 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRAPTug>; Tue, 16 Jan 2001 14:50:36 -0500
Received: from i.am.the.linux.master.at.devicen.de ([62.159.186.224]:640 "EHLO
	olibox.devicen.de") by vger.kernel.org with ESMTP
	id <S132523AbRAPTu3>; Tue, 16 Jan 2001 14:50:29 -0500
Date: Tue, 16 Jan 2001 20:47:16 +0100
From: root <root@olibox.devicen.de>
Message-Id: <200101161947.f0GJlG300618@olibox.devicen.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.1-pre7 hard freeze
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: 2.4.1-pre7 hard freeze

[1.] One line summary of the problem:    
Hard freeze

[2.] Full description of the problem/report:
Hard freeze while working on the console.
2.2.18 runs without any problem on this computer.

[3.] Keywords (i.e., modules, networking, kernel):
kernel

[4.] Kernel version (from /proc/version):
Linux version 2.4.1-pre7 (root@olibox) (gcc version 2.95.2 19991024 (release)) #3 Tue Jan 16 20:11:10 CET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
no Oops ...

[6.] A small shell script or example program which triggers the
     problem (if possible)
none

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux olibox 2.4.1-pre7 #3 Tue Jan 16 20:11:10 CET 2001 i686 unknown
Kernel modules         2.3.20
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4071014 Dec 30 13:22
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         epic100 nls_iso8859-1

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 448.831
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr sse
bogomips        : 894.56

[7.3.] Module information (from /proc/modules):
epic100                14294   1 (autoclean)
nls_iso8859-1           3536   3 (autoclean)

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
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e8ff : Standard Microsystems Corp [SMC] 83C170QF
  e800-e8ff : eth0
ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]
  ec00-ec3f : es1371

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-00243ced : Kernel code
  00243cee-0034448b : Kernel data
d8000000-dbffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation Riva TnT2 [NV5]
de000000-dfffffff : PCI Bus #01
  de000000-dfffffff : nVidia Corporation Riva TnT2 [NV5]
e1000000-e1000fff : Standard Microsystems Corp [SMC] 83C170QF
  e1000000-e1000fff : eth0

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: de000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 07)
	Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 06)
	Subsystem: Standard Microsystems Corp [SMC] EtherPower II 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 7000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e0000000 [disabled] [size=64K]

00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c28
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at de000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: de000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 07)
	Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 06)
	Subsystem: Standard Microsystems Corp [SMC] EtherPower II 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 7000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e0000000 [disabled] [size=64K]

00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c28
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at de000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: H.41
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     2.1e
South Bridge:                       VIA vt82c596a rev 0x7
Command register:                   0x7
Latency timer:                      32
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
FIFO Output Data 1/2 Clock Advance: off
BM IDE Status Register Read Retry:  on
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:           on                  on
End Sect. FIFO flush:          on                  on
Prefetch Buffer:               on                  on
Post Write Buffer:             on                  on
FIFO size:                      8                   8
Threshold Prim.:              1/2                 1/2
Bytes Per Sector:             512                 512
Both channels togth:          yes                 yes
-------------------drive0----drive1----drive2----drive3-----
BMDMA enabled:        yes       yes       yes        no
Transfer Mode:       UDMA      UDMA   DMA/PIO   DMA/PIO
Address Setup:       30ns      30ns      30ns     120ns
Active Pulse:        90ns      90ns      90ns     330ns
Recovery Time:       30ns      30ns      30ns     270ns
Cycle Time:          60ns      60ns     120ns     600ns
Transfer Rate:   33.0MB/s  33.0MB/s  16.5MB/s   3.3MB/s


[X.] Other notes, patches, fixes, workarounds:
i installed sgi-kdb to get some information,
but my motherboards nmi doesnt work.
the freeze occurs with and without sgi-kdb.


Thank you
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
