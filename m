Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbTBDHHO>; Tue, 4 Feb 2003 02:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTBDHHN>; Tue, 4 Feb 2003 02:07:13 -0500
Received: from smtp2.terra.com.pe ([200.48.36.148]:36370 "EHLO
	smtp2.terra.com.pe") by vger.kernel.org with ESMTP
	id <S267138AbTBDHG4>; Tue, 4 Feb 2003 02:06:56 -0500
Message-ID: <3E3F6A21.6090305@terra.com.pe>
Date: Tue, 04 Feb 2003 02:22:09 -0500
From: Wendigo <wendigo2@terra.com.pe>
Organization: Kame House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  Computer freezes completely when I insert a data cd in
 Samsung CD-R/RW SW408B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux harpia.kamehouse.net 2.4.18-18.8.0 #1 Thu Nov 14 00:10:29 EST 2002 
i686 i686 i386 GNU/Linux


1.] The computer freezes completely when I insert data CDs in CD-R/RW Samsung 408B 
[2.] The ide driver is attached as slave in the secondary channel. The Master es is MatshitaDVD-ROM SR8585
[3.] CD-R, CD-RW, Samsund drive
[4.] kernel version 2.4.18-18.8.0
[7.] Environment: Redhat 8.0 problem occurs is Gnome and KDE
[7.1.] Software (add the output of the ver_linux script here)

	Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) Copyright
	(C) 2002 Free Software Foundation, Inc. Esto es software libre; vea el código

	para las condiciones de copia. NO hay garantía; ni siquiera para MERCANTIBILIDAD o IDONEIDAD PARA UN PROPÓSITO EN PARTICULAR

	Gnu make               3.79.1
	
	util-linux             2.11r

	mount                  2.11r

	modutils               2.4.18

	e2fsprogs              1.27

	pcmcia-cs              3.1.31

	PPP                    2.4.1

	isdn4k-utils           3.1pre4

	Linux C Library        2.2.93

	Dynamic linker (ldd)   2.2.93

	Procps                 2.0.7

	Net-tools              1.60

	Kbd                    1.06

	Sh-utils               2.0.12

	Modules Loaded         sr_mod emu10k1 ac97_codec sound soundcore agpgart nvidia

	binfmt_misc parport_pc lp parport autofs 8139too mii ipt_REJECT iptable_filter
	ip_tables ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat
	mousedev keybdev hid input usb-uhci usbcore ext3 jbd




[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 994.561
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1976.57

 

[7.3.] Module information (from /proc/modules):

sr_mod                 18168   0 (autoclean)
emu10k1                68744   1 (autoclean)
ac97_codec             13416   0 (autoclean) [emu10k1]
sound                  74388   0 (autoclean) [emu10k1]
soundcore               6532   7 (autoclean) [emu10k1 sound]
agpgart                43136   3 (autoclean)
nvidia               1592160  10 (autoclean)
binfmt_misc             7524   1
parport_pc             19108   1 (autoclean)
lp                      8996   0 (autoclean)
parport                37152   1 (autoclean) [parport_pc lp]
autofs                 13348   0 (autoclean) (unused)
8139too                17704   1
mii                     2156   0 [8139too]
ipt_REJECT              3736   6 (autoclean)
iptable_filter          2412   1 (autoclean)
ip_tables              14936   2 [ipt_REJECT iptable_filter]
ide-scsi               10512   0
scsi_mod              107240   2 [sr_mod ide-scsi]
ide-cd                 33608   0
cdrom                  33696   0 [sr_mod ide-cd]
nls_iso8859-1           3516   1 (autoclean)
nls_cp437               5148   1 (autoclean)
vfat                   13084   1 (autoclean)
fat                    38712   0 (autoclean) [vfat]
mousedev                5524   1
keybdev                 2976   0 (unused)
hid                    22244   0 (unused)
input                   5920   0 [mousedev keybdev hid]
usb-uhci               26188   0 (unused)
usbcore                77024   1 [hid usb-uhci]
ext3                   70368   2
jbd                    52212   2 [ext3]



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
0cf8-0cff : PCI conf1
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d800-d8ff : 8139too
df80-df9f : Creative Labs SB Live! EMU10k1
  df80-df9f : EMU10K1
dff0-dff7 : Creative Labs SB Live! MIDI/Game Port
ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corp. 82801BA/BAM SMBus
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1



00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca800-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffbffff : System RAM
  00100000-002488da : Kernel code
  002488db-0033fe63 : Kernel data
1ffc0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
f04ffc00-f04ffcff : Motorola SM56 PCI Modem
f0500000-f45fffff : PCI Bus #02
  f2000000-f3ffffff : nVidia Corporation Vanta [NV6]
f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
fc800000-fc8fffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder
fc9ffc00-fc9ffcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  fc9ffc00-fc9ffcff : 8139too
fca00000-feafffff : PCI Bus #02
  fd000000-fdffffff : nVidia Corporation Vanta [NV6]
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved




[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
        Subsystem: Intel Corp.: Unknown device 4532
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [f104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: f0500000-f45fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 11) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fc700000-fc9fffff
        Prefetchable memory behind bridge: f0400000-f04fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 11) (prog-if 80 [Master])
        Subsystem: Intel Corp.: Unknown device 4532
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: [virtual] I/O ports at 01f0
        Region 1: [virtual] I/O ports at 03f4
        Region 2: [virtual] I/O ports at 0170
        Region 3: [virtual] I/O ports at 0374
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 11) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4532
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 11)
        Subsystem: Intel Corp.: Unknown device 4532
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 11) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4532
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 9
        Region 4: I/O ports at ef80 [size=32]

01:09.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD
Decoder (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc800000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at fc9ffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fc9e0000 [disabled] [size=64K]

01:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at df80 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dff0 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 Communication controller: Motorola SM56 PCI Modem
        Subsystem: CIS Technology Inc SM56 PCI Speakerphone Modem
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f04ffc00 (32-bit, prefetchable) [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at feaf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4



[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-R/RW SW-408B  Rev: BS02
  Type:   CD-ROM                           ANSI SCSI revision: 02


-- 
My opinions may have changed, but not the fact that I am right.
-- Ashleigh Brilliant


