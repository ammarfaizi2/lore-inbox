Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbTGOUzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbTGOUzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:55:42 -0400
Received: from soda.gunnm.org ([213.41.156.81]:65157 "EHLO evira")
	by vger.kernel.org with ESMTP id S269671AbTGOUzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:55:04 -0400
Message-ID: <3F146DB2.1080204@gunnm.org>
Date: Tue, 15 Jul 2003 23:10:10 +0200
From: Julien <soda@gunnm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030704 Debian/1.4-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : touchpad doesn't work
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 . The touchpad of my laptop doesn't work with the 2.6 Linux kernel, 
but works with the 2.5.70

2 . I allways test the new Linux kernel, and my touchpad worked. It 
works with the Linux kernel 2.5.70, but doesn't work thos the 2.5.75. I 
use in the XF86Config the device : /dev/psaux. When I start X, the mouse 
appaears, but I can't move it ! My laptop is a Samsung V20. I try to 
configure X with /dev/input mouse0 or /dev/input/mice, but it doesn't work.

3. mouse, Xfree, touchpad, /dev/psaux

4. Kernel version :
Linux version 2.6.0-test1 (root@hirashi) (version gcc 3.3.1 20030626 
(Debian pre
release)) #4 Tue Jul 15 15:51:15 CEST 2003

7.1 :
Envionment :
-------------------------
Linux hirashi 2.6.0-test1 #4 Tue Jul 15 15:51:15 CEST 2003 i686 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         busmouse md5 ipv6 3c589_cs apm nfs lockd sunrpc 
snd_intel
8x0 snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device 
snd_pcm_oss snd_pc
m snd_page_alloc snd_timer snd_mixer_oss snd soundcore p4_clockmod 
freq_table id
e_cd i830 ds yenta_socket pcmcia_core isofs zlib_inflate sr_mod cdrom sg 
ide_scs
i scsi_mod eepro100 mii intel_agp agpgart rtc


7.2
/proc/cpuinfo
-------------------------------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Celeron(R) CPU 1.70GHz
stepping        : 3
cpu MHz         : 1695.090
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fx
sr sse sse2 ss ht tm
bogomips        : 3342.33


7.3
busmouse 7740 0 - Live 0xd0178000
md5 4096 1 - Live 0xd01ad000
ipv6 247908 14 - Live 0xd02a6000
3c589_cs 13064 0 - Live 0xd01b2000
apm 18416 1 - Live 0xd01ff000
nfs 97072 2 - Live 0xd0246000
lockd 60784 2 nfs,[unsafe], Live 0xd01e0000
sunrpc 130376 5 nfs,lockd, Live 0xd0225000
snd_intel8x0 30372 0 - Live 0xd019c000
snd_ac97_codec 50052 1 snd_intel8x0, Live 0xd01f1000
snd_mpu401_uart 7808 1 snd_intel8x0, Live 0xd0036000
snd_rawmidi 24608 1 snd_mpu401_uart, Live 0xd01a5000
snd_seq_device 8200 1 snd_rawmidi, Live 0xd0174000
snd_pcm_oss 52260 0 - Live 0xd01d2000
snd_pcm 96164 2 snd_intel8x0,snd_pcm_oss, Live 0xd01b9000
snd_page_alloc 10372 2 snd_intel8x0,snd_pcm, Live 0xd011f000
snd_timer 25220 1 snd_pcm, Live 0xd0194000
snd_mixer_oss 18944 1 snd_pcm_oss, Live 0xd018e000
snd 48996 9 
snd_intel8x0,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_pcm_oss,snd_pcm,snd_t
imer,snd_mixer_oss, Live 0xd0145000
soundcore 9152 1 snd, Live 0xd0123000
p4_clockmod 4488 0 - Live 0xd00ee000
freq_table 4484 1 p4_clockmod, Live 0xd00e5000
ide_cd 40964 0 - Live 0xd0164000
i830 71852 0 - Live 0xd017b000
ds 15236 3 3c589_cs, Live 0xd0140000
yenta_socket 12928 1 - Live 0xd0110000
pcmcia_core 63680 3 3c589_cs,ds,yenta_socket, Live 0xd0153000
isofs 34872 0 - Live 0xd0129000
zlib_inflate 22144 1 isofs, Live 0xd0118000
sr_mod 16292 0 - Live 0xd00e9000
cdrom 34848 2 ide_cd,sr_mod, Live 0xd0106000
sg 32152 0 - Live 0xd00c8000
ide_scsi 15744 0 - Live 0xd00da000
scsi_mod 74780 3 sr_mod,sg,ide_scsi, Live 0xd00f2000
eepro100 29964 0 - Live 0xd00d1000
mii 5248 1 eepro100, Live 0xd0039000
intel_agp 16796 1 - Live 0xd0026000
agpgart 30760 2 intel_agp, Live 0xd003c000
rtc 12724 0 - Live 0xd002c000


