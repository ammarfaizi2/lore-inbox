Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSDDO7i>; Thu, 4 Apr 2002 09:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313185AbSDDO7e>; Thu, 4 Apr 2002 09:59:34 -0500
Received: from mail3.codetel.net.do ([196.3.81.53]:22033 "EHLO codetel.net.do")
	by vger.kernel.org with ESMTP id <S313183AbSDDO7Z>;
	Thu, 4 Apr 2002 09:59:25 -0500
Message-ID: <000e01c1dbe9$4d3caed0$78050662@atax>
From: "Atahualpa Ledesma" <aledesma@reconfig.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] PCI Subsystem not recognized by newer ( > 2.4.7-10) kernels
Date: Thu, 4 Apr 2002 10:59:18 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C1DBC7.C58DBD60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello.

I have a PCCHIPS (www.pcchips.com.tw) M841LR motherboard with a SiS chipset,
i also have a Tekram DC-390F SCSI adapter and a SCSI disk. After installing
Redhat 7.2 succesfully, i wanted then to upgrade my kernel to the latest
stable one (2.4.18), so when i tried to boot the new kernel i got a kernel
panic stating that it couldn't mount the root partition, after checking the
kernel messages i saw that the scsi adapter module couldn't be loaded (i use
an initrd to boot, using RH's nash), going up into the kernel messages i
found this:

PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: PCI System does not support PCI

i then tried using a packaged Redhat kernel (kernel-2.4.9-31.athlon.rpm)
with noluck since the PCI subsystem was not recognized either.
After booting countless times, i was told by a friend to try 2.4.19-pre5,
and it gave me the same error about the PCI subsystem.

i'm attaching all the info that i can about my system, the dmesg.txt i'm
attaching is from the 2.4.7-10 (the stock kernel that comes with RH 7.2),
since i can't boot either of the newer kernels.

I can provide any other info you may require.

Atahualpa Ledesma
Linux/Unix System Administrator
Rubiera, Servicios Tecnicos, S. A.
www.rubiera.net

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="ver_linux-output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ver_linux-output.txt"

If some fields are empty or look unusual you may have an old version.=0A=
Compare to the current minimal requirements in Documentation/Changes.=0A=
 =0A=
Linux athlon 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT 2001 i686 unknown=0A=
 =0A=
Gnu C                  2.96=0A=
Gnu make               3.79.1=0A=
binutils               2.11.90.0.8=0A=
util-linux             2.11f=0A=
mount                  2.11g=0A=
modutils               2.4.13=0A=
e2fsprogs              1.23=0A=
reiserfsprogs          3.x.0j=0A=
PPP                    2.4.1=0A=
isdn4k-utils           3.1pre1=0A=
Linux C Library        2.2.4=0A=
Dynamic linker (ldd)   2.2.4=0A=
Procps                 2.0.7=0A=
Net-tools              1.60=0A=
Console-tools          0.3.3=0A=
Sh-utils               2.0.11=0A=
Modules Loaded         autofs 3c59x ext3 jbd sym53c8xx sd_mod scsi_mod=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="cpuinfo.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpuinfo.txt"

processor	: 0=0A=
vendor_id	: AuthenticAMD=0A=
cpu family	: 6=0A=
model		: 4=0A=
model name	: AMD Athlon(tm) Processor=0A=
stepping	: 4=0A=
cpu MHz		: 1095.363=0A=
cache size	: 256 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 1=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow=0A=
bogomips	: 2182.34=0A=
=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="iomem.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="iomem.txt"

00000000-0009fbff : System RAM=0A=
0009fc00-0009ffff : reserved=0A=
000a0000-000bffff : Video RAM area=0A=
000c0000-000c7fff : Video ROM=0A=
000c8000-000c9fff : Extension ROM=0A=
000f0000-000fffff : System ROM=0A=
00100000-0dfeffff : System RAM=0A=
  00100000-0023fcd7 : Kernel code=0A=
  0023fcd8-00256bcf : Kernel data=0A=
