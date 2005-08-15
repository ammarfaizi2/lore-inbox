Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVHOK3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVHOK3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVHOK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:29:49 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:52327 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932585AbVHOK3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:29:48 -0400
Date: Mon, 15 Aug 2005 12:29:25 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815102925.GA843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.9i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090203.43006BE3.0011-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

[1.] One line summary of the problem:
With a laptop hard disk adaptop to usb, I do a modprobe with the
usb-storage module. If I disconnect my hard disk, I get an oops.

[2.] Full description of the problem/report:

[3.] Keywords (i.e., modules, networking, kernel):
usb-storage

[4.] Kernel version (from /proc/version):
see version.log
[5.] Most recent kernel version which did not have the bug:
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
see dmesg.log     
[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment



[8.1.] Software (add the output of the ver_linux script here)
see ver_linux.log

[8.2.] Processor information (from /proc/cpuinfo):
see cpuinfo.log

[8.3.] Module information (from /proc/modules):
see modules.log

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
see ioports.log and iomem.log

[8.5.] PCI information ('lspci -vvv' as root)
see lspci.log

[8.6.] SCSI information (from /proc/scsi/scsi)
no scsi devices connected.

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you think to be relevant):

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="version.log"

Linux version 2.6.12-1-k7 (dilinger@mouth) (gcc version 4.0.1 (Debian 4.0.1-2)) #1 Wed Jul 20 23:17:47 UTC 2005

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="ver_linux.log"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debian 2.6.12-1-k7 #1 Wed Jul 20 23:17:47 UTC 2005 i686 GNU/Linux
 
Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre8
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.8
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   066
Modules Loaded         usb_storage usbhid nvidia nls_cp437 isofs binfmt_misc thermal fan button processor ac battery ipv6 af_packet orinoco_cs orinoco hermes pcmcia joydev tsdev mousedev evdev pcspkr rtc snd_via82xx_modem snd_via82xx gameport snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro i2c_core shpchp pci_hotplug via_agp agpgart ehci_hcd eth1394 uhci_hcd usbcore via82cxxx_audio uart401 sound soundcore ac97_codec via_rhine mii via_ircc irda crc_ccitt ohci1394 yenta_socket rsrc_nonstatic pcmcia_core sr_mod sbp2 scsi_mod ieee1394 psmouse ide_cd cdrom ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix fbcon tileblit font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect softcursor capability commoncap

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="ioport.log"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : pcmcia_socket0
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:11.5
  1000-10ff : via82cxxx_audio
1400-14ff : 0000:00:11.6
1800-180f : 0000:00:11.1
  1800-1807 : ide0
  1808-180f : ide1
1820-183f : 0000:00:10.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:10.2
  1840-185f : uhci_hcd
1c00-1cff : 0000:00:12.0
  1c00-1cff : via-rhine
4000-407f : motherboard
  4000-4003 : PM1a_EVT_BLK
  4004-4005 : PM1a_CNT_BLK
  4008-400b : PM_TMR
  4010-4015 : ACPI CPU throttle
  4020-4023 : GPE0_BLK
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #02
8100-811f : motherboard
  8100-8107 : viapro-smbus
fe00-fe1f : 0000:00:10.0
  fe00-fe1f : uhci_hcd

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="iomem.log"

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-002ae06d : Kernel code
  002ae06e-003646ff : Kernel data
1fef0000-1fefbfff : ACPI Tables
1fefc000-1fefffff : ACPI Non-volatile Storage
1ff00000-1fffffff : reserved
20000000-20000fff : 0000:00:0c.0
  20000000-20000fff : yenta_socket
20001000-20001fff : 0000:00:0d.0
  20001000-200017ff : ohci1394
20002000-200020ff : 0000:00:12.0
  20002000-200020ff : via-rhine
20400000-207fffff : PCI CardBus #02
20800000-20bfffff : PCI CardBus #02
a0000000-a0000fff : pcmcia_socket0
e0000000-e00000ff : 0000:00:10.3
  e0000000-e00000ff : ehci_hcd
e1000000-e1ffffff : PCI Bus #01
  e1000000-e1ffffff : 0000:01:00.0
    e1000000-e1ffffff : nvidia
