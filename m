Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269913AbUJGX3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbUJGX3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUJGXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:24:59 -0400
Received: from smtp1.vol.cz ([195.250.128.73]:18190 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id S269925AbUJGXTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:19:49 -0400
Date: Thu, 7 Oct 2004 23:23:11 +0200
From: Karel Babka <dekls@volny.cz>
To: calle@calle.de
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: In function `capi_recv_message':drivers/isdn/capi/capi.c:649: error: `tty' undeclared
Message-ID: <20041007212311.GB2440@dekls>
Mail-Followup-To: Karel Babka <dekls@volny.cz>, calle@calle.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux drake 2.4.22-1.2149.nptlcustom.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
In function `capi_recv_message':drivers/isdn/capi/capi.c:649: error: `tty' undeclared

[2.] Full description of the problem/report:

There is an undeclared symbol  `tty' in drivers/isdn/capi/capi.o
I have got an error message during kernel building:

<cat>
  CC [M]  drivers/isdn/capi/kcapi.o
  CC [M]  drivers/isdn/capi/capiutil.o
  CC [M]  drivers/isdn/capi/capilib.o
  CC [M]  drivers/isdn/capi/kcapi_proc.o
  LD [M]  drivers/isdn/capi/kernelcapi.o
  CC [M]  drivers/isdn/capi/capi.o
drivers/isdn/capi/capi.c: In function `capi_recv_message':
drivers/isdn/capi/capi.c:649: error: `tty' undeclared (first use in this function)
drivers/isdn/capi/capi.c:649: error: (Each undeclared identifier is reported only once
drivers/isdn/capi/capi.c:649: error: for each function it appears in.)
make[3]: *** [drivers/isdn/capi/capi.o] Error 1
make[2]: *** [drivers/isdn/capi] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2
</cat>

[3.] Keywords (i.e., modules, networking, kernel):
modules

[4.] Kernel version (from /proc/version):
Linux version 2.4.22-1.2149.nptlcustom.1 (root@drake) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #2 St led 28 23:28:12 CET 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
BASH=/bin/bash
BASH_ENV=/root/.bashrc
BASH_VERSINFO=([0]="2" [1]="05b" [2]="0" [3]="1" [4]="release" [5]="i386-redhat-linux-gnu")
BASH_VERSION='2.05b.0(1)-release'
CDR_SECURITY=8:dvd,clone:sparc-sun-solaris2,i386-pc-solaris2,i586-pc-linux,powerpc-apple,hppa,powerpc-ibm-aix,i386-unknown-freebCOLORS=/root/.dir_colors
COLUMNS=128
DIRSTACK=()
DWNL=/root/tmp
EUID=0
GROUPS=()
G_BROKEN_FILENAMES=1
HISTCONTROL=ignorespace
HISTFILE=/root/.bash_history
HISTFILESIZE=1000
HISTSIZE=1000
HOME=/root
HOSTNAME=drake
HOSTTYPE=i386
IFS=$' \t\n'
INPUTRC=/etc/inputrc
KDEDIR=/usr
LANG=cs_CZ.ISO-8859-2
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LINES=48
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=MACHTYPE=i386-redhat-linux-gnu
MAIL=/root/Maidir
MAILCHECK=60
MANPATH=/usr/lib/courier-imap/man:
MC_TMPDIR=/tmp/mc-root
OLDPWD=/root
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PAGER=/usr/bin/w3m
PATH=/root/bin:/usr/kerberos/sbin:/usr/kerberos/bin:/usr/lib/courier-imap/sbin:/usr/lib/courier-imap/bin:/usr/local/sbin:/usr/loPIPESTATUS=([0]="0")
PPID=7215
PROMPT_COMMAND='pwd>&9;kill -STOP $$'
PS1='\[\033[01;33m\]\u@\h \w >\[\033[00;37;44m\]'
PS2='> '
PS4='+ '
PWD=/root/temp
QTDIR=/usr/lib/qt-3.3
SHELL=/bin/bash
SHELLOPTS=braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
SHLVL=2
SUPPORTED=cs_CZ:cs:en_US.iso885915:en_US:en
TEMP=/root/temp
TERM=linux
UID=0
USER=root
USERNAME=root

[7.1.] Software (add the output of the ver_linux script here)
Linux drake 2.4.22-1.2149.nptlcustom.1 #2 St led 28 23:28:12 CET 2004 i686 i686 i386 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      /lib/modules/2.4.22-1.2149.nptlcustom.1/kernel/arch/i386/kernel/powernow-k7.o
e2fsprogs              1.35
reiserfsprogs          3.6.13
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nls_iso8859-1 sr_mod udf i810_audio ac97_codec soundcore ipt_REDIRECT ipt_MASQUERADE ipt_state ipt_REJECT ipt_LOG ipt_limit iptable_nat ip_conntrack iptable_filter ip_tables capi capifs parport_pc lp parport autofs4 sunrpc r8169 capidrv isdn slhc microcode ide-scsi fxusb kernelcapi capiutil ide-cd cdrom dm-mod usb-uhci usbcore ata_piix libata sd_mod scsi_mod
ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2800.134
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
ht tm pbe cid

[7.3.] Module information (from /proc/modules):
see 7.1
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0c00-0c1f : Intel Corp. 82801EB SMBus Controller
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9800-98ff : PCI device 1002:5964 (ATI Technologies Inc)
a800-a8ff : Realtek Semiconductor Co., Ltd. RTL-8169
  a800-a8ff : eth0
ac00-ac3f : Promise Technology, Inc. 20267
  ac00-ac07 : ide2
  ac08-ac0f : ide3
  ac10-ac3f : PDC20267
b000-b003 : Promise Technology, Inc. 20267
b400-b407 : Promise Technology, Inc. 20267
b800-b803 : Promise Technology, Inc. 20267
  b802-b802 : ide2
bc00-bc07 : Promise Technology, Inc. 20267
  bc00-bc07 : ide2
c400-c43f : Intel Corp. 82801EB AC'97 Audio Controller
  c400-c43f : Intel ICH5
c800-c8ff : Intel Corp. 82801EB AC'97 Audio Controller
  c800-c8ff : Intel ICH5
cc00-cc1f : Intel Corp. 82801EB USB
  cc00-cc1f : usb-uhci
d000-d01f : Intel Corp. 82801EB USB
  d000-d01f : usb-uhci
d400-d41f : Intel Corp. 82801EB USB
  d400-d41f : usb-uhci
d800-d81f : Intel Corp. 82801EB USB
  d800-d81f : usb-uhci
dc00-dc0f : Intel Corp. 82801EB Ultra ATA Storage Controller
  dc00-dc0f : libata
e000-e003 : Intel Corp. 82801EB Ultra ATA Storage Controller
  e000-e003 : libata
e400-e407 : Intel Corp. 82801EB Ultra ATA Storage Controller
  e400-e407 : libata
e800-e803 : Intel Corp. 82801EB Ultra ATA Storage Controller
  e800-e803 : libata
ec00-ec07 : Intel Corp. 82801EB Ultra ATA Storage Controller
  ec00-ec07 : libata
fc00-fc0f : Intel Corp. 82801EB Ultra ATA Storage Controller
  fc00-fc07 : ide0
  fc08-fc0f : ide1
  
  00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb000-000cefff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002436e1 : Kernel code
  002436e2-00343167 : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
20000000-200003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
d7f00000-f7efffff : PCI Bus #01
  e0000000-e7ffffff : PCI device 1002:5d44 (ATI Technologies Inc)
  e8000000-efffffff : PCI device 1002:5964 (ATI Technologies Inc)
    e8000000-e82fffff : vesafb
f8000000-fbffffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffc00000-ffcfffff : PCI Bus #01
  ffce0000-ffceffff : PCI device 1002:5d44 (ATI Technologies Inc)
  ffcf0000-ffcfffff : PCI device 1002:5964 (ATI Technologies Inc)
ffdc0000-ffddffff : Promise Technology, Inc. 20267
ffdfe000-ffdfefff : PCI device 11bd:bede (Pinnacle Systems Inc.)
ffdff700-ffdff7ff : Realtek Semiconductor Co., Ltd. RTL-8169
  ffdff700-ffdff7ff : eth0
ffdff800-ffdfffff : PCI device 11bd:0015 (Pinnacle Systems Inc.)
ffeff900-ffeff9ff : Intel Corp. 82801EB AC'97 Audio Controller
  ffeff900-ffeff9ff : ich_audio MBBAR
ffeffa00-ffeffbff : Intel Corp. 82801EB AC'97 Audio Controller
  ffeffa00-ffeffbff : ich_audio MMBAR
ffeffc00-ffefffff : Intel Corp. 82801EB USB2
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ffc00000-ffcfffff
        Prefetchable memory behind bridge: d7f00000-f7efffff
        BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at cc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ffeffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ffd00000-ffdfffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP
PriO])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 2: I/O ports at e400 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at dc00 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 0c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at c800 [size=256]
        Region 1: I/O ports at c400 [size=64]
        Region 2: Memory at ffeffa00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at ffeff900 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 7c26
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9800 [size=256]
        Region 2: Memory at ffcf0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at ffcc0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
		Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
        Subsystem: PC Partner Limited: Unknown device 7c27
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ffce0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Multimedia controller: Pinnacle Systems Inc.: Unknown device bede
        Subsystem: Pinnacle Systems Inc.: Unknown device 0022
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (2000ns min, 4000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.1 FireWire (IEEE 1394): Pinnacle Systems Inc.: Unknown device 0015 (prog-if 10 [OHCI])
        Subsystem: Pinnacle Systems Inc.: Unknown device 0022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ffdff800 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at ac00 [size=64]
        Region 5: Memory at ffdc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at ffde0000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 728c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at ffdff700 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at ffda0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

kernel source:	34799K 14.jul 06:09 linux-2.6.8.tar.bz2
patch:		16534K 30.aug 03:35 patch-2.6.9-rc3

Thank you

-- 
Ing. Karel Babka		+420 377 430 586
DEKL&syn software		+420 606 268 746
Oøechová 12			email:dekls at volny dot cz
326 00 Plzeò, CZ		http://www.vol.cz/dekls

