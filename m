Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVBTS4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVBTS4y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 13:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBTS4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 13:56:54 -0500
Received: from mxsf05.cluster1.charter.net ([209.225.28.205]:42149 "EHLO
	mxsf05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261739AbVBTS4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 13:56:34 -0500
X-Ironport-AV: i="3.90,101,1107752400"; 
   d="scan'208"; a="619008356:sNHT19194056"
Message-ID: <4218DD92.4040802@charter.net>
Date: Sun, 20 Feb 2005 13:57:22 -0500
From: Kenton Groombridge <kgroombr@charter.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: agpgart-via: probe fails with error -22
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]  PROBLEM: agpgart-via: probe fails with error -22

[2.]  When loading agpgart/agpgart-via the following occurs:

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-via: probe of 0000:00:00.0 failed with error -22

[3.] Keywords: agpgart-via

[4.] Linux version 2.6.10 (root@blossom) (gcc version 3.4.1 
(Mandrakelinux 10.1 3.4.1-4mdk)) #1 Fri Feb 18 10:36:35 EST 2005

[5.]

agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-via: probe of 0000:00:00.0 failed with error -22

[6.] N/A

[7.]

LESSKEY=/etc/.less
LC_PAPER=en_US
LC_ADDRESS=en_US
LC_MONETARY=en_US
HOSTNAME=blossom
SHELL=/bin/bash
TERM=xterm
LC_SOURCED=1
HISTSIZE=1000
TMPDIR=/root/tmp
LC_NUMERIC=en_US
QTDIR=/usr/lib/qt3/
USER=root
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:
LC_TELEPHONE=en_US
ENV=/root/.bashrc
USERNAME=root
NLSPATH=/usr/share/locale/%l/%N
MAIL=/var/spool/mail/root
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin
LC_MESSAGES=en_US
SECURE_LEVEL=2
LC_IDENTIFICATION=en_US
LC_COLLATE=en_US
INPUTRC=/etc/inputrc
PWD=/root
LANG=en_US
PYTHONSTARTUP=/etc/pythonrc.py
LC_MEASUREMENT=en_US
PS1=[\u@\h \W]\$
HISTCONTROL=ignoredups
SHLVL=1
HOME=/root
LANGUAGE=en_US:en
GCONF_TMPDIR=/tmp
TMP=/root/tmp
LESS=-MM
LOGNAME=root
LC_CTYPE=en_US
LESSOPEN=|/usr/bin/lesspipe.sh %s
DISPLAY=:0.0
LC_TIME=en_US
G_BROKEN_FILENAMES=1
LC_NAME=en_US
XAUTHORITY=/root/.xauthqHycKh
_=/bin/env

[7.1.]

Linux blossom 2.6.10 #1 Fri Feb 18 10:36:35 EST 2005 i686 AMD Athlon(tm) 
XP 2900+ unknown GNU/Linux

Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep 
snd soundcore loop nls_iso8859_1 ntfs nvidia ehci_hcd uhci_hcd button rtc

[7.2.]

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2900+
stepping        : 0
cpu MHz         : 1999.874
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 3940.35

[7.3.]