0dff0000-0dff7fff : ACPI Tables=0A=
0dff8000-0dffffff : ACPI Non-volatile Storage=0A=
bec00000-cecfffff : PCI Bus #01=0A=
  c0000000-c7ffffff : PCI device 1039:6325 (Silicon Integrated Systems =
[SiS])=0A=
cf000000-cf7fffff : Silicon Integrated Systems [SiS] 86C326=0A=
cfe00000-cfefffff : PCI Bus #01=0A=
  cfee0000-cfefffff : PCI device 1039:6325 (Silicon Integrated Systems =
[SiS])=0A=
cffde000-cffdefff : Symbios Logic Inc. (formerly NCR) 53c875=0A=
cffdfe80-cffdfeff : 3Com Corporation 3c905C-TX [Fast Etherlink]=0A=
cffdff00-cffdffff : Symbios Logic Inc. (formerly NCR) 53c875=0A=
cfff0000-cfffffff : Silicon Integrated Systems [SiS] 86C326=0A=
d0000000-d3ffffff : PCI device 1039:0740 (Silicon Integrated Systems =
[SiS])=0A=
fec00000-fec00fff : reserved=0A=
fee00000-fee00fff : reserved=0A=
ffee0000-ffefffff : reserved=0A=
fffc0000-ffffffff : reserved=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="ioports.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ioports.txt"

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
03c0-03df : vga+=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial(auto)=0A=
9000-9fff : PCI Bus #01=0A=
  9c00-9c7f : PCI device 1039:6325 (Silicon Integrated Systems [SiS])=0A=
cc00-cc7f : 3Com Corporation 3c905C-TX [Fast Etherlink]=0A=
  cc00-cc7f : 00:0b.0=0A=
d000-d07f : PCI device 1039:7012 (Silicon Integrated Systems [SiS])=0A=
d400-d4ff : PCI device 1039:7012 (Silicon Integrated Systems [SiS])=0A=
d800-d8ff : Symbios Logic Inc. (formerly NCR) 53c875=0A=
  d800-d87f : sym53c8xx=0A=
dc00-dc7f : Silicon Integrated Systems [SiS] 86C326=0A=
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]=0A=
  ff00-ff07 : ide0=0A=
  ff08-ff0f : ide1=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="lspci-vvv.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci-vvv.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device =
0740 (rev 01)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 32=0A=
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=3D64M]=0A=
	Capabilities: [c0] AGP version 2.0=0A=
		Status: RQ=3D16 SBA+ 64bit- FW+ Rate=3Dx1,x2=0A=
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>=0A=
=0A=
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 00009000-00009fff=0A=
	Memory behind bridge: cfe00000-cfefffff=0A=
	Prefetchable memory behind bridge: bec00000-cecfffff=0A=
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-=0A=
=0A=
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev =
d0) (prog-if 80 [Master])=0A=
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller =
(A,B step)=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 16=0A=
	Region 4: I/O ports at ff00 [size=3D16]=0A=
=0A=
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]: =
Unknown device 7012 (rev a0)=0A=
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7012=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (13000ns min, 2750ns max)=0A=
	Interrupt: pin C routed to IRQ 11=0A=
	Region 0: I/O ports at d400 [size=3D256]=0A=
	Region 1: I/O ports at d000 [size=3D128]=0A=
	Capabilities: [48] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) =
53c875 (rev 26)=0A=
	Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (4250ns min, 16000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 5=0A=
	Region 0: I/O ports at d800 [size=3D256]=0A=
	Region 1: Memory at cffdff00 (32-bit, non-prefetchable) [size=3D256]=0A=
	Region 2: Memory at cffde000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Expansion ROM at cffc0000 [disabled] [size=3D64K]=0A=
	Capabilities: [40] Power Management version 1=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] =
