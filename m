Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135792AbREBUWp>; Wed, 2 May 2001 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135795AbREBUWf>; Wed, 2 May 2001 16:22:35 -0400
Received: from imladris.infradead.org ([194.205.184.45]:48912 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S135792AbREBUW0>;
	Wed, 2 May 2001 16:22:26 -0400
X-Originating-IP: [213.201.141.5]
From: "Toshio Spoor" <t_spoor@hotmail.com>
To: rhw@memalpha.cx
Subject: bug-report: reboot hangs system
Date: Wed, 18 Apr 2001 12:39:11 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F277rjcxtniFKU0000c4e1@hotmail.com>
X-OriginalArrivalTime: 18 Apr 2001 12:39:12.0132 (UTC) FILETIME=[9200BC40:01C0C804]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riley,

I am not sure if I should have send this bug-report to you. I hope you don't 
mind.
If you do could you send me the correct email adress.

Many thanks in advance.

Toshio

[1.] One line summary of the problem:

Reboot command hangs system.

[2.] Full description of the problem/report:

After I issue the command "reboot" from the prompt the system closes down 
normally.
Then the system says : "Restarting system.. ". The screen becomes black and 
system hangs.

init 0 works correctly system shuts down normally.

I already tried possible kernel-parameters : reboot=[c|w],[b|h]

Problems only seems to happen on the IBM's I have here.

IBM GL300
IBM Aptiva (machine in this BUG-REPORT)

The system has the latest patches from RH.

[3.] Keywords (i.e., modules, networking, kernel):

Kernel

[4.] Kernel version (from /proc/version):

Linux version 2.4.3 (root@mysystem) (gcc version 2.96 20000731 (Red Hat 
Linux 7.0)) #1 Mon Apr 2 14:50:23 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

#reboot [enter]

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux sunspot 2.4.3 #1 Mon Apr 2 14:50:23 CEST 2001 i686 unknown

Gnu C                 2.96
Gnu make           3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils             2.3.21
e2fsprogs           1.18
pcmcia-cs           3.1.19
PPP                    2.3.11
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 233.346
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
mmx
bogomips        : 465.30

[7.3.] Module information (from /proc/modules):

$null

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
1000-100f : Intel Corporation 82371AB PIIX4 IDE
1200-123f : Intel Corporation 82371AB PIIX4 ACPI
1240-125f : Intel Corporation 82371AB PIIX4 ACPI
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
3000-307f : 3Com Corporation 3c905C-TX [Fast Etherlink] (#2)
  3000-307f : eth1
3080-30ff : 3Com Corporation 3c905C-TX [Fast Etherlink]
  3080-30ff : eth0
3100-311f : Intel Corporation 82371AB PIIX4 USB

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00200ceb : Kernel code
  00200cec-00256b5b : Kernel data
20000000-200fffff : PCI Bus #01
  20000000-20000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
20100000-201fffff : Cirrus Logic CS 4610/11 [CrystalClear SoundFusion Audio 
Accelerator]
20200000-20200fff : Cirrus Logic CS 4610/11 [CrystalClear SoundFusion Audio 
Accelerator]
20201000-2020107f : 3Com Corporation 3c905C-TX [Fast Etherlink] (#2)
20201080-202010ff : 3Com Corporation 3c905C-TX [Fast Etherlink]
21000000-21ffffff : PCI Bus #01
  21000000-21ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
f8000000-fbffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge 
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 20000000-200fffff
        Prefetchable memory behind bridge: 21000000-21ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at 3100 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at 3080 [size=128]
        Region 1: Memory at 20201080 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3000 [size=128]
        Region 1: Memory at 20201000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:12.0 Multimedia audio controller: Cirrus Logic CS 4610/11 [CrystalClear 
SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM CS4610 SoundFusion Audio Accelerator
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at 20100000 (32-bit, non-prefetchable) [size=1M]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc 3D Rage Pro AGP 1X/2X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at 21000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

$null

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

REDHAT v7.0 | Problems ?
Init                  | Problems ?


/proc/apm
1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
/proc/misc
175 agpgart
134 apm_bios

Relevant code	: process.c



_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.