snd_seq_oss 32320 0 - Live 0xf898b000
snd_seq_midi_event 6336 1 snd_seq_oss, Live 0xf8920000
snd_seq 50064 4 snd_seq_oss,snd_seq_midi_event, Live 0xf8a41000
snd_pcm_oss 50532 0 - Live 0xf8a33000
snd_mixer_oss 17920 1 snd_pcm_oss, Live 0xf8947000
snd_emu10k1 93764 1 - Live 0xf8996000
snd_rawmidi 20704 1 snd_emu10k1, Live 0xf8940000
snd_seq_device 6796 4 snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi, Live 
0xf891d000
snd_ac97_codec 72352 1 snd_emu10k1, Live 0xf8967000
snd_pcm 84232 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live 0xf8951000
snd_timer 22084 2 snd_seq,snd_pcm, Live 0xf8931000
snd_page_alloc 7428 2 snd_emu10k1,snd_pcm, Live 0xf8818000
snd_util_mem 3264 1 snd_emu10k1, Live 0xf881b000
snd_hwdep 7364 1 snd_emu10k1, Live 0xf8916000
snd 44772 13 
snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep, 
Live 0xf8925000
soundcore 7456 1 snd, Live 0xf880e000
loop 12936 0 - Live 0xf8911000
nls_iso8859_1 3776 1 - Live 0xf8816000
ntfs 178192 1 - Live 0xf88e4000
nvidia 3462844 12 - Live 0xf8c69000
ehci_hcd 27076 0 - Live 0xf8827000
uhci_hcd 29520 0 - Live 0xf881e000
button 4816 0 - Live 0xf8811000
rtc 10488 0 - Live 0xf8804000

[7.4.]

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
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-4003 : PM1a_EVT_BLK
4004-4005 : PM1a_CNT_BLK
4008-400b : PM_TMR
4020-4023 : GPE0_BLK
d000-d01f : 0000:00:09.0
  d000-d01f : EMU10K1
d400-d407 : 0000:00:09.1
d800-d80f : 0000:00:0f.0
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc1f : 0000:00:10.0
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.1
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:10.2
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:10.3
  e800-e81f : uhci_hcd
ec00-ecff : 0000:00:12.0
  ec00-ecff : via-rhine

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002bdc4a : Kernel code
  002bdc4b-0036c33f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #01
  d8000000-dbffffff : 0000:01:00.0
  dc000000-dc07ffff : 0000:01:00.0
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : 0000:01:00.0
    e0000000-e0ffffff : nvidia
e2000000-e20000ff : 0000:00:10.4
  e2000000-e20000ff : ehci_hcd
e2001000-e20010ff : 0000:00:12.0
  e2001000-e20010ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.]

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] 
Host Bridge (rev 80)
        Subsystem: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host 
Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs SB Live! 5.1 Model SB0100
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d000 [size=32]
        Capabilities: <available only to root>

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at d400 [size=8]
        Capabilities: <available only to root>

00:0f.0 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at d800 [size=16]
        Capabilities: <available only to root>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: <available only to root>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at e000 [size=32]
        Capabilities: <available only to root>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e400 [size=32]
        Capabilities: <available only to root>

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e800 [size=32]
        Capabilities: <available only to root>

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 
20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
        Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 78)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded 
Ethernet Controller on VT8235
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at e2001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at dc000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

[7.6.] N/A

[7.7.] This was a motherboard purchased to replace another VIA based 
board so it should have worked without problems.   I reloaded Mandrake 
10.1 and built a dozen different kernels.  I tried the Mandrake patched 
kernel, and the stock 2.6.10 kernel.  I tried with and without ACPI.  
The results posted are with the .config I used with the previous VIA 
based board that worked perfectly with the Ti4600 card at AGP 4x.  
Normally I have the ck-sources patch installed, but I wanted to use a 
stock kernel to ensure it wasn't something in the ck-sources that wasn't 
causing a problem.  Because I don't have the ck-sources installed my 
system only detects 816MB of mem instead of 1GB.

The only hardware that has changed is the motherboard.  All other 
hardware is the same as before.

This is a dual boot system with Windows XP.  Windows XP functions fine 
and using hwinfo32 it shows the Ti4200 card functioning at AGP 4x.

In my search, I have found others that have this problem in newsgroups 
and forums, but they still have no solution (other than get a different 
motherboard).  Motherboard is Jetway V600DAP 
(http://www.machspeed.com/v_v600dap.htm).

I hope I reported this correctly.  In my eight or so years of using 
Linux, this is the first time I found a problem that appears kernel 
related that I couldn't resolve.  I have been working this several weeks 
now and have pretty much given up.

More info (probably not relevant) can be found at:

http://www.nvnews.net/vbulletin/showthread.php?p=546726#post546726

