Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRF1SuQ>; Thu, 28 Jun 2001 14:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRF1SuH>; Thu, 28 Jun 2001 14:50:07 -0400
Received: from law2-f118.hotmail.com ([216.32.181.118]:43784 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262389AbRF1Stx>;
	Thu, 28 Jun 2001 14:49:53 -0400
X-Originating-IP: [212.198.0.92]
From: "james bond" <difda@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: BIG PROBLEM 
Date: Thu, 28 Jun 2001 18:49:46 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F118HsRsWg8ubZ000077c1@hotmail.com>
X-OriginalArrivalTime: 28 Jun 2001 18:49:47.0072 (UTC) FILETIME=[1A639400:01C10003]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1-systeme hangs when i try ton compile anything

i've  compiled the kernel 2.4.4 , once i finish and boot the first time on 
2.4.4 everything goses ok ,
only too problemes
1st-  klogd takes 100%  CPU time
2nd- cat /proc/cpuinf --guives me too CPU'S  without putin any info about 
the CPU 1
like that  approximatively

--------------------------------------------

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 7
model name : Pentium III (Katmai)
stepping : 3
cpu MHz : 498.672
cache size : 512 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 2
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips : 992.87

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 7
model name :
stepping : 3
cpu MHz :
cache size :
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 3
wp : yes
flags           :
bogomips  :
--------------------------------------------


at the second boot it detects correctly CPU0 and CPU1



cat /proc/cpuinfo -->
-------------------------------------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 498.672
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
bogomips        : 992.87

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 498.672
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 mmx fxsr sse
bogomips        : 996.14
----------------------------------------
cat /proc/version -->
----------------------------------------
Linux version 2.4.4 (root@seraka) (gcc version 2.95.3 20010315 (release)) #2 
SMP Thu Jun 28 07:04:06 CEST 2001
----------------------------------------
cat /proc/modules --> nothing   cause im no using modules
----------------------------------------
cat /proc/ioports
-------------------------------0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
e400-e4ff : Adaptec 7892A00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d25ff : Extension ROM
000d3000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00245892 : Kernel code
  00245893-002ca41f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d8000000-dbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
dc000000-dfffffff : PCI Bus #01
  dc000000-dc003fff : Matrox Graphics, Inc. MGA G400 AGP
  dd000000-dd7fffff : Matrox Graphics, Inc. MGA G400 AGP
e0000000-e1ffffff : PCI Bus #01
  e0000000-e1ffffff : Matrox Graphics, Inc. MGA G400 AGP
e5000000-e5007fff : Yamaha Corporation YMF-724
e5008000-e5008fff : Adaptec AHA-2940U2/W
  e5008000-e5008fff : aic7xxx
e5009000-e5009fff : Adaptec 7892A
  e5009000-e5009fff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
------------------------------------------------
e800-e8ff : Adaptec AHA-2940U2/W
ec00-ec1f : 3Com Corporation 3c595 100BaseTX [Vortex]
ec00-ec1f : eth0
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
-----------------------
cat /proc/iomem  --->00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d25ff : Extension ROM
000d3000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00245892 : Kernel code
  00245893-002ca41f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d8000000-dbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
dc000000-dfffffff : PCI Bus #01
  dc000000-dc003fff : Matrox Graphics, Inc. MGA G400 AGP
  dd000000-dd7fffff : Matrox Graphics, Inc. MGA G400 AGP
e0000000-e1ffffff : PCI Bus #01
  e0000000-e1ffffff : Matrox Graphics, Inc. MGA G400 AGP
e5000000-e5007fff : Yamaha Corporation YMF-724
e5008000-e5008fff : Adaptec AHA-2940U2/W
  e5008000-e5008fff : aic7xxx
e5009000-e5009fff : Adaptec 7892A
  e5009000-e5009fff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
----------------------------------------------
lspci -vvv  --->



Expansion ROM at e2000000 [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
       Subsystem: Adaptec: Unknown device a180
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (9750ns min, 6250ns max), cache line size 08
       Interrupt: pin A routed to IRQ 17
       BIST result: 00
       Region 0: I/O ports at e800 [disabled] [size=256]
       Region 1: Memory at e5008000 (64-bit, non-prefetchable) [size=4K]
       Expansion ROM at e3000000 [disabled] [size=128K]
       Capabilities: [dc] Power Management version 1
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex]
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 248 (750ns min, 2000ns max)
       Interrupt: pin A routed to IRQ 18
       Region 0: I/O ports at ec00 [size=32]
       Expansion ROM at e4000000 [disabled] [size=64K]

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-724 (rev 05)
       Subsystem: Yamaha Corporation YMF724-Based PCI Audio Adapter
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (1250ns min, 6250ns max)
       Interrupt: pin A routed to IRQ 16
       Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=32K]
       Capabilities: [50] Power Management version 1
               Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
82) (prog-if 00 [VGA])
       Subsystem: Matrox Graphics, Inc.: Unknown device 0641
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (4000ns min, 8000ns max), cache line size 08
       Interrupt: pin A routed to IRQ 0
       Region 0: Memory at e0000000 (32-bit, prefetchable) [size=32M]
       Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
       Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=8M]
       Expansion ROM at <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [f0] AGP version 2.0
               Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
               Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
-----------------------------------------------------

cat /proc/scsi/scsi -->
-----------------------------------------------------
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: HB00931B93       Rev: A195
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-R820T  Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: COMPAQ   Model: HB00931B93       Rev: A195
  Type:   Direct-Access                    ANSI SCSI revision: 02
----------------------------------------------------

my motherboard is an Gigabyte GA-6BXD with f3 bios and my memory is 256  ECC 
,
so perhaps the defucnt is caused by the second CPU "CPU1" cause i hade somme 
probles with is ,


thank's for helping me caus i start to disespaire "sorry for my poor 
english"
and i don't wana use Miscosoft

with regards

---------------------------------------------------
please answer me @ battata.chafik@noos.fr thanks

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

