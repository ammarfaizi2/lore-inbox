Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbSKEI4j>; Tue, 5 Nov 2002 03:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbSKEI4i>; Tue, 5 Nov 2002 03:56:38 -0500
Received: from redrock.inria.fr ([138.96.248.51]:28628 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S264829AbSKEI40>;
	Tue, 5 Nov 2002 03:56:26 -0500
To: linux-kernel@vger.kernel.org, dwmw2@redhat.com, andrew.grover@intel.com,
       ptb@it.uc3m.es
Subject: ACPI does not switch off the laptop
SCF: #mh/Mailbox/outboxDate: Tue, 5 Nov 2002 09:51:45 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Message-Id: <20021105095145.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 05 Nov 2002 09:57:06 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I have just recently reported a problem with ACPI and X Windows on
a Sony Picturebook PCG-C1MHP computer. I have actually a second 
problem (much less annoying).

[1.] One line summary of the problem:
=====================================

ACPI does not switch off the computer.

[2.] Full description of the problem/report:
============================================

I have been told that this should be an ACPI problem but I'm not 100%
sure of it. The problem is that halting the problem (with the halt
command) does not switch the machine off after the reboot.


[3.] Keywords (i.e., modules, networking, kernel):
==================================================

Sony Picture book, Crusoe, ACPI, halt


[4.] Kernel version (from /proc/version):
=========================================

Linux version 2.4.20-pre10-ac2 (root@owens) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Mon Nov 4 21:12:53 CET 2002

[5.] Output of Oops.. message (if applicable) with symbolic information: 
========================================================================    

NA

[6.] A small shell script or example program which triggers the problem:
========================================================================

NA

[7.] Environment
================

Sony Picturebook PCG-C1MHP, Crusoe TM5800, ide disk IC25N030ATCS04-0
ATA/ATAPI IDE	: IDE PCI Bus Master ALi M5229

[7.1.] Software (add the output of the ver_linux script here):
==============================================================

owens:.../src/linux-2.4.20-rc1> sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux owens 2.4.20-pre10-ac2 #2 Mon Nov 4 21:12:53 CET 2002 i686 Transmeta(tm) Crusoe(tm) Processor TM5800 GenuineTMx86 GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.30-WIP
pcmcia-cs              3.2.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.0.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         trident ac97_codec soundcore ds yenta_socket pcmcia_core 8139too mii ospm_thermal ospm_battery ospm_ac_adapter ospm_busmgr

[7.2.] Processor information (from /proc/cpuinfo):
==================================================

owens:.../src/linux-2.4.20-rc1> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz         : 860.154
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1717.04


[7.3.] Module information (from /proc/modules):
===============================================

owens:.../src/linux-2.4.20-rc1> cat /proc/modules 
trident                25556   1 (autoclean)
ac97_codec              9640   0 (autoclean) [trident]
soundcore               3364   3 (autoclean) [trident]
ds                      6152   1
yenta_socket            8864   1
pcmcia_core            33632   0 [ds yenta_socket]
8139too                13480   1 (autoclean)
mii                     2192   0 (autoclean) [8139too]
ospm_thermal            5376   0 (unused)
ospm_battery            5364   0 (unused)
ospm_ac_adapter         1924   0 (unused)
ospm_busmgr            10932   0 [ospm_thermal ospm_battery ospm_ac_adapter]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
===========================================================================

owens:.../src/linux-2.4.20-rc1> cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-017f : Acer Laboratories Inc. [ALi] M5229 IDE
01f0-01ff : Acer Laboratories Inc. [ALi] M5229 IDE
  01f0-01f7 : ide0
0376-0376 : Acer Laboratories Inc. [ALi] M5229 IDE
03c0-03df : vga+
03f6-03f6 : Acer Laboratories Inc. [ALi] M5229 IDE
  03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1400-140f : Acer Laboratories Inc. [ALi] M5229 IDE
1800-18ff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
  1800-18ff : ALi Audio Accelerator
1c00-1cff : Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller
2000-20ff : PCI device 10cf:2011 (Citicorp TTI)
2400-24ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  2400-24ff : 8139too
2800-28ff : ATI Technologies Inc Radeon Mobility M6 LY
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : Acer Laboratories Inc. [ALi] M7101 PMU
8040-805f : Acer Laboratories Inc. [ALi] M7101 PMU

owens:.../src/linux-2.4.20-rc1> cat /proc/iomem 
00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dffff : reserved
000e0000-000e0fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller (#2)
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-001f662e : Kernel code
  001f662f-002649df : Kernel data
0eef0000-0eefbfff : ACPI Tables
0eefc000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
10000000-10000fff : Ricoh Co Ltd RL5c475
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
e8000000-e80fffff : Transmeta Corporation LongRun Northbridge
e8100000-e8100fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
e8101000-e8101fff : Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller
e8102000-e81027ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
e8102800-e81028ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e8102800-e81028ff : 8139too
e8103000-e8103fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
e8104000-e8107fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
e8110000-e811ffff : ATI Technologies Inc Radeon Mobility M6 LY
e8200000-e82fffff : PCI device 10cf:2011 (Citicorp TTI)
f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M6 LY
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
=============================================

owens:.../src/linux-2.4.20-rc1> sudo lspci -vv

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 02)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 02)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 1800 [size=256]
        Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8101000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1c00 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 Controller (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8102000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8104000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2000 [disabled] [size=256]
        Region 1: Memory at e8200000 (32-bit, non-prefetchable) [disabled] [size=1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2400 [size=256]
        Region 1: Memory at e8102800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2800 [size=256]
        Region 2: Memory at e8110000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8103000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if a0)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: [virtual] I/O ports at 01f0 [size=16]
        Region 1: [virtual] I/O ports at 03f4
        Region 2: [virtual] I/O ports at 0170 [size=16]
        Region 3: [virtual] I/O ports at 0374
        Region 4: I/O ports at 1400 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Sincerely,

--
Manuel Serrano

ps: I have noticed the same problem with all the kernel version I have tried
(2.4.19, 2.4.20pre10, 2.4.20rc1, 2.4.10pre10-ac2)