e4000000-e7ffffff : 0000:00:00.0
e8000000-f7ffffff : PCI Bus #01
  e8000000-e807ffff : 0000:01:00.0
  f0000000-f7ffffff : 0000:01:00.0
fffe0000-ffffffff : reserved

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="modules.log"

usb_storage 76992 0 - Live 0xe0e2a000
usbhid 36640 0 - Live 0xe0e06000
nvidia 3711688 14 - Live 0xe10f1000
nls_cp437 5696 0 - Live 0xe0c48000
isofs 37944 0 - Live 0xe0c7d000
binfmt_misc 11912 1 - Live 0xe0c6e000
thermal 13512 0 - Live 0xe0c69000
fan 4676 0 - Live 0xe0c45000
button 6544 0 - Live 0xe0b9b000
processor 22132 1 thermal, Live 0xe0c62000
ac 4740 0 - Live 0xe0b9e000
battery 9476 0 - Live 0xe0c41000
ipv6 261952 8 - Live 0xe0cad000
af_packet 22472 2 - Live 0xe0c5b000
orinoco_cs 9288 1 - Live 0xe0c32000
orinoco 40972 1 orinoco_cs, Live 0xe0c4f000
hermes 7552 2 orinoco_cs,orinoco, Live 0xe0c2f000
pcmcia 27016 3 orinoco_cs, Live 0xe0c39000
joydev 10240 0 - Live 0xe0c2b000
tsdev 7872 0 - Live 0xe0bf2000
mousedev 11872 1 - Live 0xe0c27000
evdev 9728 0 - Live 0xe0c23000
pcspkr 3460 0 - Live 0xe0b74000
rtc 12408 0 - Live 0xe0be4000
snd_via82xx_modem 16356 0 - Live 0xe0bdf000
snd_via82xx 29248 0 - Live 0xe0be9000
gameport 15368 1 snd_via82xx, Live 0xe0bda000
snd_ac97_codec 83000 2 snd_via82xx_modem,snd_via82xx, Live 0xe0c0d000
snd_pcm 93448 3 snd_via82xx_modem,snd_via82xx,snd_ac97_codec, Live 0xe0bf5000
snd_timer 24644 1 snd_pcm, Live 0xe0ba9000
snd_page_alloc 9988 3 snd_via82xx_modem,snd_via82xx,snd_pcm, Live 0xe0b6c000
snd_mpu401_uart 7360 1 snd_via82xx, Live 0xe0b98000
snd_rawmidi 25504 1 snd_mpu401_uart, Live 0xe0ba1000
snd_seq_device 8844 1 snd_rawmidi, Live 0xe0b70000
snd 56644 8 snd_via82xx_modem,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe0bcb000
i2c_viapro 8080 0 - Live 0xe0b38000
i2c_core 21968 1 i2c_viapro, Live 0xe0b91000
shpchp 98788 0 - Live 0xe0bb1000
pci_hotplug 28532 1 shpchp, Live 0xe0b76000
via_agp 9920 1 - Live 0xe0b68000
agpgart 35592 2 nvidia,via_agp, Live 0xe0b53000
ehci_hcd 35144 0 - Live 0xe0b5e000
eth1394 20680 0 - Live 0xe0b3b000
uhci_hcd 32016 0 - Live 0xe0a8c000
usbcore 122300 5 usb_storage,usbhid,ehci_hcd,uhci_hcd, Live 0xe0b14000
via82cxxx_audio 29576 1 - Live 0xe0a96000
uart401 11524 1 via82cxxx_audio, Live 0xe0a88000
sound 80812 2 via82cxxx_audio,uart401, Live 0xe0adb000
soundcore 9824 4 snd,via82cxxx_audio,sound, Live 0xe0a6d000
ac97_codec 20108 1 via82cxxx_audio, Live 0xe0a82000
via_rhine 23236 0 - Live 0xe0a7b000
mii 5760 1 via_rhine, Live 0xe0a41000
via_ircc 31188 0 - Live 0xe0a72000
irda 200828 1 via_ircc, Live 0xe0aa8000
crc_ccitt 2048 1 irda, Live 0xe0a32000
ohci1394 35764 0 - Live 0xe0a34000
yenta_socket 23560 2 - Live 0xe09f2000
rsrc_nonstatic 13696 1 yenta_socket, Live 0xe09ed000
pcmcia_core 51924 4 orinoco_cs,pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe0a1a000
sr_mod 17764 0 - Live 0xe09e7000
sbp2 23688 0 - Live 0xe09e0000
scsi_mod 138568 3 usb_storage,sr_mod,sbp2, Live 0xe0a45000
ieee1394 105464 3 eth1394,ohci1394,sbp2, Live 0xe09ff000
psmouse 31172 0 - Live 0xe090f000
ide_cd 43460 0 - Live 0xe0903000
cdrom 40544 2 sr_mod,ide_cd, Live 0xe08f8000
ext3 141704 1 - Live 0xe0921000
jbd 56792 1 ext3, Live 0xe08e9000
mbcache 9284 1 ext3, Live 0xe08d3000
ide_disk 18816 3 - Live 0xe08cd000
ide_generic 1280 0 [permanent], Live 0xe08c4000
via82cxxx 13788 0 [permanent], Live 0xe089e000
trm290 4292 0 [permanent], Live 0xe08ba000
triflex 3840 0 [permanent], Live 0xe083f000
slc90e66 5824 0 [permanent], Live 0xe08b7000
sis5513 16584 0 [permanent], Live 0xe08be000
siimage 12608 0 [permanent], Live 0xe08b2000
serverworks 9096 0 [permanent], Live 0xe08ae000
sc1200 7424 0 [permanent], Live 0xe08ab000
rz1000 2560 0 [permanent], Live 0xe0860000
piix 10372 0 [permanent], Live 0xe08a7000
pdc202xx_old 11328 0 [permanent], Live 0xe08a3000
opti621 4420 0 [permanent], Live 0xe0872000
ns87415 4360 0 [permanent], Live 0xe086f000
hpt366 20288 0 [permanent], Live 0xe0898000
hpt34x 5248 0 [permanent], Live 0xe086c000
generic 3968 0 [permanent], Live 0xe0830000
cy82c693 4804 0 [permanent], Live 0xe0869000
cs5530 5440 0 [permanent], Live 0xe0866000
cs5520 4672 0 [permanent], Live 0xe0863000
cmd64x 12124 0 [permanent], Live 0xe0859000
atiixp 6032 0 [permanent], Live 0xe085d000
amd74xx 14364 0 [permanent], Live 0xe0836000
alim15x3 12428 0 [permanent], Live 0xe0854000
aec62xx 7552 0 [permanent], Live 0xe0828000
pdc202xx_new 9472 0 [permanent], Live 0xe083b000
ide_core 129812 29 usb_storage,ide_cd,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new, Live 0xe0877000
unix 28144 313 - Live 0xe084c000
fbcon 40064 0 - Live 0xe0841000
tileblit 2368 1 fbcon, Live 0xe082e000
font 8320 1 fbcon, Live 0xe0832000
bitblit 5824 1 fbcon, Live 0xe082b000
vesafb 8088 0 - Live 0xe0802000
cfbcopyarea 3840 1 vesafb, Live 0xe0826000
cfbimgblt 2880 1 vesafb, Live 0xe0824000
cfbfillrect 4160 1 vesafb, Live 0xe0821000
softcursor 2496 1 vesafb, Live 0xe081f000
capability 4680 0 - Live 0xe0805000
commoncap 7040 1 capability, Live 0xe081c000

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="cpuinfo.log"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) XP 2200+
stepping	: 1
cpu MHz		: 1799.964
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3563.52


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="lspci.log"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e1000000-e1ffffff
	Prefetchable memory behind bridge: e8000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2750
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (3000ns min, 6000ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at fe00 [size=32]
	Capabilities: <available only to root>

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1820 [size=32]
	Capabilities: <available only to root>

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]
	Capabilities: <available only to root>

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2890
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1800 [size=16]
	Capabilities: <available only to root>

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2841
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Capabilities: <available only to root>

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2870
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: <available only to root>

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2820
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: Memory at 20002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go 64M] (rev a3) (prog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at e8000000 (32-bit, prefetchable) [size=512K]
	Capabilities: <available only to root>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="dmesg.log"

usb 1-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Targus USB Mouse] on usb-0000:00:10.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
usb 1-1: USB disconnect, address 2
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.00 Mouse [Targus USB Mouse] on usb-0000:00:10.0-1
usb 1-1: USB disconnect, address 3
usb 1-1: new low speed USB device using uhci_hcd and address 4
input: USB HID v1.00 Mouse [Targus USB Mouse] on usb-0000:00:10.0-1
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
usb 4-5: new high speed USB device using ehci_hcd and address 5
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
usb 4-5: USB disconnect, address 5
usb-storage: device scan complete
Unable to handle kernel NULL pointer dereference at virtual address 00000048
 printing eip:
c019710b
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: usb_storage usbhid nvidia nls_cp437 isofs binfmt_misc thermal fan button processor ac battery ipv6 af_packet orinoco_cs orinoco hermes pcmcia joydev tsdev mousedev evdev pcspkr rtc snd_via82xx_modem snd_via82xx gameport snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro i2c_core shpchp pci_hotplug via_agp agpgart ehci_hcd eth1394 uhci_hcd usbcore via82cxxx_audio uart401 sound soundcore ac97_codec via_rhine mii via_ircc irda crc_ccitt ohci1394 yenta_socket rsrc_nonstatic pcmcia_core sr_mod sbp2 scsi_mod ieee1394 psmouse ide_cd cdrom ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix fbcon tileblit font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect softcursor capability commoncap
CPU:    0
EIP:    0060:[<c019710b>]    Tainted: P      VLI
EFLAGS: 00010296   (2.6.12-1-k7) 
EIP is at sysfs_hash_and_remove+0xb/0xec
eax: 00000000   ebx: d02e964c   ecx: 00000001   edx: e0a664a8
esi: d02e9644   edi: d02e9590   ebp: e0a66440   esp: c15f1dfc
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 2841, threadinfo=c15f0000 task=de77e580)
Stack: 00000003 00000001 00000000 d02e964c d02e9644 d02e9590 e0a66440 c0222e61 
       00000000 c02c3c2e e0a664a8 d02e9644 d02e9590 cf1a1c28 00000202 c0222eb0 
       d02e9644 d02e9400 e0a4fa24 d02e9644 00000003 cf1a1bf8 cf1a1c00 ce1957c0 