(rev 78)=0A=
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management =
NIC=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (2500ns min, 2500ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at cc00 [size=3D128]=0A=
	Region 1: Memory at cffdfe80 (32-bit, non-prefetchable) [size=3D128]=0A=
	Expansion ROM at cff80000 [disabled] [size=3D128K]=0A=
	Capabilities: [dc] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-=0A=
=0A=
00:0d.0 VGA compatible controller: Silicon Integrated Systems [SiS] =
86C326 (rev 0b) (prog-if 00 [VGA])=0A=
	Subsystem: Silicon Integrated Systems [SiS] SiS6326 GUI Accelerator=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (500ns min)=0A=
	Region 0: Memory at cf000000 (32-bit, prefetchable) [size=3D8M]=0A=
	Region 1: Memory at cfff0000 (32-bit, non-prefetchable) [size=3D64K]=0A=
	Region 2: I/O ports at dc00 [size=3D128]=0A=
	Expansion ROM at cffe0000 [disabled] [size=3D64K]=0A=
	Capabilities: [40] Power Management version 1=0A=
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: =
Unknown device 6325 (prog-if 00 [VGA])=0A=
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 6325=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	BIST result: 00=0A=
	Region 0: Memory at c0000000 (32-bit, prefetchable) [disabled] =
[size=3D128M]=0A=
	Region 1: Memory at cfee0000 (32-bit, non-prefetchable) [disabled] =
[size=3D128K]=0A=
	Region 2: I/O ports at 9c00 [disabled] [size=3D128]=0A=
	Capabilities: [40] Power Management version 1=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] AGP version 2.0=0A=
		Status: RQ=3D15 SBA+ 64bit- FW- Rate=3Dx1,x2=0A=
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>=0A=
=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="modules.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="modules.txt"

autofs                 11556   0 (autoclean) (unused)=0A=
3c59x                  26408   1=0A=
ext3                   64608   5=0A=
jbd                    41060   5 [ext3]=0A=
sym53c8xx              57572   6=0A=
sd_mod                 11576   6=0A=
scsi_mod               95752   2 [sym53c8xx sd_mod]=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="scsi.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="scsi.txt"

Attached devices: =0A=
Host: scsi0 Channel: 00 Id: 00 Lun: 00=0A=
  Vendor: FUJITSU  Model: MAN3184MP        Rev: 0109=0A=
  Type:   Direct-Access                    ANSI SCSI revision: 03=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60
Content-Type: text/plain;
	name="config-kernel.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config-kernel.txt"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_SBUS is not set=0A=
