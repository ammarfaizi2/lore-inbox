Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbTGHDJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbTGHDJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:09:58 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.92.226.153]:45728 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266233AbTGHDJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:09:41 -0400
Reply-To: <dlfern@rochester.rr.com>
From: "Dave and Leonie Fernandes" <dlfern@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: BUG REPORT for 2.4.21 kernel
Date: Mon, 7 Jul 2003 23:24:15 -0400
Message-ID: <002601c34500$69289650$0a30a8c0@dlfern.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0027_01C344DE.E216F650"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C344DE.E216F650
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Please see the attached bug report!

Thanks
Dave Fernandes

 

------=_NextPart_000_0027_01C344DE.E216F650
Content-Type: application/octet-stream;
	name="bugrpt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bugrpt"

=0A=
[1.] Cannot boot version 2.4.21 on my i386 machine, error message is =
hda1 not ready.=0A=
=0A=
[2.] Cannot boot after building version 2.4.21 using the same config =
file used for 2.4.20.  Version 2.4.20 works just fine, the problem seems =
to be with the IDE driver.  I get a message that hda1 is not ready =
during the boot process.=0A=
=0A=
[3.] boot,hda,not ready.=0A=
=0A=
=0A=
=0A=
***** NOTICE THE FOLLOWING OUTPUT IS FROM THE 2.4.20 SYSTEM THAT DOES =
BOOT *****=0A=
=0A=
=0A=
[4.]=0A=
Linux version 2.4.20 (root@dlpc01u) (gcc version 3.2.2) #14 SMP Mon Jul =
7 14:41:22 EDT 2003=0A=
=0A=
[5.] N/A=0A=
=0A=
[6.] N/A=0A=
=0A=
[7.]=0A=
BASH=3D/bin/bash=0A=
BASH_VERSINFO=3D([0]=3D"2" [1]=3D"05b" [2]=3D"0" [3]=3D"1" =
[4]=3D"release" [5]=3D"i386-slackware-linux-gnu")=0A=
BASH_VERSION=3D'2.05b.0(1)-release'=0A=
COLORTERM=3D=0A=
COLUMNS=3D80=0A=
CPLUS_INCLUDE_PATH=3D/usr/lib/qt-3.1.2/include:/usr/lib/qt-3.1.2/include=0A=
DIRSTACK=3D()=0A=
DISPLAY=3D:0.0=0A=
EUID=3D0=0A=
GDK_USE_XFT=3D1=0A=
GROUPS=3D()=0A=
GS_LIB=3D/root/.kde/share/fonts=0A=
GTK_RC_FILES=3D/etc/gtk/gtkrc:/root/.gtkrc:/root/.gtkrc-kde=0A=
HISTFILE=3D/root/.bash_history=0A=
HISTFILESIZE=3D500=0A=
HISTSIZE=3D500=0A=
HOME=3D/root=0A=
HOSTNAME=3Ddlpc01u.dlfern.com=0A=
HOSTTYPE=3Di386=0A=
HUSHLOGIN=3DFALSE=0A=
HZ=3D100=0A=
IFS=3D$' \t\n'=0A=
INPUTRC=3D/etc/inputrc=0A=
KDEDIR=3D/opt/kde=0A=
KDE_MULTIHEAD=3Dfalse=0A=
KONSOLE_DCOP=3D'DCOPRef(konsole-550,konsole)'=0A=
KONSOLE_DCOP_SESSION=3D'DCOPRef(konsole-550,session-1)'=0A=
LANG=3DC=0A=
LESS=3D-M=0A=
LESSOPEN=3D'|lesspipe.sh %s'=0A=
LINES=3D25=0A=
LOGNAME=3Ddferna01=0A=
LS_COLORS=3D'no=3D00:fi=3D00:di=3D01;34:ln=3D01;36:pi=3D40;33:so=3D01;35:=
bd=3D40;33;01:cd=3D40;33;01:or=3D40;31;01:ex=3D01;32:*.cmd=3D01;32:*.exe=3D=
01;32:*.com=3D01;32:*.btm=3D01;32:*.bat=3D01;32:*.tar=3D01;31:*.tgz=3D01;=
31:*.arj=3D01;31:*.taz=3D01;31:*.lzh=3D01;31:*.zip=3D01;31:*.bz2=3D01;31:=
*.rpm=3D01;31:*.deb=3D01;31:*.z=3D01;31:*.Z=3D01;31:*.gz=3D01;31:*.jpg=3D=
01;35:*.gif=3D01;35:*.bmp=3D01;35:*.ppm=3D01;35:*.tga=3D01;35:*.xbm=3D01;=
35:*.xpm=3D01;35:*.tif=3D01;35:*.mpg=3D01;37:*.avi=3D01;37:*.mov=3D01;37:=
'=0A=
LS_OPTIONS=3D' --color=3Dauto -F -b -T 0'=0A=
MACHTYPE=3Di386-slackware-linux-gnu=0A=
MAIL=3D/var/spool/mail/dferna01=0A=
MAILCHECK=3D60=0A=
MANPATH=3D/usr/local/man:/usr/man:/usr/X11R6/man:/usr/lib/qt-3.1.2/doc/ma=
n:/usr/share/texmf/man=0A=
MINICOM=3D'-c on'=0A=
OLDPWD=3D/etc=0A=
OPTERR=3D1=0A=
OPTIND=3D1=0A=
OSTYPE=3Dlinux-gnu=0A=
PATH=3D/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/=
X11R6/bin:/usr/games:/opt/www/htdig/bin:/opt/kde/bin:/usr/lib/qt-3.1.2/bi=
n:/usr/share/texmf/bin=0A=
PIPESTATUS=3D([0]=3D"0")=0A=
PPID=3D550=0A=
PS1=3D'\u@\h:\w\$ '=0A=
PS2=3D'> '=0A=
PS4=3D'+ '=0A=
PWD=3D/root=0A=
QTDIR=3D/usr/lib/qt-3.1.2=0A=
SESSION_MANAGER=3Dlocal/dlpc01u:/tmp/.ICE-unix/481=0A=
SHELL=3D/bin/bash=0A=
SHELLOPTS=3Dbraceexpand:emacs:hashall:histexpand:history:interactive-comm=
ents:monitor=0A=
SHLVL=3D5=0A=
T1LIB_CONFIG=3D/usr/share/t1lib/t1lib.config=0A=
TERM=3Dxterm=0A=
UID=3D0=0A=
USER=3Ddferna01=0A=
WINDOW_MANAGER=3Dmetacity=0A=
XAUTHORITY=3D/root/.Xauthority=0A=
_=3Dx.x=0A=
file=3D/etc/profile.d/tetex.sh=0A=
=0A=
[7.1.] N/A=0A=
=0A=
[7.2.]=0A=
processor	: 0=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 5=0A=
model		: 4=0A=
model name	: Pentium MMX=0A=
stepping	: 3=0A=
cpu MHz		: 232.674=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: yes=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 1=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr mce cx8 apic mmx=0A=
bogomips	: 463.66=0A=
=0A=
processor	: 1=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 5=0A=
model		: 4=0A=
model name	: Pentium MMX=0A=
stepping	: 3=0A=
cpu MHz		: 232.674=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: yes=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 1=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr mce cx8 apic mmx=0A=
bogomips	: 463.66=0A=
=0A=
[7.3.]=0A=
r128                   75256  15=0A=
ipt_state                536   2 (autoclean)=0A=
ipt_LOG                 3416   1 (autoclean)=0A=
iptable_filter          1644   1 (autoclean)=0A=
ip_nat_ftp              3120   0 (unused)=0A=
iptable_nat            15992   2 [ip_nat_ftp]=0A=
ip_conntrack_irc        2960   0 (unused)=0A=
ip_conntrack_ftp        4016   1 [ip_nat_ftp]=0A=
ip_conntrack           19808   4 [ipt_state ip_nat_ftp iptable_nat =
ip_conntrack_irc ip_conntrack_ftp]=0A=
ip_tables              12120   6 [ipt_state ipt_LOG iptable_filter =
iptable_nat]=0A=
usb-uhci               22668   0 (unused)=0A=
usbcore                57856   1 [usb-uhci]=0A=
cmpci                  32368   1=0A=
soundcore               3524   4 [cmpci]=0A=
3c509                  10420   1=0A=
isa-pnp                29988   0 [3c509]=0A=
=0A=
=0A=
[7.4.1]=0A=
0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=
0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00f0-00ff : fpu=0A=
01f0-01f7 : ide0=0A=
0300-030f : 3c509=0A=
0330-0331 : cmpci Midi=0A=
0388-038b : cmpci FM=0A=
03c0-03df : vga+=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial(auto)=0A=
0cf8-0cff : PCI conf1=0A=
6000-601f : Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]=0A=
  6000-601f : usb-uhci=0A=
