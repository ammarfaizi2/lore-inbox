Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUASHBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 02:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUASHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 02:01:04 -0500
Received: from mx1.uunet.co.ke ([195.202.64.34]:40454 "EHLO mx1.uunet.co.ke")
	by vger.kernel.org with ESMTP id S264420AbUASHAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 02:00:41 -0500
Message-ID: <BCC6CF8019C3D61180CA00508BAE6C6501447EDB@kenboexc01.ke.kworld.kpmg.com>
From: ekoome@kpmg.co.ke
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.1 compilation error
Date: Mon, 19 Jan 2004 10:00:26 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2654.89)
Content-Type: multipart/mixed; 
    boundary="----_=_NextPart_000_01C3DE59.EA62B960"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3DE59.EA62B960
Content-Type: text/plain; charset="iso-8859-1"


> I have had problems compiling the 2.6.1 Kernel and i get the following
> error when it reaches /fs/proc/array.c and the compiler halts.
> 
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1329 1665 1659 (parallel[ 
>             (set (reg:SI 0 eax)
>                 (asm_operands ("") ("=a") 0[ 
>                         (reg:DI 1 edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 38))
>             (set (reg:SI 1 edx)
>                 (asm_operands ("") ("=d") 1[ 
>                         (reg:DI 1 edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 38))
>             (clobber (reg:QI 19 dirflag))
>             (clobber (reg:QI 18 fpsr))
>             (clobber (reg:QI 17 flags))
>         ] ) -1 (insn_list 1323 (nil))
>     (nil))
> fs/proc/array.c:398: confused by earlier errors, bailing out
> make[2]: *** [fs/proc/array.o] Error 1
> make[1]: *** [fs/proc] Error 2
> make: *** [fs] Error 2
> 
> Is this a Kernel bug?
> 
> Other information on my system and other loaded modules is included below:
>  <<err>> 
> Regards,
> Eric
> 


****************************************************************************
*****
The information contained in this communication is confidential and may be legally privileged. It is intended solely for the use of the individual or entity to whom it is addressed and others authorised to receive it. If you are not the intended recipient you are hereby notified that any disclosure, copying, distribution or taking action in reliance of the contents of this information is strictly prohibited and may be unlawful. KPMG is neither liable for the proper and complete transmission of the information contained in this communication
 nor any delay in its receipt.

****************************************************************************


------_=_NextPart_000_01C3DE59.EA62B960
Content-Type: application/octet-stream; name="err"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="err"

processor	: 0=0Avendor_id	: GenuineIntel=0Acpu family	: 6=0Amodel		: 8=0Amo=
del name	: Pentium III (Coppermine)=0Astepping	: 10=0Acpu MHz		: 1102.505=
=0Acache size	: 256 KB=0Afdiv_bug	: no=0Ahlt_bug		: no=0Af00f_bug	: no=0Aco=
ma_bug	: no=0Afpu		: yes=0Afpu_exception	: yes=0Acpuid level	: 2=0Awp		: ye=
s=0Aflags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat p=
se36 mmx fxsr sse=0Abogomips	: 2202.00=0A=0Atuner                  11140   =
1 (autoclean)=0Atvaudio                15072   0 (autoclean) (unused)=0Abtt=
v                   99136   0 (autoclean)=0Ai2c-algo-bit            8204   =
1 (autoclean) [bttv]=0Ai2c-core               18528   0 (autoclean) [tuner =
tvaudio bttv i2c-algo-bit]=0Avideodev                7840   3 (autoclean) [=
bttv]=0Acmpci                  33172   1 (autoclean)=0Asoundcore           =
    6276   4 (autoclean) [bttv cmpci]=0Asis                    52640   1=0A=
sisfb                 223100   0 [sis]=0Aagpgart                41472   3=
=0Aautofs                 11204   0 (autoclean) (unused)=0Aipt_TOS         =
        1760  12 (autoclean)=0Aipt_REDIRECT            1536  12 (autoclean)=
=0Aipt_REJECT              4096   4 (autoclean)=0Aipt_LOG                 4=
320   7 (autoclean)=0Aipt_state               1248  58 (autoclean)=0Aip_nat=
_irc              3200   0 (unused)=0Aip_nat_ftp              3840   0 (unu=
sed)=0Aip_conntrack_irc        4192   1=0Aip_conntrack_ftp        4992   1=
=0Aipt_multiport           1344   8 (autoclean)=0Aiptable_filter          2=
464   1 (autoclean)=0Aiptable_mangle          2944   1 (autoclean)=0Aiptabl=
e_nat            21044   3 (autoclean) [ipt_REDIRECT ip_nat_irc ip_nat_ftp]=
=0Aip_conntrack           25620   4 (autoclean) [ipt_REDIRECT ipt_state ip_=
nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp iptable_nat]=0Aip_tabl=
es              14432  11 [ipt_TOS ipt_REDIRECT ipt_REJECT ipt_LOG ipt_stat=
e ipt_multiport iptable_filter iptable_mangle iptable_nat]=0A8139too       =
         16768   1=0Amii                     3864   0 [8139too]=0Acrc32    =
               3712   0 [8139too]=0Aide-cd                 32160   0 (autoc=
lean)=0Acdrom                  32000   0 (autoclean) [ide-cd]=0Ausb-ohci   =
            20224   0 (unused)=0Ausbcore                72032   1 [usb-ohci=
]=0Aext3                   65472   3=0Ajbd                    47052   3 [ex=
t3]=0ALinux version 2.4.22 (root@wavecom.com) (gcc version 2.96 20000731 (R=
ed Hat Linux 7.3 2.96-110)) #2 Fri Dec 26 21:19:37 UTC 2003=0A0000-001f : d=
ma1=0A0020-003f : pic1=0A0040-005f : timer=0A0060-006f : keyboard=0A0070-00=
7f : rtc=0A0080-008f : dma page reg=0A00a0-00bf : pic2=0A00c0-00df : dma2=
=0A00f0-00ff : fpu=0A01f0-01f7 : ide0=0A02f8-02ff : serial(auto)=0A0330-033=
1 : cmpci Midi=0A0388-038b : cmpci FM=0A03c0-03df : vga+=0A03f6-03f6 : ide0=
=0A03f8-03ff : serial(auto)=0A0cf8-0cff : PCI conf1=0A9400-94ff : D-Link Sy=
stem Inc RTL8139 Ethernet=0A  9400-94ff : 8139too=0A9800-98ff : C-Media Ele=
ctronics Inc CM8738=0A  9800-98ff : cmpci=0Aa000-afff : PCI Bus #01=0A  a80=
0-a87f : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D=0Ad800-=
d80f : Silicon Integrated Systems [SiS] 5513 [IDE]=0A  d800-d807 : ide0=0A =
 d808-d80f : ide1=0A00000000-0009fbff : System RAM=0A0009fc00-0009ffff : re=
served=0A000a0000-000bffff : Video RAM area=0A000c0000-000c7fff : Video ROM=
=0A000f0000-000fffff : System ROM=0A00100000-06ffcfff : System RAM=0A  0010=
0000-00240c48 : Kernel code=0A  00240c49-002d033f : Kernel data=0A06ffd000-=
06ffefff : ACPI Tables=0A06fff000-06ffffff : ACPI Non-volatile Storage=0Ae5=
800000-e58000ff : D-Link System Inc RTL8139 Ethernet=0A  e5800000-e58000ff =
: 8139too=0Ae6000000-e67fffff : PCI Bus #01=0A  e6000000-e601ffff : Silicon=
 Integrated Systems [SiS] SiS630 GUI Accelerator+3D=0A    e6000000-e601ffff=
 : sisfb MMIO=0Ae7000000-e7000fff : Silicon Integrated Systems [SiS] USB 1.=
0 Controller (#2)=0A  e7000000-e7000fff : usb-ohci=0Ae7800000-e7800fff : Si=
licon Integrated Systems [SiS] USB 1.0 Controller=0A  e7800000-e7800fff : u=
sb-ohci=0Ae8000000-ebffffff : Silicon Integrated Systems [SiS] 630 Host=0Ae=
f000000-ef000fff : Brooktree Corporation Bt878 Audio Capture=0Aef800000-ef8=
00fff : Brooktree Corporation Bt878 Video Capture=0A  ef800000-ef800fff : b=
ttv=0Af0000000-febfffff : PCI Bus #01=0A  f0000000-f7ffffff : Silicon Integ=
rated Systems [SiS] SiS630 GUI Accelerator+3D=0A    f0000000-f0ffffff : sis=
fb FB=0Affff0000-ffffffff : reserved=0A00:00.0 Host bridge: Silicon Integra=
ted Systems [SiS] 630 Host (rev 21)=0A	Control: I/O+ Mem+ BusMaster+ SpecCy=
cle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap+ 66=
Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort+ >SERR=
- <PERR-=0A	Latency: 32=0A	Region 0: Memory at e8000000 (32-bit, non-prefet=
chable) [size=3D64M]=0A	Capabilities: [c0] AGP version 2.0=0A		Status: RQ=
=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2=0A		Command: RQ=3D0 SBA+ AGP+ 64bit- FW-=
 Rate=3D<none>=0A=0A00:00.1 IDE interface: Silicon Integrated Systems [SiS]=
 5513 [IDE] (rev d0) (prog-if 80 [Master])=0A	Subsystem: Asustek Computer, =
Inc.: Unknown device 8035=0A	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWI=
NV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap- 66Mhz- UDF- =
FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A	=
Latency: 16=0A	Region 4: I/O ports at d800 [size=3D16]=0A=0A00:01.0 ISA bri=
dge: Silicon Integrated Systems [SiS] 85C503/5513=0A	Control: I/O+ Mem+ Bus=
Master+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	S=
tatus: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-=0A	Latency: 0=0A=0A00:01.2 USB Controller: Silicon I=
ntegrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])=0A	Subsystem: Sil=
icon Integrated Systems [SiS] 7001=0A	Control: I/O+ Mem+ BusMaster+ SpecCyc=
le- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap- 66M=
hz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR-=
 <PERR-=0A	Latency: 32 (20000ns max), cache line size 08=0A	Interrupt: pin =
D routed to IRQ 9=0A	Region 0: Memory at e7800000 (32-bit, non-prefetchable=
) [size=3D4K]=0A=0A00:01.3 USB Controller: Silicon Integrated Systems [SiS]=
 7001 (rev 07) (prog-if 10 [OHCI])=0A	Subsystem: Silicon Integrated Systems=
 [SiS]: Unknown device 7000=0A	Control: I/O+ Mem+ BusMaster+ SpecCycle- Mem=
WINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap- 66Mhz- UDF=
- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=
=0A	Latency: 32 (20000ns max), cache line size 08=0A	Interrupt: pin D route=
d to IRQ 9=0A	Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=
=3D4K]=0A=0A00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 =
AGP (prog-if 00 [Normal decode])=0A	Control: I/O+ Mem+ BusMaster+ SpecCycle=
- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap- 66Mhz=
- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PE=
RR-=0A	Latency: 0=0A	Bus: primary=3D00, secondary=3D01, subordinate=3D01, s=
ec-latency=3D0=0A	I/O behind bridge: 0000a000-0000afff=0A	Memory behind bri=
dge: e6000000-e67fffff=0A	Prefetchable memory behind bridge: f0000000-febff=
fff=0A	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=0A0=
0:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)=
=0A	Subsystem: Asustek Computer, Inc.: Unknown device 8035=0A	Control: I/O+=
 Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- Fast=
