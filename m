Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbTJKNtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTJKNtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:49:46 -0400
Received: from firecrest.mail.pas.earthlink.net ([207.217.121.247]:26618 "EHLO
	firecrest.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263319AbTJKNtT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:49:19 -0400
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: linux-kernel@vger.kernel.org
Subject: Apparent Scheduler problem when using nforce based mobos - kernel 2.6.0-test7-bk2
Date: Sat, 11 Oct 2003 09:47:47 -0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310110947.52648.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9efa50bfe5b48a2bce4459becab53e6ea48350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Apparent Scheduler problem when using nforce based mobos

2. When running any version of the 2.6.0 kernel, the computer is 
subject to freezing when xmms and any acceserated graphics are 
occuring at the same time. Symptoms include sound skipping and 
screen freezes. If allowed to go long enough, the computer 
freezes solid and I am unable to even ssh in.

3. Scheduler Sound OpenGL Alsa Nforce

4. Linux version 2.6.0-test7-bk2 
(root@fierywyrme.lamasondufeu.com) (gcc version 3.3.1 20030916 
(Gentoo Linux 3.3.1-r4, propolice)) #1 Sat Oct 11 00:08:39 EDT 
2003

5. unavailable

6. not applicable

7.1 Linux fierywyrme.lamasondufeu.com 2.6.0-test7-bk2 #1 Sat Oct 
11 00:08:39 EDT 2003 i686 AMD Athlon(TM) XP 1900+ AuthenticAMD 
GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre1
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.3.9
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         snd_pcm_oss snd_mixer_oss nvidia parport_pc 
lp parport w83781d i2c_sensor i2c_amd756 i2c_dev i2c_core 
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device smbfs ide_scsi 8139too 
mii

7.2processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1900+
stepping        : 2
cpu MHz         : 1603.440
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 
3dnow
bogomips        : 3162.11

7.3 snd_pcm_oss 52516 - - Live 0xf8db9000
snd_mixer_oss 18528 - - Live 0xf8da2000
nvidia 1700876 - - Live 0xf8e9c000
parport_pc 40700 - - Live 0xf8cc0000
lp 10592 - - Live 0xf8c9d000
parport 42984 - - Live 0xf8ca6000
w83781d 35296 - - Live 0xf89e1000
i2c_sensor 2688 - - Live 0xf8955000
i2c_amd756 5476 - - Live 0xf899e000
i2c_dev 10080 - - Live 0xf899a000
i2c_core 24296 - - Live 0xf89a3000
snd_intel8x0 31684 - - Live 0xf8989000
snd_ac97_codec 53956 - - Live 0xf89d2000
snd_pcm 98724 - - Live 0xf89b8000
snd_timer 24836 - - Live 0xf8992000
snd_page_alloc 11524 - - Live 0xf8966000
snd_mpu401_uart 7552 - - Live 0xf8963000
snd_rawmidi 24576 - - Live 0xf896c000
snd_seq_device 7848 - - Live 0xf8949000
smbfs 68056 - - Live 0xf8977000
ide_scsi 14752 - - Live 0xf895e000
8139too 22688 - - Live 0xf8957000
mii 4800 - - Live 0xf894c000

7.4 0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : 0000:00:01.1
5100-511f : 0000:00:01.1
5500-550f : 0000:00:01.1
  5500-550f : amd756-smbus
9800-980f : 0000:00:09.0
  9800-9807 : ide0
  9808-980f : ide1
a000-bfff : PCI Bus #01
  a000-a00f : 0000:01:07.0
    a000-a007 : ide2
    a008-a00f : ide3
  a400-a403 : 0000:01:07.0
    a402-a402 : ide3
  a800-a807 : 0000:01:07.0
    a800-a807 : ide3
  b000-b003 : 0000:01:07.0
    b002-b002 : ide2
  b400-b407 : 0000:01:07.0
    b400-b407 : ide2
  b800-b8ff : 0000:01:06.0
    b800-b8ff : 8139too
d800-d807 : 0000:00:04.0
e000-e07f : 0000:00:06.0
  e000-e03f : NVidia nForce - Controller
e100-e1ff : 0000:00:06.0

00000000-0007ffff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3dfebfff : System RAM
  00100000-0038e4ca : Kernel code
  0038e4cb-004684ff : Kernel data
3dfec000-3dfeefff : ACPI Tables
3dfef000-3dffefff : reserved
3dfff000-3dffffff : ACPI Non-volatile Storage
db000000-dbffffff : PCI Bus #02
  db000000-dbffffff : 0000:02:00.0
dc000000-dcffffff : PCI Bus #01
  dc000000-dc003fff : 0000:01:07.0
  dc800000-dc8000ff : 0000:01:06.0
    dc800000-dc8000ff : 8139too
dd000000-dd000fff : 0000:00:06.0
  dd000000-dd0001ff : NVidia nForce - AC'97
dd800000-dd87ffff : 0000:00:05.0
de000000-de0003ff : 0000:00:04.0
de800000-de800fff : 0000:00:03.0
df000000-df000fff : 0000:00:02.0
dff00000-efefffff : PCI Bus #02
  e0000000-e7ffffff : 0000:02:00.0
eff00000-efffffff : PCI Bus #01
f0000000-f7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5 00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev 
b2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) 
[size=128M]
        Capabilities: [40] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- 
GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 
64bit- FW- Rate=x4
        Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory 
Controller (rev b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory 
Controller (rev b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev 
b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [50] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce PCI System Management 
(rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 5000 [size=16]
        Region 1: I/O ports at 5500 [size=16]
        Region 2: I/O ports at 5100 [size=32]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce USB Controller 
(rev c3) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory at df000000 (32-bit, non-prefetchable) 
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0
+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: nVidia Corporation nForce USB Controller 
(rev c3) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory at de800000 (32-bit, non-prefetchable) 
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0
+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet 
Controller (rev c2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory at de000000 (32-bit, non-prefetchable) 
[size=1K]
        Region 1: I/O ports at d800 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0
+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation: Unknown 
device 01b0 (rev c2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at dd800000 (32-bit, non-prefetchable) 
[size=512K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce 
Audio (rev c2)
        Subsystem: Asustek Computer, Inc.: Unknown device 8384
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: I/O ports at e100 [size=256]
        Region 1: I/O ports at e000 [size=128]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable) 
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge 
(rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, 
sec-latency=0
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: dc000000-dcffffff
        Prefetchable memory behind bridge: eff00000-efffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- 
FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) 
(prog-if 8a [Master SecP PriP])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at 9800 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge 
(rev b2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, 
sec-latency=64
        I/O behind bridge: 00009000-00008fff
        Memory behind bridge: db000000-dbffffff
        Prefetchable memory behind bridge: dff00000-efefffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- 
FastB2B-

01:06.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet 
(rev 10)
        Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet 
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 96 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at dc800000 (32-bit, non-prefetchable) 
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.0 Unknown mass storage controller: Promise Technology, Inc. 
20269 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at b400 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at a800 [size=8]
        Region 3: I/O ports at a400 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at dc000000 (32-bit, non-prefetchable) 
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 VGA compatible controller: nVidia Corporation NV15 
[GeForce2 - nForce GPU] (rev b1) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at db000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) 
[size=128M]
        Expansion ROM at dfff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- 
GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 
64bit- FW- Rate=x4

7.6 Attatched devices:

7.7
# cat /proc/interrupts
                          CPU0
  0:    4046067          XT-PIC  timer
  1:       7061    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      94716    IO-APIC-edge  i8042
 14:      13638    IO-APIC-edge  ide0
 15:         32    IO-APIC-edge  ide1
 19:       4473   IO-APIC-level  eth0
 20:       2341   IO-APIC-level  ide2, ide3
 27:     250601   IO-APIC-level  NVidia nForce, nvidia
NMI:          0
LOC:    4045810
ERR:          0
MIS:          0

# dmidecode 1.8
PCI Interrupt Routing 1.0 present.
        Table Size: 192 bytes
        Router ID: 00:01.0
        Exclusive IRQs: None
        Compatible Router: 10de:01b2
BIOS32 Service Directory present.
        Calling Interface Address: 0x000F1940
SMBIOS 2.3 present.
DMI 2.3 present.
40 structures occupying 1195 bytes.
DMI table at 0x000F3B30.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: Award Software, Inc.
                Version: ASUS A7N266-VM ACPI BIOS Rev 1007
                Release: 08/12/2003
                BIOS base: 0xF0000
                ROM size: 256K
                Capabilities:
                        Flags: 0x000000007FCBDA80
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: System Manufacturer
                Product: System Name
                Version: System Version
                Serial Number: SYS-1234567890
Handle 0x0002
        DMI type 2, 8 bytes.
        Board Information Block
                Vendor: ASUSTeK Computer INC.
                Product: A7N266VM
                Version: REV 1.xx
                Serial Number: xxxxxxxxxxx
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information Block
                Vendor: Chassis Manufacture
                Chassis Type: Tower
                Version: Chassis Version
                Serial Number: Chassis Serial Number
                Asset Tag: Asset-1234567890
Handle 0x0004
        DMI type 4, 32 bytes.
        Processor
                Socket Designation: SOCKET A
                Processor Type: Central Processor
                Processor Family: Other
                Processor Manufacturer: AuthenticAMD
                Processor Version: AMD Athlon(TM) XP Processor
Handle 0x0005
        DMI type 5, 20 bytes.
        Memory Controller
Handle 0x0006
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM 1
                Banks: 0 1
                Type:
                Installed Size: 512Mbyte
                Enabled Size: 512Mbyte
Handle 0x0007
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM 2
                Banks: 2 3
                Type:
                Installed Size: 512Mbyte
                Enabled Size: 512Mbyte
Handle 0x0008
        DMI type 7, 19 bytes.
        Cache
                Socket: L1 Cache
                L1 Internal Cache: write-back
                L1 Cache Size: 128K
                L1 Cache Maximum: 128K
                L1 Cache Type: Synchronous
Handle 0x0009
        DMI type 7, 19 bytes.
        Cache
                Socket: L2 Cache
                L2 Internal Cache: write-back
                L2 Cache Size: 384K
                L2 Cache Maximum: 8192K
                L2 Cache Type: Pipeline burst Synchronous
Handle 0x000A
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: PRIMARY IDE/HDD
                Internal Connector Type: On Board IDE
                External Designator:
                External Connector Type: None
                Port Type: None
Handle 0x000B
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: SECONDARY IDE/HDD
                Internal Connector Type: On Board IDE
                External Designator:
                External Connector Type: None
                Port Type: None
Handle 0x000C
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: FLOPPY
                Internal Connector Type: On Board Floppy
                External Designator:
                External Connector Type: None
                Port Type: None
Handle 0x000D
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: LAN-00E018EDF4FFR
                External Connector Type: RJ-45
                Port Type: Network Port
Handle 0x000E
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: USB1
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000F
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: USB2
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0010
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: PS/2 Keyboard
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x0011
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: PS/2 Mouse
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x0012
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: Parallel Port
                External Connector Type: DB-25 pin female
                Port Type: Parallel Port ECP/EPP
Handle 0x0013
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: Serial Port 1
                External Connector Type: DB-9 pin male
                Port Type: Serial Port 16550 Compatible
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: Serial Port 2
                External Connector Type: DB-9 pin male
                Port Type: Serial Port 16550 Compatible
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: Joystick Port
                External Connector Type: DB-15 pin female
                Port Type: Joy Stick Port
Handle 0x0016
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: MIDI Port
                External Connector Type: DB-15 pin female
                Port Type: MIDI Port
Handle 0x0017
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator:
                Internal Connector Type: None
                External Designator: Video Port
                External Connector Type: Mini-jack (headphones)
                Port Type: Video Port
Handle 0x0018
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI 1
                Type: 32bit Short PCI
                Status: In use.
                Slot Features: 5v 3.3v
Handle 0x0019
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI 2
                Type: 32bit Short PCI
                Status: In use.
                Slot Features: 5v 3.3v
Handle 0x001A
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI 3
                Type: 32bit Short PCI
                Status: Available.
                Slot Features: 5v 3.3v
Handle 0x001B
        DMI type 9, 13 bytes.
        Card Slot
                Slot: AGP
                Type: 32bit Short AGP 4x
                Status: Available.
                Slot Features: 3.3v
Handle 0x001C
        DMI type 11, 5 bytes.
        OEM Data
                0
                0
Handle 0x001D
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 1
                        en|US|iso8859-1
                Currently Installed Language: en|US|iso8859-1
Handle 0x001E
        DMI type 14, 14 bytes.
        Group Associations
                Group Name: Cpu Module
                        Type: 0x04
                        Handle: 0x0004
                Group Name: Cpu Module
                        Type: 0x07
                        Handle: 0x0008
                Group Name: Cpu Module
                        Type: 0x07
                        Handle: 0x0009
Handle 0x001F
        DMI type 14, 23 bytes.
        Group Associations
                Group Name: Memory Module Set
                        Type: 0x10
                        Handle: 0x0020
                Group Name: Memory Module Set
                        Type: 0x11
                        Handle: 0x0021
                Group Name: Memory Module Set
                        Type: 0x14
                        Handle: 0x0024
                Group Name: Memory Module Set
                        Type: 0x11
                        Handle: 0x0022
                Group Name: Memory Module Set
                        Type: 0x14
                        Handle: 0x0025
                Group Name: Memory Module Set
                        Type: 0x13
                        Handle: 0x0023
Handle 0x0020
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System board or motherboard
                Use: System memory
                Error Correction Type: None
                Maximum Capacity: 524288 kB
                Error Information Handle: Not Provided
                Number of Devices: 2
Handle 0x0021
        DMI type 17, 23 bytes.
        Memory Device
                Array Handle: 0x0020
                Error Information Handle: None
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 Mbyte
                Form Factor: DIMM
                Set: 0x01
                Locator: DIMM 1
                Bank Locator:
                Type: DRAM
                Type Detail: Synchronous
                Speed: Unknown
Handle 0x0022
        DMI type 17, 23 bytes.
        Memory Device
                Array Handle: 0x0020
                Error Information Handle: None
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 Mbyte
                Form Factor: DIMM
                Set: 0x02
                Locator: DIMM 2
                Bank Locator:
                Type: DRAM
                Type Detail: Synchronous
                Speed: Unknown
Handle 0x0023
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
Handle 0x0024
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
Handle 0x0025
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
Handle 0x0026
        DMI type 32, 11 bytes.
        System Boot Information
Handle 0x0027
        DMI type 127, 4 bytes.
        End-of-Table
ACPI 1.0 present.
        OEM ID: ASUS
RSD table at 0x3DFEC000.
PNP 1.0 present.
        Event Notification: Not Supported
        Real Mode Code Address: F000:C080
        Real Mode Data Address: F000:0000
        Protected Mode Code Address: 0x000FC060
        Protected Mode Data Address: 0x000F0000
        OEM Device Identifier: 0x000CD041

# emerge info
Portage 2.0.49-r10 (default-x86-1.4, gcc-3.3.1, glibc-2.3.2-r1, 
2.6.0-test7-bk2)
=================================================================
System uname: 2.6.0-test7-bk2 i686 AMD Athlon(TM) XP 1900+
Gentoo Base System version 1.4.3.10p1
distcc 2.11.1 i686-pc-linux-gnu (protocols 1 and 2) (default port 
3632) [disabled]
ACCEPT_KEYWORDS="x86 ~x86"
AUTOCLEAN="yes"
CFLAGS="-march=athlon-xp -Os -pipe"
CHOST="i686-pc-linux-gnu"
COMPILER="gcc3"
CONFIG_PROTECT="/etc /var/qmail/control /usr/kde/2/share/config /
usr/kde/3/share/config /usr/X11R6/lib/X11/xkb /usr/kde/3.1/share/
config /usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/
platex/config/ /usr/share/config"
CONFIG_PROTECT_MASK="/etc/gconf /etc/env.d"
CXXFLAGS="-march=athlon-xp -Os -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="sandbox ccache autoaddcvs"
GENTOO_MIRRORS="http://www.ibiblio.org/gentoo ftp://
ftp.ussg.iu.edu/pub/linux/gentoo ftp://gentoo.noved.org/"
MAKEOPTS="-j2"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY=""
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="x86 oss apm avi crypt cups encode foomaticdb gif jpeg gnome 
libg++ mad mikmod mpeg ncurses nls pdflib png quicktime spell 
truetype xml2 xmms xv zlib gtkhtml alsa gdbm berkdb slang 
readline arts tetex bonobo svga tcltk java guile X sdl gpm tcpd 
pam libwww ssl perl python esd imlib oggvorbis gtk qt kde opengl 
mozilla cdr mysql athena -motif"




X. While the effect is most obvious as noted above, it also 
effects my use of kmail. It seems to take 5x longer to switch 
between kmail folders. The increase in time compared to under the 
2.4.20 kernel for switching also appears to be directly related 
to the number of items in the folders. I use the 'maildir' folder 
type. 

Please note that everything works as expected under the 2.4.20 
kernel.

Thank you,

D. Guy Cadieux
-- 
Recyle computers. Install Gentoo GNU/Linux.

