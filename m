Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTLGJnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLGJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:43:20 -0500
Received: from postal.usc.edu ([128.125.253.6]:3270 "EHLO postal.usc.edu")
	by vger.kernel.org with ESMTP id S264388AbTLGJnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:43:13 -0500
Date: Sun, 07 Dec 2003 01:43:08 -0800
From: Lee <weifeil@usc.edu>
Subject: PROBLEM: Can't use mkintrd to make a image file
To: linux-kernel@vger.kernel.org
Message-id: <003101c3bca6$89d7f350$0300a8c0@tiger>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Under kernel 2.6.0-test10, I can't use mkintrd to make a image file.
2. Unlike under 2.4.x kernel, when I use mkintrd to make a file, it always
tells me that:"All of your loopback devices are in use" . So I have to
switch to 2.4.x kernel to make .img file.
3. Keyword: mkinitrd, loopback devices
4.Kernel Version:Linux version 2.6.0-test10 (root@king) (gcc version 3.2
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Nov 26 21:40:32 PST 2003
5. Oops output: No
6. Script: "mkintrd 2.6.0  2.6.0-test10"

7.Environment:


7.1.Software: If some fields are empty or look unusual you may have an old
version.
Compare to the current minimal requirements in Documentation/Changes.

Linux king 2.6.0-test10 #1 Wed Nov 26 21:40:32 PST 2003 i686 i686 i386
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.9
xfsprogs               2.5.11
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.5
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ide_cd cdrom binfmt_misc autofs parport_pc parport
hid


7.2. Processor: processor : 0
vendor_id : CyrixInstead
cpu family : 6
model  : 2
model name : M II 3x Core/Bus Clock
stepping : 8
cpu MHz  : 250.130
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu de tsc msr cx8 pge cmov mmx cyrix_arr est
bogomips : 489.47

7.3. Module Information:  binfmt_misc 9352 0 - Live 0xd287c000
autofs 14976 1 - Live 0xd284e000
parport_pc 17928 0 - Live 0xd2848000
parport 43328 1 parport_pc, Live 0xd283c000
hid 34240 0 - Live 0xd2882000

7.4. Loaded driver and Hardware information:

>From ioports:

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
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e800-e81f : 0000:00:07.2
ea00-eaff : 0000:00:12.0
  ea00-eaff : 8139too
ee00-ee07 : 0000:00:13.0
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

>From iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-11feffff : System RAM
  00100000-0036b1e3 : Kernel code
  0036b1e4-004425ff : Kernel data
11ff0000-11ff7fff : ACPI Tables
11ff8000-11ffffff : ACPI Non-volatile Storage
f4800000-f48fffff : PCI Bus #01
f8000000-fbffffff : 0000:00:00.0
fca00000-feafffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
  feaff000-feafffff : 0000:01:00.0
febeff00-febeffff : 0000:00:12.0
  febeff00-febeffff : 8139too
febf0000-febfffff : 0000:00:13.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved

7.5. PCI information:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
 Latency: 64
 Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
 Capabilities: [a0] AGP version 1.0
  Status: RQ=7 SBA+ 64bit- FW- Rate=x1
  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: fca00000-feafffff
 Prefetchable memory behind bridge: f4800000-f48fffff
 BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev
06)
 Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
(rev 06) (prog-if 8a [Master SecP PriP])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64
 Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if 00
[UHCI])
 Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64, cache line size 08
 Interrupt: pin D routed to IRQ 3
 Region 4: I/O ports at e800 [size=32]

00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
 Subsystem: Realtek Semiconductor Co., Ltd. RT8139
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64 (8000ns min, 16000ns max)
 Interrupt: pin A routed to IRQ 10
 Region 0: I/O ports at ea00 [size=256]
 Region 1: Memory at febeff00 (32-bit, non-prefetchable) [size=256]
 Expansion ROM at febd0000 [disabled] [size=64K]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Communication controller: Conexant HCF 56k Data/Fax Modem
(Worldwide) (rev 08)
 Subsystem: Askey Computer Corp.: Unknown device 1046
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=64K]
 Region 1: I/O ports at ee00 [size=8]
 Capabilities: [40] Power Management version 2
  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
7a) (prog-if 00 [VGA])
 Subsystem: ATI Technologies Inc Rage IIC AGP
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min), cache line size 08
 Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
 Region 1: I/O ports at d800 [size=256]
 Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
 Expansion ROM at feac0000 [disabled] [size=128K]
 Capabilities: [5c] Power Management version 1
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6. SCSI information: No such file or directory as /proc/scsi

That's   all,
Thanks a lot!
Weifei

