Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUCNTgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 14:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUCNTgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 14:36:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9081 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261586AbUCNTfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 14:35:47 -0500
Date: Sun, 14 Mar 2004 11:31:45 -0800
From: Ya`akov N Miles <yehudi2@shaw.ca>
Subject: vidmode >0 causes CLI scrolling to not work properly
To: linux-kernel@vger.kernel.org
Cc: "Ya`akov N. Miles" <yehudi2@shaw.ca>
Message-id: <4054B321.1080707@shaw.ca>
Organization: Linux Kernel Hackers
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_hO7WuRTJOQw9xvTpbfVNEA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_hO7WuRTJOQw9xvTpbfVNEA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


-- 
Linux -  In a world without walls and fences, who needs Windows and Gates?
ftp site ftp.yehudi.ca <== Fast anonymous downloads of Linux Distributions
web site http://www.sem40.ru  <== Russian language news site.  Cool scoops
web site http://www.yaakov.ca <== Now powered by shaw.ca - Linux CDs $1 ea

--Boundary_(ID_hO7WuRTJOQw9xvTpbfVNEA)
Content-type: text/plain; name=bug.doc
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=bug.doc

[1] Setting Vidmode > 0 causes BASH scrolling to hide the current line.
[2] Setting Vidmode > 0 with either rdev or as an argument to kernel mode
    causes BASH scrolling to hide the most recent lines.  The screen starts
    behaving OK, but then the cursor drops below the page of text and vanishes
    taking the current line (on which you are typing) with it.
[3] Video Mode, scrolling, CLI interface, Bash
[4] I am running kernel linux-2.6.4
[5] Not an OOPs so not applicable.
[6] Not applicable
[7.1] Processor
Linux pentium1 2.6.4 #8 Sun Mar 14 02:08:26 PST 2004 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      0.9.14
e2fsprogs              1.27
jfsutils               1.0.18
reiserfsprogs          3.x.1b
xfsprogs               2.0.3
pcmcia-cs              3.1.33
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              0.3.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sb sb_lib uart401 v_midi
pentium1:/usr/src/linux-2.6.4# exit
exit

[7.2] cpu_info
Script started on Sun Mar 14 11:05:12 2004
pentium1:/usr/src/linux-2.6.4# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 998.638
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
bogomips	: 1966.08

[7.3] Loaded Modules
pentium1:/usr/src/linux-2.6.4# cat /proc/modules
sb 3936 1 - Live 0xf08f2000
sb_lib 43664 1 sb, Live 0xf090d000
uart401 9348 1 sb_lib, Live 0xf08fb000
v_midi 6596 0 - Live 0xf08ef000
pentium1:/usr/src/linux-2.6.4# exit
exit

Script done on Sun Mar 14 11:06:08 2004

[7.4] ioports and iomem
Script started on Sun Mar 14 11:06:21 2004
pentium1:/usr/src/linux-2.6.4# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : soundblaster
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-040f : 0000:00:07.4
0c00-0c7f : 0000:00:07.4
0cf8-0cff : PCI conf1
7000-8fff : PCI Bus #01
  8800-88ff : 0000:01:00.0
c400-c4ff : 0000:00:0c.0
  c400-c4ff : tulip
c800-c80f : 0000:00:0b.0
  c800-c807 : ide2
  c808-c80f : ide3
cc00-cc03 : 0000:00:0b.0
d000-d007 : 0000:00:0b.0
d400-d403 : 0000:00:0b.0
  d402-d402 : ide2
d800-d807 : 0000:00:0b.0
  d800-d807 : ide2
dc00-dcff : 0000:00:09.0
  dc00-dcff : aic7xxx
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
pentium1:/usr/src/linux-2.6.4# cat /pro oc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000cc7ff : Extension ROM
000cc800-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-002dc1c5 : Kernel code
  002dc1c6-003a1edf : Kernel data
2fff0000-2fff7fff : ACPI Tables
2fff8000-2fffffff : ACPI Non-volatile Storage
ddc00000-ddcfffff : PCI Bus #01
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : 0000:01:00.0
  dfeff000-dfefffff : 0000:01:00.0
dfff8000-dfffbfff : 0000:00:0b.0
dfffef00-dfffefff : 0000:00:0c.0
  dfffef00-dfffefff : tulip
dffff000-dfffffff : 0000:00:09.0
  dffff000-dfffffff : aic7xxx
e0000000-e3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
pentium1:/usr/src/linux-2.6.4# exit
exit

Script done on Sun Mar 14 11:06:39 2004

[7.5] pci
Script started on Sun Mar 14 11:07:20 2004
pentium1:/usr/src/linux-2.6.4# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: Giga-byte Technology: Unknown device 5000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00007000-00008fff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: ddc00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Giga-byte Technology: Unknown device 5001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology: Unknown device 5002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Giga-byte Technology: Unknown device 5003
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffe0000 [disabled] [size=64K]

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=8]
	Region 1: I/O ports at d400 [size=4]
	Region 2: I/O ports at d000 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at c800 [size=16]
	Region 5: Memory at dfff8000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at dffd0000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100] (rev 25)
	Subsystem: Lite-On Communications Inc: Unknown device c001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c400 [size=256]
	Region 1: Memory at dfffef00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dffc0000 [disabled] [size=64K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 8800 [size=256]
	Region 2: Memory at dfeff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dfec0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

pentium1:/usr/src/linux-2.6.4# exit
exit

Script done on Sun Mar 14 11:07:30 2004

[7.6] scsi
Script started on Sun Mar 14 11:08:48 2004
pentium1:/usr/src/linux-2.6.4# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST19171W         Rev: 0024
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: ARCHIVE  Model: Python 04106-XXX Rev: 7270
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
pentium1:/usr/src/linux-2.6.4# exit
exit

Script done on Sun Mar 14 11:08:56 2004

--Boundary_(ID_hO7WuRTJOQw9xvTpbfVNEA)--
