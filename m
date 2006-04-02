Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWDBNBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWDBNBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 09:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDBNBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 09:01:09 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:45870 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932312AbWDBNBH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 09:01:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XSLAvHsr6aPgI+d4FKpz9UWtIOhyxmqRYd6f3hAGLe3G8C8mUA4q8Cu+vqnTE1GTbzi5cuvexPfsXiezkOuCyLmsLjNhmcFpLQ2DZ0imHg7kLp+DVBkRA+LDgN/u68ILUOzzQeHpXBWhxv0XgUepAW1/ChylYR58npRAam02psw=
Message-ID: <44301ED9.3070704@gmail.com>
Date: Sun, 02 Apr 2006 18:58:33 +0000
From: "[EViL]" <evil.zd@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel Panic at reading the ircomm device
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Kernel Panic at reading the ircomm device
[2.] (Sorry for my poor English) I have a Tekram IRmate-210 IrDA Adapter 
(connected to ttyS0).
For a raising of the network interface (irda0) I use commands:
######
/sbin/modprobe tekram-sir
/sbin/modprobe ircomm_tty
/usr/sbin/irattach /dev/ttyS0 -d tekram -s
######
Then I turned on IrDA on my cellular phone.
And once, when I have typed a commands:

# cd /dev
# cat ircomm1
                    [now I pressed Ctrl+C here]
# cat ircomm0 # panic here :(

There was a kernel panic.

