Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRA0BmI>; Fri, 26 Jan 2001 20:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRA0Bl7>; Fri, 26 Jan 2001 20:41:59 -0500
Received: from mail3.primary.net ([216.87.38.220]:51211 "EHLO
	mail3.primary.net") by vger.kernel.org with ESMTP
	id <S129774AbRA0Blo>; Fri, 26 Jan 2001 20:41:44 -0500
Message-ID: <3A7227EB.B1F7F3F2@primary.net>
Date: Fri, 26 Jan 2001 19:44:11 -0600
From: Dale Christ <dechris@primary.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0i586 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System hangs completely
Content-Type: multipart/alternative;
 boundary="------------F61A4BC1DECBE1643A91F872"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------F61A4BC1DECBE1643A91F872
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[1.] System lockup while trying to write to Fujitsu MO drive  (640MB IDE
interface)

[2.] This works under RH7.0.  Here's that I do:

    insmod ide-scsi             ; SCSI emulation needed here
    mount /dev/sda /mnt/MO      ; mount the drive
    ls -la /mnt/MO              ; see is anything's out there
    cp .bashrc /mnt/MO          ; Copy a file and watch it lock up tight

This works just fine in RH7, but dies miserably with kernel 2.4.0.

If there's any additional information that you need, let me know...

[3.] IDE-SCSI OPTICAL DRIVE LOCKUP

[4.] Kernel info:
Linux version 2.4.0i586 (root@localhost.localdomain) (gcc version 2.96
20000731 (Red Hat Linux 7.0)) #9 Fri Jan 26 15:07:33 CST 2001
[5.] OOPS info:
[6.] shell program or script
[7.] Environment:
AUTOBOOT=YES
BASH=/bin/bash
BASH_ENV=/root/.bashrc
BASH_VERSINFO=([0]="2" [1]="04" [2]="11" [3]="1" [4]="release"
[5]="i386-redhat-linux-gnu")
BASH_VERSION='2.04.11(1)-release'
BOOT_FILE=/boot/vmlinuz-2.4.0i586
BOOT_IMAGE=test2.4
COLORTERM=gnome-terminal
CONSOLE=/dev/console
DIRSTACK=()
DISPLAY=:0
EUID=0
GDMSESSION=Default
GDM_LANG=en_US
GROUPS=()
HISTSIZE=1000
HOME=/root
HOSTNAME=localhost.localdomain
HOSTTYPE=i386
IFS='
'
INIT_VERSION=sysvinit-2.78
INPUTRC=/etc/inputrc
KDEDIR=/usr
LANG=en_US
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'

MACHTYPE=i386-redhat-linux-gnu
MAIL=/var/spool/mail/root
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/usr/sbin:/sbin:/sbin:/usr/sbin:/usr/bin:/bin:/usr/X11R6/bin:/usr/local/bin:/opt/bin:/usr/X11R6/bin:/root/bin

PIPESTATUS=([0]="0")
PPID=839
PREVLEVEL=N
PS4='+ '
PWD=/root/bugrpt
QTDIR=/usr/lib/qt-2.2.0
RUNLEVEL=5
SESSION_MANAGER=local/localhost.localdomain:/tmp/.ICE-unix/693
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:interactive-comments
SHLVL=2
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
TERM=xterm
UID=0
USER=root
USERNAME=root
WINDOWID=25166054
XAUTHORITY=/root/.Xauthority
_='[7.] Environment:'
[7.1.] Software:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux localhost.localdomain 2.4.0i586 #9 Fri Jan 26 15:07:33 CST 2001
i586 unknown
Kernel modules         2.3.21
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ide-scsi tulip emu10k1
[7.2.] Processor Information:
processor : 0
vendor_id : AuthenticAMD
cpu family : 5
model  : 9
model name : AMD-K6(tm) 3D+ Processor
stepping : 1
cpu MHz  : 451.031
cache size : 256 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips : 897.84

[7.3.] Module Information:
ide-scsi                8192   1
tulip                  34192   1 (autoclean)
emu10k1                44784   1
[7.4.1.] ioports:
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
6400-641f : VIA Technologies, Inc. UHCI USB
  6400-641f : usb-uhci
6800-6807 : CMD Technology Inc PCI0649
  6800-6807 : ide2
6c00-6c03 : CMD Technology Inc PCI0649
  6c02-6c02 : ide2
7000-7007 : CMD Technology Inc PCI0649
  7000-7007 : ide3
7400-7403 : CMD Technology Inc PCI0649
  7402-7402 : ide3
7800-780f : CMD Technology Inc PCI0649
  7800-7807 : ide2
  7808-780f : ide3
7c00-7cff : Lite-On Communications Inc LNE100TX [Linksys EtherFast
10/100]
  7c00-7cff : eth0
8000-801f : Creative Labs SB Live! EMU10000
  8000-801f : EMU10K1
8400-8407 : Creative Labs SB Live!
e000-efff : PCI Bus #01
  e000-e0ff : 3Dfx Interactive, Inc. Voodoo 4
f000-f00f : VIA Technologies, Inc. Bus Master IDE
  f000-f007 : ide0
  f008-f00f : ide1
[7.4.2.] iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00277db1 : Kernel code
  00277db2-00305743 : Kernel data
a0000000-afffffff : PCI Bus #01
  a0000000-a7ffffff : 3Dfx Interactive, Inc. Voodoo 4
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 4
e0000000-e0ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e1000000-e10000ff : Lite-On Communications Inc LNE100TX [Linksys
EtherFast 10/100]
  e1000000-e10000ff : eth0
ffff0000-ffffffff : reserved
[7.5.] PCI Information
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
 Latency: 64
 Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
 Capabilities: [a0] AGP version 1.0
  Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 I/O behind bridge: 0000e000-0000efff
 Memory behind bridge: d0000000-dfffffff
 Prefetchable memory behind bridge: a0000000-afffffff
 BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 47)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64
 Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