Call Trace:
 [<c0222e61>] class_device_del+0x81/0xc0
 [<c0222eb0>] class_device_unregister+0x10/0x20
 [<e0a4fa24>] scsi_remove_device+0x64/0xb0 [scsi_mod]
 [<e0a4fae1>] __scsi_remove_target+0x71/0xa0 [scsi_mod]
 [<e0a4e9f1>] scsi_forget_host+0x31/0x50 [scsi_mod]
 [<e0a46447>] scsi_remove_host+0x17/0x70 [scsi_mod]
 [<e0e2cd66>] storage_disconnect+0x56/0x74 [usb_storage]
 [<e0b140de>] usb_unbind_interface+0x3e/0x80 [usbcore]
 [<c02219bf>] device_release_driver+0x5f/0x80
 [<c0221c3b>] bus_remove_device+0x6b/0xb0
 [<c0220b3c>] device_del+0x5c/0xa0
 [<e0b1bb20>] usb_disable_device+0xb0/0x130 [usbcore]
 [<e0b165b0>] usb_disconnect+0xb0/0x130 [usbcore]
 [<e0b176e2>] hub_port_connect_change+0x52/0x3b0 [usbcore]
 [<e0b17cb5>] hub_events+0x275/0x3e0 [usbcore]
 [<e0b17e6f>] hub_thread+0x4f/0x120 [usbcore]
 [<c012e6c0>] autoremove_wake_function+0x0/0x60
 [<e0b17e20>] hub_thread+0x0/0x120 [usbcore]
 [<c0101319>] kernel_thread_helper+0x5/0xc
Code: 00 89 5c 24 14 8b 46 08 8b 5c 24 04 8b 74 24 08 89 44 24 10 83 c4 0c e9 94 34 fe ff 8d 74 26 00 55 57 56 53 83 ec 0c 8b 44 24 20 <8b> 50 48 8b 48 08 ff 49 70 0f 88 d2 00 00 00 8b 42 0c 8d 68 fc 
 

--jI8keyz6grp/JLjh--