CONFIG_UID16=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
CONFIG_MK7=3Dy=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D6=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_USE_3DNOW=3Dy=0A=
CONFIG_X86_PGE=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
# CONFIG_MICROCODE is not set=0A=
# CONFIG_X86_MSR is not set=0A=
# CONFIG_X86_CPUID is not set=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_SMP is not set=0A=
CONFIG_X86_UP_APIC=3Dy=0A=
CONFIG_X86_UP_IOAPIC=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
# CONFIG_PCMCIA_SA1100 is not set=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
# CONFIG_HOTPLUG_PCI_COMPAQ is not set=0A=
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set=0A=
# CONFIG_HOTPLUG_PCI_IBM is not set=0A=
# CONFIG_HOTPLUG_PCI_ACPI is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
CONFIG_PM=3Dy=0A=
CONFIG_ACPI=3Dy=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
# CONFIG_ACPI_BUSMGR is not set=0A=
# CONFIG_ACPI_SYS is not set=0A=
# CONFIG_ACPI_CPU is not set=0A=
# CONFIG_ACPI_BUTTON is not set=0A=
# CONFIG_ACPI_AC is not set=0A=
# CONFIG_ACPI_EC is not set=0A=
# CONFIG_ACPI_CMBATT is not set=0A=
# CONFIG_ACPI_THERMAL is not set=0A=
CONFIG_APM=3Dy=0A=
# CONFIG_APM_IGNORE_USER_SUSPEND is not set=0A=
# CONFIG_APM_DO_ENABLE is not set=0A=
# CONFIG_APM_CPU_IDLE is not set=0A=
# CONFIG_APM_DISPLAY_BLANK is not set=0A=
# CONFIG_APM_RTC_IS_GMT is not set=0A=
# CONFIG_APM_ALLOW_INTS is not set=0A=
# CONFIG_APM_REAL_MODE_POWER_OFF is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
CONFIG_PARPORT_PC_CML1=3Dm=0A=
# CONFIG_PARPORT_SERIAL is not set=0A=
CONFIG_PARPORT_PC_FIFO=3Dy=0A=
# CONFIG_PARPORT_PC_SUPERIO is not set=0A=
# CONFIG_PARPORT_AMIGA is not set=0A=
# CONFIG_PARPORT_MFC3 is not set=0A=
# CONFIG_PARPORT_ATARI is not set=0A=
# CONFIG_PARPORT_GSC is not set=0A=
# CONFIG_PARPORT_SUNBPP is not set=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
CONFIG_ISAPNP=3Dy=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_CISS_SCSI_TAPE is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_MD_MULTIPATH is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_IPX is not set=0A=
CONFIG_ATALK=3Dy=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
# CONFIG_PHONE_IXJ is not set=0A=
# CONFIG_PHONE_IXJ_PCMCIA is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_IBM is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_WD is not set=0A=
# CONFIG_BLK_DEV_COMMERIAL is not set=0A=
# CONFIG_BLK_DEV_TIVO is not set=0A=
# CONFIG_BLK_DEV_IDECS is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
CONFIG_BLK_DEV_IDETAPE=3Dy=0A=
CONFIG_BLK_DEV_IDEFLOPPY=3Dy=0A=
CONFIG_BLK_DEV_IDESCSI=3Dm=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
# CONFIG_BLK_DEV_ISAPNP is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set=0A=
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_AEC62XX_TUNING is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_WDC_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_AMD74XX_OVERRIDE is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_CMD680 is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_HPT34X_AUTODMA is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_PIIX_TUNING is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX is not set=0A=
# CONFIG_PDC202XX_BURST is not set=0A=
# CONFIG_PDC202XX_FORCE is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
CONFIG_BLK_DEV_SIS5513=3Dy=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
# CONFIG_DMA_NONPCI is not set=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
# CONFIG_BLK_DEV_ATARAID is not set=0A=
# CONFIG_BLK_DEV_ATARAID_PDC is not set=0A=
# CONFIG_BLK_DEV_ATARAID_HPT is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
CONFIG_SCSI=3Dm=0A=
CONFIG_BLK_DEV_SD=3Dm=0A=
CONFIG_SD_EXTRA_DEVS=3D40=0A=
CONFIG_CHR_DEV_ST=3Dm=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dm=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_SR_EXTRA_DEVS=3D2=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
CONFIG_SCSI_DEBUG_QUEUES=3Dy=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
CONFIG_SCSI_IMM=3Dm=0A=
# CONFIG_SCSI_IZIP_EPP16 is not set=0A=
# CONFIG_SCSI_IZIP_SLOW_CTR is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
CONFIG_SCSI_NCR53C8XX=3Dm=0A=
CONFIG_SCSI_SYM53C8XX=3Dm=0A=
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D4=0A=
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=3D32=0A=
CONFIG_SCSI_NCR53C8XX_SYNC=3D20=0A=
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set=0A=
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set=0A=
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set=0A=
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
# CONFIG_FUSION_BOOT is not set=0A=
# CONFIG_FUSION_ISENSE is not set=0A=
# CONFIG_FUSION_CTL is not set=0A=
# CONFIG_FUSION_LAN is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
# CONFIG_I2O_PCI is not set=0A=
# CONFIG_I2O_BLOCK is not set=0A=
# CONFIG_I2O_LAN is not set=0A=
# CONFIG_I2O_SCSI is not set=0A=
# CONFIG_I2O_PROC is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Appletalk devices=0A=
#=0A=
# CONFIG_APPLETALK is not set=0A=
# CONFIG_LTPC is not set=0A=
# CONFIG_COPS is not set=0A=
# CONFIG_IPDDP is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_SUNLANCE is not set=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNBMAC is not set=0A=
# CONFIG_SUNQE is not set=0A=
# CONFIG_SUNGEM is not set=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
# CONFIG_EL1 is not set=0A=
# CONFIG_EL2 is not set=0A=
# CONFIG_ELPLUS is not set=0A=
# CONFIG_EL16 is not set=0A=
# CONFIG_EL3 is not set=0A=
# CONFIG_3C515 is not set=0A=
# CONFIG_ELMC is not set=0A=
# CONFIG_ELMC_II is not set=0A=
CONFIG_VORTEX=3Dm=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_CS89x0 is not set=0A=
# CONFIG_TULIP is not set=0A=
# CONFIG_TC35815 is not set=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_DM9102=3Dm=0A=
# CONFIG_EEPRO100 is not set=0A=
# CONFIG_LNE390 is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
CONFIG_NE2K_PCI=3Dm=0A=
# CONFIG_NE3210 is not set=0A=
# CONFIG_ES3210 is not set=0A=
CONFIG_8139CP=3Dm=0A=
CONFIG_8139TOO=3Dm=0A=
# CONFIG_8139TOO_PIO is not set=0A=
# CONFIG_8139TOO_TUNE_TWISTER is not set=0A=
# CONFIG_8139TOO_8129 is not set=0A=
# CONFIG_8139_NEW_RX_RESET is not set=0A=
CONFIG_SIS900=3Dm=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_VIA_RHINE_MMIO is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_MYRI_SBUS is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
CONFIG_INPUT=3Dm=0A=
CONFIG_INPUT_KEYBDEV=3Dm=0A=
CONFIG_INPUT_MOUSEDEV=3Dm=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_SERIAL=3Dy=0A=
# CONFIG_SERIAL_CONSOLE is not set=0A=
# CONFIG_SERIAL_ACPI is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
CONFIG_PRINTER=3Dm=0A=
# CONFIG_LP_CONSOLE is not set=0A=
# CONFIG_PPDEV is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
CONFIG_MOUSE=3Dy=0A=
CONFIG_PSMOUSE=3Dy=0A=
# CONFIG_82C710_MOUSE is not set=0A=
# CONFIG_PC110_PAD is not set=0A=
# CONFIG_MK712_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_INPUT_GAMEPORT is not set=0A=
# CONFIG_INPUT_NS558 is not set=0A=
# CONFIG_INPUT_LIGHTNING is not set=0A=
# CONFIG_INPUT_PCIGAME is not set=0A=
# CONFIG_INPUT_CS461X is not set=0A=
# CONFIG_INPUT_EMU10K1 is not set=0A=
# CONFIG_INPUT_SERIO is not set=0A=
# CONFIG_INPUT_SERPORT is not set=0A=
# CONFIG_INPUT_ANALOG is not set=0A=
# CONFIG_INPUT_A3D is not set=0A=
# CONFIG_INPUT_ADI is not set=0A=
# CONFIG_INPUT_COBRA is not set=0A=
# CONFIG_INPUT_GF2K is not set=0A=
# CONFIG_INPUT_GRIP is not set=0A=
# CONFIG_INPUT_INTERACT is not set=0A=
# CONFIG_INPUT_TMDC is not set=0A=
# CONFIG_INPUT_SIDEWINDER is not set=0A=
# CONFIG_INPUT_IFORCE_USB is not set=0A=
# CONFIG_INPUT_IFORCE_232 is not set=0A=
# CONFIG_INPUT_WARRIOR is not set=0A=
# CONFIG_INPUT_MAGELLAN is not set=0A=
# CONFIG_INPUT_SPACEORB is not set=0A=
# CONFIG_INPUT_SPACEBALL is not set=0A=
# CONFIG_INPUT_STINGER is not set=0A=
# CONFIG_INPUT_DB9 is not set=0A=
# CONFIG_INPUT_GAMECON is not set=0A=
# CONFIG_INPUT_TURBOGRAFX is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_AMD_RNG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
CONFIG_AGP_I810=3Dy=0A=
CONFIG_AGP_VIA=3Dy=0A=
CONFIG_AGP_AMD=3Dy=0A=
CONFIG_AGP_SIS=3Dy=0A=
CONFIG_AGP_ALI=3Dy=0A=
# CONFIG_AGP_SWORKS is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_OLD is not set=0A=
CONFIG_DRM_NEW=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_R128 is not set=0A=
# CONFIG_DRM_RADEON is not set=0A=
# CONFIG_DRM_I810 is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_DRM_SIS is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_QUOTA=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
CONFIG_REISERFS_FS=3Dy=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
CONFIG_REISERFS_PROC_INFO=3Dy=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
CONFIG_HFS_FS=3Dm=0A=
# CONFIG_BFS_FS is not set=0A=
CONFIG_EXT3_FS=3Dm=0A=
CONFIG_JBD=3Dm=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
# CONFIG_UMSDOS_FS is not set=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_JFFS2_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVFS_MOUNT is not set=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
# CONFIG_ROOT_NFS is not set=0A=
CONFIG_NFSD=3Dy=0A=
# CONFIG_NFSD_V3 is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_SMB_FS=3Dm=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
CONFIG_NCP_FS=3Dm=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
CONFIG_ZISOFS_FS=3Dy=0A=
CONFIG_ZLIB_FS_INFLATE=3Dy=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_SMB_NLS=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
# CONFIG_USB_DEVICEFS is not set=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_LONG_TIMEOUT is not set=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
CONFIG_USB_UHCI_ALT=3Dy=0A=
CONFIG_USB_OHCI=3Dy=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
CONFIG_USB_BLUETOOTH=3Dm=0A=
CONFIG_USB_STORAGE=3Dm=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_ISD200 is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
CONFIG_USB_STORAGE_HP8200e=3Dy=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
CONFIG_USB_ACM=3Dm=0A=
CONFIG_USB_PRINTER=3Dm=0A=
# CONFIG_USB_HID is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_DC2XX is not set=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_SCANNER is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_CDCETHER is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
# CONFIG_USB_USS720 is not set=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
# CONFIG_USB_SERIAL_GENERIC is not set=0A=
# CONFIG_USB_SERIAL_BELKIN is not set=0A=
# CONFIG_USB_SERIAL_WHITEHEAT is not set=0A=
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set=0A=
# CONFIG_USB_SERIAL_EMPEG is not set=0A=
# CONFIG_USB_SERIAL_FTDI_SIO is not set=0A=
# CONFIG_USB_SERIAL_VISOR is not set=0A=
# CONFIG_USB_SERIAL_IPAQ is not set=0A=
# CONFIG_USB_SERIAL_IR is not set=0A=
# CONFIG_USB_SERIAL_EDGEPORT is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set=0A=
# CONFIG_USB_SERIAL_MCT_U232 is not set=0A=
# CONFIG_USB_SERIAL_KLSI is not set=0A=
# CONFIG_USB_SERIAL_PL2303 is not set=0A=
# CONFIG_USB_SERIAL_CYBERJACK is not set=0A=
# CONFIG_USB_SERIAL_XIRCOM is not set=0A=
# CONFIG_USB_SERIAL_OMNINET is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BLUEZ is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=

------=_NextPart_000_000B_01C1DBC7.C58DBD60--