7.4
/proc/ioports
------------------------------
0000-001f : dma1
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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1100-111f : Intel Corp. 82801DB SMBus
1400-14ff : PCI CardBus #03
1800-181f : Intel Corp. 82801DB USB (Hub #1)
1820-183f : Intel Corp. 82801DB USB (Hub #2)
1840-185f : Intel Corp. 82801DB USB (Hub #3)
1860-186f : Intel Corp. 82801DB ICH4 IDE
  1860-1867 : ide0
  1868-186f : ide1
18c0-18ff : Intel Corp. 82801DB AC'97 Audio
1c00-1cff : Intel Corp. 82801DB AC'97 Audio
2000-207f : Intel Corp. 82801DB AC'97 Modem
2400-24ff : Intel Corp. 82801DB AC'97 Modem
3000-303f : Intel Corp. 82801BD PRO/100 VE (
  3000-303f : eepro100


/proc/iomem
------------------------
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000ce000-000cffff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0f6dffff : System RAM
  00100000-002493c9 : Kernel code
  002493ca-002d787f : Kernel data
0f6e0000-0f6effff : ACPI Tables
0f6f0000-0f6fffff : ACPI Non-volatile Storage
0f700000-0f77ffff : System RAM
0f780000-0fffffff : reserved
10000000-100003ff : Intel Corp. 82801DB ICH4 IDE
10001000-10001fff : Ricoh Co Ltd RL5c475
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
60000000-60000fff : card services
80000000-8007ffff : Intel Corp. 82845G/GL [Brookdale
88000000-8fffffff : Intel Corp. 82845G/GL [Brookdale
d0080000-d00803ff : Intel Corp. 82801DB USB EHCI Con
d0080800-d00808ff : Intel Corp. 82801DB AC'97 Audio
  d0080800-d00808ff : Intel 82801DB-ICH4 - Controller
d0080c00-d0080dff : Intel Corp. 82801DB AC'97 Audio
  d0080c00-d0080dff : Intel 82801DB-ICH4 - AC'97
d0100000-d0103fff : Texas Instruments TSB43AB22/A IEEE-139
d0104000-d0104fff : Intel Corp. 82801BD PRO/100 VE (
  d0104000-d0104fff : eepro100
d0105000-d01057ff : Texas Instruments TSB43AB22/A IEEE-139
e0000000-efffffff : Intel Corp. 82845G/GL [Brookdale
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved


7.5 : lspci -vvv
-----------------------
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 01)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [1105]

00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] 
Chipset Integrated Graphics Device
 (rev 01) (prog-if 00 [VGA])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 5
        Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) 
(prog-if 20 [EHCI])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 3
        Region 0: Memory at d0080000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1100 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
(rev 01)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at d0080c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at d0080800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00 
[Generic])
        Subsystem: Samsung Electronics Co Ltd: Unknown device 2115
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) 
Ethernet Controller (rev 81)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at d0104000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-i
f 10 [OHCI])
        Subsystem: Samsung Electronics Co Ltd: Unknown device c008
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0105000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at d0100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 : /proc/scsi/scsi
------------------------------
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-R2212 Rev: 1713
  Type:   CD-ROM                           ANSI SCSI revision: 02


7.7 :
/proc/bus/input/devices
---------------------------------
I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="Synaptics Synaptics TouchPad"
P: Phys=isa0060/serio4/input0
H: Handlers=event0 evbug
B: EV=1b
B: KEY=670000 0 0 0 0 0 0 0 0
B: ABS=1000003
B: MSC=4

I: Bus=0011 Vendor=0001 Product=0002 Version=ab83
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1 evbug
B: EV=120003
B: KEY=4 2000000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=7




/proc/bus/input/handlers
--------------------------------
N: Number=0 Name=kbd
N: Number=1 Name=mousedev Minor=32
N: Number=2 Name=evdev Minor=64
N: Number=3 Name=evbug