6400-64ff : C-Media Electronics Inc CM8738=0A=
  6400-64ff : cmpci=0A=
6800-68ff : LSI Logic / Symbios Logic (formerly NCR) 53c875=0A=
  6800-687f : sym53c8xx=0A=
6c00-6c3f : 3Com Corporation 3c905 100BaseTX [Boomerang]=0A=
  6c00-6c3f : 00:13.0=0A=
7000-70ff : ATI Technologies Inc Rage 128 PD/PRO TMDS=0A=
f000-f00f : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]=0A=
  f000-f007 : ide0=0A=
=0A=
[7.4.2]=0A=
00000000-0009fbff : System RAM=0A=
0009fc00-0009ffff : reserved=0A=
000a0000-000bffff : Video RAM area=0A=
000c0000-000c7fff : Video ROM=0A=
000f0000-000fffff : System ROM=0A=
00100000-0bffffff : System RAM=0A=
  00100000-00226ff1 : Kernel code=0A=
  00226ff2-00271c1f : Kernel data=0A=
e0000000-e3ffffff : ATI Technologies Inc Rage 128 PD/PRO TMDS=0A=
e4000000-e4003fff : ATI Technologies Inc Rage 128 PD/PRO TMDS=0A=
e4004000-e40040ff : LSI Logic / Symbios Logic (formerly NCR) 53c875=0A=
e4005000-e4005fff : LSI Logic / Symbios Logic (formerly NCR) 53c875=0A=
fec00000-fec00fff : reserved=0A=
fee00000-fee00fff : reserved=0A=
ffff0000-ffffffff : reserved=0A=
=0A=
[7.5.]=0A=
00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 64=0A=
=0A=
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] =
(rev 01)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] =
(prog-if 80 [Master])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 4: I/O ports at f000 [size=3D16]=0A=
=0A=
00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] =
(rev 01) (prog-if 00 [UHCI])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Interrupt: pin D routed to IRQ 11=0A=
	Region 4: I/O ports at 6000 [size=3D32]=0A=
