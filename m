Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTHWMEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTHWMEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:04:40 -0400
Received: from kogut2.o2.pl ([212.126.20.58]:62647 "EHLO kogut2.o2.pl")
	by vger.kernel.org with ESMTP id S262884AbTHWMEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:04:32 -0400
Message-ID: <3F475892.8090708@go2.pl>
Date: Sat, 23 Aug 2003 14:05:38 +0200
From: Ukasz <prymitive@go2.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030808 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:hd? lost interrupt problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] hd? lost interrupt problem
[2.] Ripping audio cd's, installing some Linux distributions (RedHat 9),
accesing cdrom from VmWare 4 couses kernel to print "hd? lost interrupt"
(where ? stands for disk letter). This is less or more problematic
depend on when does it occur. When ripping cd's it slow the ripping
process, when installing RedHat 9 it slow's the install process and
after installing some packeges it susped it completly, the cd keep
spining but installation freezes and comuter stops responding, in VmWare
4 it couses system freezes every 10~20 seconds, there are also problems
while booting Knoppix, cd is not dameged and I can read it with no
problem in Windows or Linux, but when booting from it after reading some
data Knoppix prints read errors  and I'm preety sure that they're coused
by the same bug.
[3.] kernel / ide interrupts
[4.] 2.4.x 2.5.x 2.6.x
[7.] Mandrake Linux 9.1
[7.1]
Linux localhost 2.4.21-ck3-4 #4 wto sie 19 12:49:41 CEST 2003 i686
unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.22
e2fsprogs              1.32
reiserfsprogs          3.6.4
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         ppp_deflate zlib_deflate bsd_comp lt_serial
lt_modem nvidia vmnet vmmon snd-seq-midi snd-seq-oss snd-seq-midi-event
snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-pcm snd-page-alloc
snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd ppp_async
ppp_generic slhc
[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.929
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr
bogomips        : 799.53
[7.3]
ppp_deflate             3544   0 (autoclean)
zlib_deflate           18616   0 (autoclean) [ppp_deflate]
bsd_comp                4472   0 (autoclean)
lt_serial              20692   0 (autoclean)
lt_modem              472475   0 (autoclean) [lt_serial]
nvidia               1629664  11 (autoclean)
vmnet                  20456   6
vmmon                  22900   0 (unused)
snd-seq-midi            4128   0 (autoclean) (unused)
snd-seq-oss            30240   0 (unused)
snd-seq-midi-event      3808   0 [snd-seq-midi snd-seq-oss]
snd-seq                39888   2 [snd-seq-midi snd-seq-oss
snd-seq-midi-event]
snd-pcm-oss            39716   0
snd-mixer-oss          13752   0 [snd-pcm-oss]
snd-ens1371            12780   0
snd-pcm                64544   0 [snd-pcm-oss snd-ens1371]
snd-page-alloc          6708   0 [snd-pcm]
snd-timer              15588   0 [snd-seq snd-pcm]
snd-rawmidi            14528   0 [snd-seq-midi snd-ens1371]
snd-seq-device          4304   0 [snd-seq-midi snd-seq-oss snd-seq
snd-rawmidi]
snd-ac97-codec         42008   0 [snd-ens1371]
snd                    31556   0 [snd-seq-midi snd-seq-oss
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-pcm
snd-timer snd-rawmidi snd-seq-device snd-ac97-codec]
ppp_async               8064   0
ppp_generic            19004   0 [ppp_deflate bsd_comp ppp_async]
slhc                    5264   0 [ppp_generic]
[7.4]
ioport:
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
   e400-e43f : Ensoniq AudioPCI
e800-e807 : Lucent Microelectronics 56k WinModem
ec00-ecff : Lucent Microelectronics 56k WinModem
   ec00-ecff : ltserial
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
   f000-f007 : ide0
   f008-f00f : ide1
iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
   00100000-0023d82f : Kernel code
   0023d830-002872c3 : Kernel data
e0000000-e3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
e4000000-e5ffffff : PCI Bus #01
   e4000000-e4ffffff : nVidia Corporation RIVA TNT2 Model 64
e6000000-e7ffffff : PCI Bus #01
   e6000000-e7ffffff : nVidia Corporation RIVA TNT2 Model 64
     e6000000-e6752fff : vesafb
e8000000-e80000ff : Lucent Microelectronics 56k WinModem
ffff0000-ffffffff : reserved
[7.5]
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-
FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: e4000000-e5ffffff
         Prefetchable memory behind bridge: e6000000-e7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 0
         Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:10.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
         Latency: 64 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e400 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Communication controller: Lucent Microelectronics 56k WinModem
(rev 01)
         Subsystem: Lucent Microelectronics LT WinModem 56k
Data+Fax+Voice+Dsvd
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (63000ns min, 3500ns max)
         Interrupt: pin A routed to IRQ 12
         Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
         Region 1: I/O ports at e800 [size=8]
         Region 2: I/O ports at ec00 [size=256]
         Capabilities: [f8] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at e5000000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-
FW- Rate=x2
[X.] The problem only occurs when kernel config option
CONFIG_IDEPCI_SHARE_IRQ is selected, when I deselect it during kernel
configuration it disappears, this is sure to be true only for ripping
audio cd's/vmware 4 but I hope that fixing it will fix the rest.

Thanks, Lucas