(prog-if 00 [UHCI])
 Subsystem: Unknown device 0925:1234
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64, cache line size 08
 Interrupt: pin D routed to IRQ 11
 Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 RAID bus controller: CMD Technology Inc: Unknown device 0649
(rev 01)
 Subsystem: CMD Technology Inc: Unknown device 0649
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
 Latency: 64 (500ns min, 1000ns max)
 Interrupt: pin A routed to IRQ 10
 Region 0: I/O ports at 6800 [size=8]
 Region 1: I/O ports at 6c00 [size=4]
 Region 2: I/O ports at 7000 [size=8]
 Region 3: I/O ports at 7400 [size=4]
 Region 4: I/O ports at 7800 [size=16]
 Expansion ROM at <unassigned> [disabled] [size=512K]
 Capabilities: [60] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX Fast
Ethernet Adapter (rev 25)
 Subsystem: Lite-On Communications Inc: Unknown device c001
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
 Latency: 64 (2000ns min, 14000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 5
 Region 0: I/O ports at 7c00 [size=256]
 Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: [44] Power Management version 1
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
 Subsystem: Creative Labs CT4790 SoundBlaster PCI512
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (500ns min, 5000ns max)
 Interrupt: pin A routed to IRQ 3
 Region 0: I/O ports at 8000 [size=32]
 Capabilities: [dc] Power Management version 1
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! (rev 05)
 Subsystem: Creative Labs Gameport Joystick
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64
 Region 0: I/O ports at 8400 [size=8]
 Capabilities: [dc] Power Management version 1
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown
device 0009 (rev 01) (prog-if 00 [VGA])
 Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
 Interrupt: pin A routed to IRQ 0
 Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
 Region 1: Memory at a0000000 (32-bit, prefetchable) [size=128M]
 Region 2: I/O ports at e000 [size=256]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: [54] AGP version 2.0
  Status: RQ=15 SBA+ 64bit+ FW- Rate=x1,x2
  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
 Capabilities: [60] Power Management version 2
  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: M25-MCC3064AP    Rev: 0051
  Type:   Optical Device                   ANSI SCSI revision: 02
[7.7.] Other information :


--------------F61A4BC1DECBE1643A91F872
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>[1.] System lockup while trying to write to Fujitsu MO drive&nbsp;
(640MB IDE interface)</tt>
<br><tt>&nbsp;</tt>
<br><tt>[2.] This works under RH7.0.&nbsp; Here's that I do:</tt><tt></tt>
<p><tt>&nbsp;&nbsp;&nbsp; insmod ide-scsi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
; SCSI emulation needed here</tt>
<br><tt>&nbsp;&nbsp;&nbsp; mount /dev/sda /mnt/MO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
; mount the drive</tt>
<br><tt>&nbsp;&nbsp;&nbsp; ls -la /mnt/MO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
; see is anything's out there</tt>
<br><tt>&nbsp;&nbsp;&nbsp; cp .bashrc /mnt/MO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
; Copy a file and watch it lock up tight</tt><tt></tt>
<p><tt>This works just fine in RH7, but dies miserably with kernel 2.4.0.</tt><tt></tt>
<p><tt>If there's any additional information that you need, let me know...</tt><tt></tt>
<p><tt>[3.] IDE-SCSI OPTICAL DRIVE LOCKUP</tt><tt></tt>
<p><tt>[4.] Kernel info:</tt>
<br><tt>Linux version 2.4.0i586 (root@localhost.localdomain) (gcc version
2.96 20000731 (Red Hat Linux 7.0)) #9 Fri Jan 26 15:07:33 CST 2001</tt>
<br><tt>[5.] OOPS info:</tt>
<br><tt>[6.] shell program or script</tt>
<br><tt>[7.] Environment:</tt>
<br><tt>AUTOBOOT=YES</tt>
<br><tt>BASH=/bin/bash</tt>
<br><tt>BASH_ENV=/root/.bashrc</tt>
<br><tt>BASH_VERSINFO=([0]="2" [1]="04" [2]="11" [3]="1" [4]="release"
[5]="i386-redhat-linux-gnu")</tt>
<br><tt>BASH_VERSION='2.04.11(1)-release'</tt>
<br><tt>BOOT_FILE=/boot/vmlinuz-2.4.0i586</tt>
<br><tt>BOOT_IMAGE=test2.4</tt>
<br><tt>COLORTERM=gnome-terminal</tt>
<br><tt>CONSOLE=/dev/console</tt>
<br><tt>DIRSTACK=()</tt>
<br><tt>DISPLAY=:0</tt>
<br><tt>EUID=0</tt>
<br><tt>GDMSESSION=Default</tt>
<br><tt>GDM_LANG=en_US</tt>
<br><tt>GROUPS=()</tt>
<br><tt>HISTSIZE=1000</tt>
<br><tt>HOME=/root</tt>
<br><tt>HOSTNAME=localhost.localdomain</tt>
<br><tt>HOSTTYPE=i386</tt>
<br><tt>IFS='</tt>
<br><tt>'</tt>
<br><tt>INIT_VERSION=sysvinit-2.78</tt>
<br><tt>INPUTRC=/etc/inputrc</tt>
<br><tt>KDEDIR=/usr</tt>
<br><tt>LANG=en_US</tt>
<br><tt>LESSOPEN='|/usr/bin/lesspipe.sh %s'</tt>
<br><tt>LOGNAME=root</tt>
<br><tt>LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'</tt>
<br><tt>MACHTYPE=i386-redhat-linux-gnu</tt>
<br><tt>MAIL=/var/spool/mail/root</tt>
<br><tt>OPTERR=1</tt>
<br><tt>OPTIND=1</tt>
<br><tt>OSTYPE=linux-gnu</tt>
<br><tt>PATH=/usr/local/sbin:/usr/sbin:/sbin:/sbin:/usr/sbin:/usr/bin:/bin:/usr/X11R6/bin:/usr/local/bin:/opt/bin:/usr/X11R6/bin:/root/bin</tt>
<br><tt>PIPESTATUS=([0]="0")</tt>
<br><tt>PPID=839</tt>
<br><tt>PREVLEVEL=N</tt>
<br><tt>PS4='+ '</tt>
<br><tt>PWD=/root/bugrpt</tt>
<br><tt>QTDIR=/usr/lib/qt-2.2.0</tt>
<br><tt>RUNLEVEL=5</tt>
<br><tt>SESSION_MANAGER=local/localhost.localdomain:/tmp/.ICE-unix/693</tt>
<br><tt>SHELL=/bin/bash</tt>
<br><tt>SHELLOPTS=braceexpand:hashall:interactive-comments</tt>
<br><tt>SHLVL=2</tt>
<br><tt>SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass</tt>
<br><tt>TERM=xterm</tt>
<br><tt>UID=0</tt>
<br><tt>USER=root</tt>
<br><tt>USERNAME=root</tt>
<br><tt>WINDOWID=25166054</tt>
<br><tt>XAUTHORITY=/root/.Xauthority</tt>
<br><tt>_='[7.] Environment:'</tt>
<br><tt>[7.1.] Software:</tt>
<br><tt>-- Versions installed: (if some fields are empty or look</tt>
<br><tt>-- unusual then possibly you have very old versions)</tt>
<br><tt>Linux localhost.localdomain 2.4.0i586 #9 Fri Jan 26 15:07:33 CST
2001 i586 unknown</tt>
<br><tt>Kernel modules&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.3.21</tt>
<br><tt>Gnu C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.96</tt>
<br><tt>Gnu Make&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3.79.1</tt>
<br><tt>Binutils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.10.0.18</tt>
<br><tt>Linux C Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; > libc.2.2</tt>
<br><tt>Dynamic linker&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ldd (GNU libc) 2.2</tt>
<br><tt>Procps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.0.7</tt>
<br><tt>Mount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.10m</tt>
<br><tt>Net-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1.56</tt>
<br><tt>Console-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0.3.3</tt>
<br><tt>Sh-utils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2.0</tt>
<br><tt>Modules Loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ide-scsi tulip emu10k1</tt>
<br><tt>[7.2.] Processor Information:</tt>
<br><tt>processor : 0</tt>
<br><tt>vendor_id : AuthenticAMD</tt>
<br><tt>cpu family : 5</tt>
<br><tt>model&nbsp; : 9</tt>
<br><tt>model name : AMD-K6(tm) 3D+ Processor</tt>
<br><tt>stepping : 1</tt>
<br><tt>cpu MHz&nbsp; : 451.031</tt>
<br><tt>cache size : 256 KB</tt>
<br><tt>fdiv_bug : no</tt>
<br><tt>hlt_bug&nbsp; : no</tt>
<br><tt>f00f_bug : no</tt>
<br><tt>coma_bug : no</tt>
<br><tt>fpu&nbsp; : yes</tt>
<br><tt>fpu_exception : yes</tt>
<br><tt>cpuid level : 1</tt>
<br><tt>wp&nbsp; : yes</tt>
<br><tt>flags&nbsp; : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr</tt>
<br><tt>bogomips : 897.84</tt><tt></tt>
<p><tt>[7.3.] Module Information:</tt>
<br><tt>ide-scsi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8192&nbsp;&nbsp; 1</tt>
<br><tt>tulip&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
34192&nbsp;&nbsp; 1 (autoclean)</tt>
<br><tt>emu10k1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
44784&nbsp;&nbsp; 1</tt>
<br><tt>[7.4.1.] ioports:</tt>
<br><tt>0000-001f : dma1</tt>
<br><tt>0020-003f : pic1</tt>
<br><tt>0040-005f : timer</tt>
<br><tt>0060-006f : keyboard</tt>
<br><tt>0080-008f : dma page reg</tt>
<br><tt>00a0-00bf : pic2</tt>
<br><tt>00c0-00df : dma2</tt>
<br><tt>00f0-00ff : fpu</tt>
<br><tt>0170-0177 : ide1</tt>
<br><tt>01f0-01f7 : ide0</tt>
<br><tt>0376-0376 : ide1</tt>
<br><tt>0378-037a : parport0</tt>
<br><tt>03c0-03df : vga+</tt>
<br><tt>03f6-03f6 : ide0</tt>
<br><tt>03f8-03ff : serial(auto)</tt>
<br><tt>0cf8-0cff : PCI conf1</tt>
<br><tt>5000-50ff : VIA Technologies, Inc. VT82C586B ACPI</tt>
<br><tt>6400-641f : VIA Technologies, Inc. UHCI USB</tt>
<br><tt>&nbsp; 6400-641f : usb-uhci</tt>
<br><tt>6800-6807 : CMD Technology Inc PCI0649</tt>
<br><tt>&nbsp; 6800-6807 : ide2</tt>
<br><tt>6c00-6c03 : CMD Technology Inc PCI0649</tt>
<br><tt>&nbsp; 6c02-6c02 : ide2</tt>
<br><tt>7000-7007 : CMD Technology Inc PCI0649</tt>
<br><tt>&nbsp; 7000-7007 : ide3</tt>
<br><tt>7400-7403 : CMD Technology Inc PCI0649</tt>
<br><tt>&nbsp; 7402-7402 : ide3</tt>
<br><tt>7800-780f : CMD Technology Inc PCI0649</tt>
<br><tt>&nbsp; 7800-7807 : ide2</tt>
<br><tt>&nbsp; 7808-780f : ide3</tt>
<br><tt>7c00-7cff : Lite-On Communications Inc LNE100TX [Linksys EtherFast
10/100]</tt>
<br><tt>&nbsp; 7c00-7cff : eth0</tt>
<br><tt>8000-801f : Creative Labs SB Live! EMU10000</tt>
<br><tt>&nbsp; 8000-801f : EMU10K1</tt>
<br><tt>8400-8407 : Creative Labs SB Live!</tt>
<br><tt>e000-efff : PCI Bus #01</tt>
<br><tt>&nbsp; e000-e0ff : 3Dfx Interactive, Inc. Voodoo 4</tt>
<br><tt>f000-f00f : VIA Technologies, Inc. Bus Master IDE</tt>
<br><tt>&nbsp; f000-f007 : ide0</tt>
<br><tt>&nbsp; f008-f00f : ide1</tt>
<br><tt>[7.4.2.] iomem:</tt>
<br><tt>00000000-0009fbff : System RAM</tt>
<br><tt>0009fc00-0009ffff : reserved</tt>
<br><tt>000a0000-000bffff : Video RAM area</tt>
<br><tt>000c0000-000c7fff : Video ROM</tt>
<br><tt>000c8000-000ca5ff : Extension ROM</tt>
<br><tt>000f0000-000fffff : System ROM</tt>
<br><tt>00100000-07ffffff : System RAM</tt>
<br><tt>&nbsp; 00100000-00277db1 : Kernel code</tt>
<br><tt>&nbsp; 00277db2-00305743 : Kernel data</tt>
<br><tt>a0000000-afffffff : PCI Bus #01</tt>
<br><tt>&nbsp; a0000000-a7ffffff : 3Dfx Interactive, Inc. Voodoo 4</tt>
<br><tt>d0000000-dfffffff : PCI Bus #01</tt>
<br><tt>&nbsp; d0000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 4</tt>
<br><tt>e0000000-e0ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]</tt>
<br><tt>e1000000-e10000ff : Lite-On Communications Inc LNE100TX [Linksys
EtherFast 10/100]</tt>
<br><tt>&nbsp; e1000000-e10000ff : eth0</tt>
<br><tt>ffff0000-ffffffff : reserved</tt>
<br><tt>[7.5.] PCI Information</tt>
<br><tt>00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3]
(rev 04)</tt>
<br><tt>&nbsp;Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR+</tt>
<br><tt>&nbsp;Latency: 64</tt>
<br><tt>&nbsp;Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]</tt>
<br><tt>&nbsp;Capabilities: [a0] AGP version 1.0</tt>
<br><tt>&nbsp; Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2</tt>
<br><tt>&nbsp; Command: RQ=0 SBA- AGP- 64bit- FW- Rate=&lt;none></tt><tt></tt>
<p><tt>00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3
AGP] (prog-if 00 [Normal decode])</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort+ >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 0</tt>
<br><tt>&nbsp;Bus: primary=00, secondary=01, subordinate=01, sec-latency=0</tt>
<br><tt>&nbsp;I/O behind bridge: 0000e000-0000efff</tt>
<br><tt>&nbsp;Memory behind bridge: d0000000-dfffffff</tt>
<br><tt>&nbsp;Prefetchable memory behind bridge: a0000000-afffffff</tt>
<br><tt>&nbsp;BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-</tt><tt></tt>
<p><tt>00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 47)</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 0</tt><tt></tt>
<p><tt>00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo]
(rev 06) (prog-if 8a [Master SecP PriP])</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 64</tt>
<br><tt>&nbsp;Region 4: I/O ports at f000 [size=16]</tt><tt></tt>
<p><tt>00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev
02) (prog-if 00 [UHCI])</tt>
<br><tt>&nbsp;Subsystem: Unknown device 0925:1234</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 64, cache line size 08</tt>
<br><tt>&nbsp;Interrupt: pin D routed to IRQ 11</tt>
<br><tt>&nbsp;Region 4: I/O ports at 6400 [size=32]</tt><tt></tt>
<p><tt>00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)</tt>
<br><tt>&nbsp;Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt><tt></tt>
<p><tt>00:0a.0 RAID bus controller: CMD Technology Inc: Unknown device
0649 (rev 01)</tt>
<br><tt>&nbsp;Subsystem: CMD Technology Inc: Unknown device 0649</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR+</tt>
<br><tt>&nbsp;Latency: 64 (500ns min, 1000ns max)</tt>
<br><tt>&nbsp;Interrupt: pin A routed to IRQ 10</tt>
<br><tt>&nbsp;Region 0: I/O ports at 6800 [size=8]</tt>
<br><tt>&nbsp;Region 1: I/O ports at 6c00 [size=4]</tt>
<br><tt>&nbsp;Region 2: I/O ports at 7000 [size=8]</tt>
<br><tt>&nbsp;Region 3: I/O ports at 7400 [size=4]</tt>
<br><tt>&nbsp;Region 4: I/O ports at 7800 [size=16]</tt>
<br><tt>&nbsp;Expansion ROM at &lt;unassigned> [disabled] [size=512K]</tt>
<br><tt>&nbsp;Capabilities: [60] Power Management version 2</tt>
<br><tt>&nbsp; Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)</tt>
<br><tt>&nbsp; Status: D0 PME-Enable- DSel=0 DScale=3 PME-</tt><tt></tt>
<p><tt>00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX
Fast Ethernet Adapter (rev 25)</tt>
<br><tt>&nbsp;Subsystem: Lite-On Communications Inc: Unknown device c001</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR+</tt>
<br><tt>&nbsp;Latency: 64 (2000ns min, 14000ns max), cache line size 08</tt>
<br><tt>&nbsp;Interrupt: pin A routed to IRQ 5</tt>
<br><tt>&nbsp;Region 0: I/O ports at 7c00 [size=256]</tt>
<br><tt>&nbsp;Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]</tt>
<br><tt>&nbsp;Expansion ROM at &lt;unassigned> [disabled] [size=64K]</tt>
<br><tt>&nbsp;Capabilities: [44] Power Management version 1</tt>
<br><tt>&nbsp; Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA PME(D0-,D1+,D2+,D3hot+,D3cold+)</tt>
<br><tt>&nbsp; Status: D0 PME-Enable- DSel=0 DScale=0 PME-</tt><tt></tt>
<p><tt>00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)</tt>
<br><tt>&nbsp;Subsystem: Creative Labs CT4790 SoundBlaster PCI512</tt>
<br><tt>&nbsp;Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 64 (500ns min, 5000ns max)</tt>
<br><tt>&nbsp;Interrupt: pin A routed to IRQ 3</tt>
<br><tt>&nbsp;Region 0: I/O ports at 8000 [size=32]</tt>
<br><tt>&nbsp;Capabilities: [dc] Power Management version 1</tt>
<br><tt>&nbsp; Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)</tt>
<br><tt>&nbsp; Status: D0 PME-Enable- DSel=0 DScale=0 PME-</tt><tt></tt>
<p><tt>00:0c.1 Input device controller: Creative Labs SB Live! (rev 05)</tt>
<br><tt>&nbsp;Subsystem: Creative Labs Gameport Joystick</tt>
<br><tt>&nbsp;Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR-</tt>
<br><tt>&nbsp;Latency: 64</tt>
<br><tt>&nbsp;Region 0: I/O ports at 8400 [size=8]</tt>
<br><tt>&nbsp;Capabilities: [dc] Power Management version 1</tt>
<br><tt>&nbsp; Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)</tt>
<br><tt>&nbsp; Status: D0 PME-Enable- DSel=0 DScale=0 PME-</tt><tt></tt>
<p><tt>01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown
device 0009 (rev 01) (prog-if 00 [VGA])</tt>
<br><tt>&nbsp;Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004</tt>
<br><tt>&nbsp;Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-</tt>
<br><tt>&nbsp;Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
&lt;TAbort- &lt;MAbort- >SERR- &lt;PERR+</tt>
<br><tt>&nbsp;Interrupt: pin A routed to IRQ 0</tt>
<br><tt>&nbsp;Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]</tt>
<br><tt>&nbsp;Region 1: Memory at a0000000 (32-bit, prefetchable) [size=128M]</tt>
<br><tt>&nbsp;Region 2: I/O ports at e000 [size=256]</tt>
<br><tt>&nbsp;Expansion ROM at &lt;unassigned> [disabled] [size=64K]</tt>
<br><tt>&nbsp;Capabilities: [54] AGP version 2.0</tt>
<br><tt>&nbsp; Status: RQ=15 SBA+ 64bit+ FW- Rate=x1,x2</tt>
<br><tt>&nbsp; Command: RQ=0 SBA- AGP- 64bit- FW- Rate=&lt;none></tt>
<br><tt>&nbsp;Capabilities: [60] Power Management version 2</tt>
<br><tt>&nbsp; Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)</tt>
<br><tt>&nbsp; Status: D0 PME-Enable- DSel=0 DScale=0 PME-</tt><tt></tt>
<p><tt>[7.6.] SCSI information:</tt>
<br><tt>Attached devices:</tt>
<br><tt>Host: scsi0 Channel: 00 Id: 00 Lun: 00</tt>
<br><tt>&nbsp; Vendor: FUJITSU&nbsp; Model: M25-MCC3064AP&nbsp;&nbsp;&nbsp;
Rev: 0051</tt>
<br><tt>&nbsp; Type:&nbsp;&nbsp; Optical Device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ANSI SCSI revision: 02</tt>
<br><tt>[7.7.] Other information :</tt>
<br>&nbsp;</html>

--------------F61A4BC1DECBE1643A91F872--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