[3.] kernel, networking, irda
[4.] Linux version 2.6.16.1 (root@zerodivide) (gcc version 3.4.5) #5 
PREEMPT Sat Apr 1 14:45:11 UTC 2006
[5.] hmm... maybe 2.6.15.6 (i don't know)
[6.] sorry, no Oops output here :(
[7.] see [2.]
[8.] BASH=/bin/bash
BASH_ARGC=()
BASH_ARGV=()
BASH_LINENO=()
BASH_SOURCE=()
BASH_VERSINFO=([0]="3" [1]="1" [2]="10" [3]="1" [4]="release" 
[5]="i686-pc-linux-gnu")
BASH_VERSION='3.1.10(1)-release'
COLORTERM=
COLUMNS=80
CPLUS_INCLUDE_PATH=/usr/lib/qt/include:/usr/lib/qt/include
DIRSTACK=()
DISPLAY=:0.0
EUID=0
GDK_USE_XFT=1
GROUPS=()
GS_LIB=/home/evil/.fonts
GTK2_RC_FILES=/etc/gtk-2.0/gtkrc:/home/evil/.gtkrc-2.0:/home/evil/.kde/share/config/gtkrc
GTK_RC_FILES=/etc/gtk/gtkrc:/home/evil/.gtkrc:/home/evil/.kde/share/config/gtkrc
HISTFILE=/root/.bash_history
HISTFILESIZE=500
HISTSIZE=500
HOME=/root
HOSTNAME=zerodivide
HOSTTYPE=i686
HUSHLOGIN=FALSE
HZ=100
IFS=$' \t\n'
INPUTRC=/etc/inputrc
JAVA_HOME=/usr/lib/java
KDEDIR=/opt/kde
KDE_FULL_SESSION=true
KDE_MULTIHEAD=false
KONSOLE_DCOP='DCOPRef(konsole-2281,konsole)'
KONSOLE_DCOP_SESSION='DCOPRef(konsole-2281,session-1)'
LANG=ru_RU.koi8r
LC_COLLATE=C
LESS=-M
LESSOPEN='|lesspipe.sh %s'
LINES=25
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.bat=01;32:*.BAT=01;32:*.btm=01;32:*.BTM=01;32:*.cmd=01;32:*.CMD=01;32:*.com=01;32:*.COM=01;32:*.dll=01;32:*.DLL=01;32:*.exe=01;32:*.EXE=01;32:*.arj=01;31:*.bz2=01;31:*.deb=01;31:*.gz=01;31:*.lzh=01;31:*.rpm=01;31:*.tar=01;31:*.taz=01;31:*.tb2=01;31:*.tbz2=01;31:*.tbz=01;31:*.tgz=01;31:*.tz2=01;31:*.z=01;31:*.Z=01;31:*.zip=01;31:*.ZIP=01;31:*.zoo=01;31:*.asf=01;35:*.ASF=01;35:*.avi=01;35:*.AVI=01;35:*.bmp=01;35:*.BMP=01;35:*.flac=01;35:*.FLAC=01;35:*.gif=01;35:*.GIF=01;35:*.jpg=01;35:*.JPG=01;35:*.jpeg=01;35:*.JPEG=01;35:*.m2a=01;35:*.M2a=01;35:*.m2v=01;35:*.M2V=01;35:*.mov=01;35:*.MOV=01;35:*.mp3=01;35:*.MP3=01;35:*.mpeg=01;35:*.MPEG=01;35:*.mpg=01;35:*.MPG=01;35:*.ogg=01;35:*.OGG=01;35:*.ppm=01;35:*.rm=01;35:*.RM=01;35:*.tga=01;35:*.TGA=01;35:*.tif=01;35:*.TIF=01;35:*.wav=01;35:*.WAV=01;35:*.wmv=01;35:*.WMV=01;35:*.xbm=01;35:*.xpm=01;35:'
LS_OPTIONS=' --color=auto -F -b -T 0'
MACHTYPE=i686-pc-linux-gnu
MAILCHECK=60
MANPATH=/usr/local/man:/usr/man:/usr/X11R6/man:/usr/lib/java/man:/usr/lib/qt/doc/man
MINICOM='-c on'
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin
PPID=2282
PS1='\u@\h:\w\$ '
PS2='> '
PS4='+ '
PWD=/usr/src/linux
QTDIR=/usr/lib/qt
SESSION_MANAGER=local/zerodivide:/tmp/.ICE-unix/2206
SHELL=/bin/bash
SHELLOPTS=braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
SHLVL=6
SUDO_COMMAND=/bin/su
SUDO_GID=100
SUDO_UID=1000
SUDO_USER=evil
T1LIB_CONFIG=/usr/share/t1lib/t1lib.config
TERM=xterm
UID=0
USER=root
WINDOWID=39845896
XAUTHORITY=/home/evil/.Xauthority
XCURSOR_SIZE=
XCURSOR_THEME=whiteglass
_=/usr/bin/sudo
[8.1.] Linux zerodivide 2.6.16.1 #5 PREEMPT Sat Apr 1 14:45:11 UTC 2006 
i686 unknown unknown GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.35
reiserfsprogs          3.6.17
reiser4progs           line
quota-tools            3.12.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   084
Modules Loaded         ppp_deflate zlib_deflate bsd_comp ppp_async vmnet 
vmmon intel_agp irda crc_ccitt nvidia cn sk98lin hw_random agpgart psmouse
[8.2.] processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3216.100
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 6437.51
[8.3.] ppp_deflate 4480 0 - Live 0xf9402000
zlib_deflate 18456 1 ppp_deflate, Live 0xf94b7000
bsd_comp 5120 0 - Live 0xf93f1000
ppp_async 7936 1 - Live 0xf93ee000
vmnet 24484 12 - Live 0xf93e1000
vmmon 169324 0 - Live 0xf940a000
intel_agp 18076 1 - Live 0xf8879000
irda 98360 0 - Live 0xf9377000
crc_ccitt 1920 2 ppp_async,irda, Live 0xf8842000
nvidia 4083920 12 - Live 0xf97a3000
cn 6432 0 - Live 0xf885d000
sk98lin 135392 0 - Live 0xf9312000
hw_random 4632 0 - Live 0xf883d000
agpgart 25520 2 intel_agp,nvidia, Live 0xf884e000
psmouse 32008 0 - Live 0xf8845000
[8.4.] 0000-001f : dma1
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1028-102f : GPE0_BLK
1080-10bf : 0000:00:1f.0
1400-141f : 0000:00:1f.3
a000-afff : PCI Bus #02
  a000-a0ff : 0000:02:09.0
    a000-a0ff : sk98lin
b000-b01f : 0000:00:1d.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
  bc00-bc1f : uhci_hcd
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel ICH5
f000-f00f : 0000:00:1f.2
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-003bc350 : Kernel code
  003bc351-004b4493 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-500fffff : PCI Bus #02
  50000000-5001ffff : 0000:02:09.0
e0000000-efffffff : PCI Bus #01
  e0000000-efffffff : 0000:01:00.0
    e0000000-e7ffffff : vesafb
f0000000-f7ffffff : 0000:00:00.0
f8000000-f9ffffff : PCI Bus #01
  f8000000-f8ffffff : 0000:01:00.0
    f8000000-f8ffffff : nvidia
  f9000000-f901ffff : 0000:01:00.0
fa000000-fbffffff : PCI Bus #02
  fb000000-fb003fff : 0000:02:09.0
    fb000000-fb003fff : sk98lin
fc000000-fc0003ff : 0000:00:1d.7
  fc000000-fc0003ff : ehci_hcd
fc001000-fc0011ff : 0000:00:1f.5
  fc001000-fc0011ff : Intel ICH5
fc002000-fc0020ff : 0000:00:1f.5
  fc002000-fc0020ff : Intel ICH5
fec00000-ffffffff : reserved
[8.5.] 00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 2570
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [0106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 
02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: e0000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 4: I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 16
        Region 4: I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 4: I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 17
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: 50000000-500fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 24d1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) 
AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device a002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 20
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=64]
        Region 2: Memory at fc001000 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at fc002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 
5600] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x8

02:09.0 Ethernet controller: Marvell Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 13)
        Subsystem: Giga-byte Technology: Unknown device e000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at a000 [size=256]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Ca00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 2570
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [0106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 
02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: e0000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 4: I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 16
        Region 4: I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 4: I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 17
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: 50000000-500fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 24d1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) 
AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device a002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 20
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=64]
        Region 2: Memory at fc001000 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at fc002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 
5600] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x8

02:09.0 Ethernet controller: Marvell Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 13)
        Subsystem: Giga-byte Technology: Unknown device e000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at a000 [size=256]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Datapabilities: [50] Vital 
Product Data
[8.6.] Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: USB Flash Memory Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
[8.7.] I have the latest irda-utils.
My cellular phone is Siemens C65.
My Linux Distribution - Slackware Linux 10.0 with a lot of updates.
---
Best regards,
[EViL] - ZeroDivide Team.
www.zerodivide.hut1.ru - evil.zd@gmail.com