B2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 32 (500ns min, 6000ns max)=0A	I=
nterrupt: pin A routed to IRQ 5=0A	Region 0: I/O ports at 9800 [size=3D256]=
=0A	Capabilities: [c0] Power Management version 2=0A		Flags: PMEClk- DSI- D=
1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: D0 PME-=
Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:0d.0 Ethernet controller: D-Link S=
ystem Inc RTL8139 Ethernet (rev 10)=0A	Subsystem: D-Link System Inc RTL8139=
 Ethernet=0A	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr- Stepping- SERR- FastB2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-=
 DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 32 (8=
000ns min, 16000ns max)=0A	Interrupt: pin A routed to IRQ 11=0A	Region 0: I=
/O ports at 9400 [size=3D256]=0A	Region 1: Memory at e5800000 (32-bit, non-=
prefetchable) [size=3D256]=0A	Capabilities: [50] Power Management version 2=
=0A		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+,=
D3cold+)=0A		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:0e.0 M=
ultimedia video controller: Brooktree Corporation Bt878 Video Capture (rev =
11)=0A	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSE=
L=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 32 (4000ns =
min, 10000ns max)=0A	Interrupt: pin A routed to IRQ 10=0A	Region 0: Memory =
at ef800000 (32-bit, prefetchable) [size=3D4K]=0A	Capabilities: [44] Vital =
Product Data=0A	Capabilities: [4c] Power Management version 2=0A		Flags: PM=
EClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Sta=
tus: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:0e.1 Multimedia contro=
ller: Brooktree Corporation Bt878 Audio Capture (rev 11)=0A	Control: I/O- M=
em+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2=
B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-=0A	Latency: 32 (1000ns min, 63750ns max)=0A	I=
nterrupt: pin A routed to IRQ 10=0A	Region 0: Memory at ef000000 (32-bit, p=
refetchable) [size=3D4K]=0A	Capabilities: [44] Vital Product Data=0A	Capabi=
lities: [4c] Power Management version 2=0A		Flags: PMEClk- DSI+ D1- D2- Aux=
Current=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: D0 PME-Enable- DS=
el=3D0 DScale=3D0 PME-=0A=0A01:00.0 VGA compatible controller: Silicon Inte=
grated Systems [SiS] SiS630 GUI Accelerator+3D (rev 21) (prog-if 00 [VGA])=
=0A	Subsystem: Asustek Computer, Inc.: Unknown device 8035=0A	Control: I/O+=
 Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast=
B2B-=0A	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A	Interrupt: pin A routed to IRQ 11=0A	BIS=
T result: 00=0A	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=
=3D128M]=0A	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=
=3D128K]=0A	Region 2: I/O ports at a800 [size=3D128]=0A	Capabilities: [40] =
Power Management version 1=0A		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=
 PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: D0 PME-Enable- DSel=3D0 DScale=
=3D0 PME-=0A	Capabilities: [50] AGP version 2.0=0A		Status: RQ=3D15 SBA+ 64=
bit- FW- Rate=3Dx1,x2=0A		Command: RQ=3D15 SBA+ AGP+ 64bit- FW- Rate=3D<non=
e>=0A=0A
------_=_NextPart_000_01C3DE59.EA62B960--