=0A=
00:11.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev =
10)=0A=
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (500ns min, 6000ns max)=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at 6400 [size=3D256]=0A=
	Capabilities: [c0] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:12.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev =
03)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (4250ns min, 16000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: I/O ports at 6800 [size=3D256]=0A=
	Region 1: Memory at e4004000 (32-bit, non-prefetchable) [size=3D256]=0A=
	Region 2: Memory at e4005000 (32-bit, non-prefetchable) [size=3D4K]=0A=
=0A=
00:13.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (750ns min, 2000ns max)=0A=
	Interrupt: pin A routed to IRQ 5=0A=
	Region 0: I/O ports at 6c00 [size=3D64]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D64K]=0A=
=0A=
00:14.0 VGA compatible controller: ATI Technologies Inc Rage 128 PD/PRO =
TMDS (prog-if 00 [VGA])=0A=
	Subsystem: ATI Technologies Inc Rage 128 AIW=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (2000ns min), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]=0A=
	Region 1: I/O ports at 7000 [size=3D256]=0A=
	Region 2: Memory at e4000000 (32-bit, non-prefetchable) [size=3D16K]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D128K]=0A=
	Capabilities: [5c] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
[7.6.]=0A=
Attached devices: =0A=
Host: scsi0 Channel: 00 Id: 00 Lun: 00=0A=
  Vendor: EXABYTE  Model: EXB-850085QANXRC Rev: 06L0=0A=
  Type:   Sequential-Access                ANSI SCSI revision: 02=0A=
Host: scsi0 Channel: 00 Id: 01 Lun: 00=0A=
  Vendor: QUANTUM  Model: FIREBALL_TM3200S Rev: 300X=0A=
  Type:   Direct-Access                    ANSI SCSI revision: 02=0A=
=0A=
=0A=

------=_NextPart_000_0027_01C344DE.E216F650--

