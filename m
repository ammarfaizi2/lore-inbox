Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276633AbSIVGLU>; Sun, 22 Sep 2002 02:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbSIVGLT>; Sun, 22 Sep 2002 02:11:19 -0400
Received: from mail.nls.ac.in ([202.54.87.180]:64005 "EHLO mail.nls.ac.in")
	by vger.kernel.org with ESMTP id <S276633AbSIVGLP>;
	Sun, 22 Sep 2002 02:11:15 -0400
Message-ID: <1999.202.54.87.179.1032675381.squirrel@mail.nls.ac.in>
Date: Sun, 22 Sep 2002 11:46:21 +0530 (IST)
Subject: make bzImage fails on 2.5.38
From: "Aniruddha Shankar" <ashankar@nls.ac.in>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First post to the list, I've followed the format given in REPORTING-BUGS

1. make bzImage fails on 2.5.38

2. : Error message follows:
make[2]: Entering directory `/usr/src/linux-2.5.38/fs/partitions'
  gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/usr/src/linux-2.5.38/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -I/usr/src/linux-2.5.38/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=check   -c -o check.o check.c
check.c: In function `devfs_create_cdrom':
check.c:365: `devfs_handle' undeclared (first use in this function)
check.c:365: (Each undeclared identifier is reported only once
check.c:365: for each function it appears in.)
check.c:344: warning: unused variable `symlink'
check.c:344: warning: unused variable `dirname'
check.c:343: warning: unused variable `devfs_flags'
check.c:342: warning: unused variable `slave'
check.c:342: warning: unused variable `dir'
check.c:341: warning: unused variable `pos'
make[2]: *** [check.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.38/fs/partitions'
make[1]: *** [partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.38/fs'
make: *** [fs] Error 2

3. keywords: 2.5.38 bzImage fs

4. kernel version :
Linux version 2.4.18-6mdk (root@twentyfive.complab) (gcc version 2.95.3
20010315 (release)) #3 Wed Sep 18 19:10:38 IST 2002

7. Environment:
BASH=/bin/bash
BASH_VERSINFO=([0]="2" [1]="05a" [2]="0" [3]="1" [4]="release"
[5]="i686-pc-linux-gnu")
BASH_VERSION='2.05a.0(1)-release'
CHROMIUM_DATA=/usr/share/chromium/data
CLASSPATH=/opt/blackdown-jre-1.3.1/lib/rt.jar
COLORFGBG='7;default;0'
COLORTERM=Eterm
COLORTERM_BCE=Eterm
COLUMNS=80
CONFIG_PROTECT='/usr/kde/3/share/config /usr/share/config'
CVS_RSH=ssh
DIRSTACK=()
DISPLAY=:0.0
EBIN=/usr/bin
ECACHEDIR=/home/karim/.enlightenment
ECONFDIR=/home/karim/.enlightenment
EDITOR=/usr/bin/nano
EPID=7402
EROOT=/usr/share/enlightenment
ETERM_THEME_ROOT=/home/karim/.Eterm/themes/Eterm
ETERM_USER_ROOT=/home/karim/.Eterm/themes/Eterm
ETERM_VERSION=0.9.1
ETHEME=/home/karim/.enlightenment/themes/aqua-E
EUID=1001
EVERSION=0.16.5
GROUPS=()
HISTFILE=/home/karim/.bash_history
HISTFILESIZE=500
HISTSIZE=500
HOME=/home/karim
HOSTNAME=twentyfive.complab
HOSTTYPE=i686
IFS=$' \t\n'
INFODIR=/usr/share/info:/usr/X11R6/info
INPUTRC=/etc/inputrc
JAVA_HOME=/opt/blackdown-jre-1.3.1
JRE_HOME=/opt/blackdown-jre-1.3.1
KDEDIR=/usr/kde/3
KDEDIRS=/usr/kde/3:/usr
LESSOPEN='|lesspipe.sh %s'
LINES=24
LOGNAME=karim
LS_COLORS=
MACHTYPE=i686-pc-linux-gnu
MAILCHECK=60
MANPATH=/usr/share/man:/usr/local/share/man:/usr/X11R6/man
MOZILLA_FIVE_HOME=/usr/lib/mozilla
OLDPWD=/home/karim
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PAGER=/usr/bin/less
PATH=/bin:/usr/bin:/usr/local/bin:/opt/bin:/opt/Acrobat5:/opt/opera/bin:/opt/rar/bin:/usr/X11R6/bin:/opt/blackdown-jre-1.3.1/bin:/usr/qt/3/bin:/usr/qt/2/bin:/usr/kde/3/bin:/usr/kde/3/bin:/usr/kde/3/bin:/usr/kde/2/bin:/opt/quake3
PIPESTATUS=([0]="0")
PPID=31050
PS1='\[\e]2;\u@\h \w\a\e[33;1m\]>\[\e[0m\] '
PS2='> '
PS4='+ '
PWD=/usr/src/linux
QMAKESPEC=linux-g++
QTDIR=/usr/qt/3
SANE_CONFIG_DIR=/etc/sane.d
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comments:emacs
SHLVL=2
TERM=Eterm
UID=1001
USER=karim
VIMRUNTIME=/usr/share/vim/vim61
WINDOWID=29360184
XDM_MANAGED=/var/run/xdmctl/xdmctl-:0,maysd,mayfn,sched
XINITRC=/etc/X11/xinit/xinitrc
XSESSION=enlightenment
_=/proc/version
ftp_proxy=http://192.168.100.4:3128
http_proxy=http://192.168.100.4:3128
https_proxy=http://192.168.100.4:3128

7.1. Software:
Linux twentyfive.complab 2.4.18-6mdk #3 Wed Sep 18 19:10:38 IST 2002 i686
GenuineIntel

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         snd-pcm-oss snd-pcm snd-timer snd-mixer-oss snd

7.2. Processor Information

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 851.950
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1697.38

7.3. Module Information:

snd-pcm-oss            35268   0 (autoclean) (unused)
snd-pcm                48256   0 (autoclean) [snd-pcm-oss]
snd-timer              10208   0 (autoclean) [snd-pcm]
snd-mixer-oss           8960   0 (autoclean) [snd-pcm-oss]
snd                    24776   0 (autoclean) [snd-pcm-oss snd-pcm
snd-timer snd-mixer-oss]

7.4. Loaded Driver &  Hardware Information:
cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037f : i2c (Vellemann adapter)
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : Intel Corp. 82801AA SMBus
  5000-5007 : i801-smbus
c000-cfff : PCI Bus #01
  c000-c0ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
    c000-c0ff : dmfe
d400-d4ff : Intel Corp. 82801AA AC'97 Audio
d800-d83f : Intel Corp. 82801AA AC'97 Audio
f000-f00f : Intel Corp. 82801AA IDE
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07eeffff : System RAM
  00100000-00255435 : Kernel code
  00255436-002b6e37 : Kernel data
07ef0000-07ef2fff : ACPI Non-volatile Storage
07ef3000-07efffff : ACPI Tables
d0000000-d3ffffff : Intel Corp. 82810 CGC [Chipset Graphics Controller]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d50000ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
    d5000000-d50000ff : dmfe
d6000000-d607ffff : Intel Corp. 82810 CGC [Chipset Graphics Controller]
ffb00000-ffffffff : reserved

7.5. PCI information:
00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller
Hub] (rev 03)
	Subsystem: A-Trend Technology Co Ltd: Unknown device 7400
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics
Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Intel Corp. 82810 CGC [Chipset Graphics Controller]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 5000 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
	Subsystem: Unknown device 414c:4326
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at d800 [size=64]

01:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10
MBit (rev 31)
	Subsystem: Unknown device 0291:8212
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 32 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-




