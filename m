Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTH0WY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbTH0WY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:24:57 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55772 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262358AbTH0WYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:24:24 -0400
From: Eric Phillips <ericp732@comcast.net>
Reply-To: ericp732@comcast.net
To: linux-kernel@vger.kernel.org
Subject: Error trying to compile linux-2.6.0-test4
Date: Wed, 27 Aug 2003 18:07:37 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_puST/2pcJE95bQA"
Message-Id: <200308271807.37240.ericp732@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_puST/2pcJE95bQA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I doubt this is a bug, and I don't know where to send this to but thought maybe this
could be helpfull.

Thanks
Eric

--Boundary-00=_puST/2pcJE95bQA
Content-Type: text/plain;
  charset="us-ascii";
  name="2-6error"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2-6error"

kernel 2.6 compile failure

Trying to install the 2.6 series fails on my machine.

When trying to install the linux-2.6.0-test4 kernel I get errors and the kernel
is not compiled.  See bottom of text of the error I am getting.  Listed below is
my setup.

Linux version 2.4.21 (root@broken) (gcc version 3.2.2) #1 SMP
Wed Aug 20 20:42:09 EDT 2003

Environment is KDE 3.1.2 using the xconfigure option

CPU info
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1800+
stepping        : 2
cpu MHz         : 1533.403
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 $bogomips        : 3060.53

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1533.403
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 m$bogomips        : 3060.53

Modules
nvidia               1629184  11 (autoclean)

IOports
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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1010-1013 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
2000-2fff : PCI Bus #02
  2000-207f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  2080-209f : Creative Labs SB Live! EMU10k1
    2080-209f : EMU10K1
  20a0-20a7 : Creative Labs SB Live! MIDI/Game Port
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  f000-f007 : ide0
  f008-f00f : ide1

  IOmem
00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf000-000cf7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-002cd67d : Kernel code
  002cd67e-0037591f : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
d0000000-d0ffffff : PCI Bus #01
  d0000000-d0ffffff : nVidia Corporation NV25 [GeForce4 Ti4200]
d1000000-d10fffff : PCI Bus #02
  d1000000-d1000fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
    d1000000-d1000fff : usb-ohci
  d1001000-d100107f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
d1300000-d1300fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controllerd1400000-dfffffff : PCI Bus #01
  d1400000-d147ffff : nVidia Corporation NV25 [GeForce4 Ti4200]
  d8000000-dfffffff : nVidia Corporation NV25 [GeForce4 Ti4200]
e0000000-efffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controllerf0000000-f20fffff : PCI Bus #02
  f0000000-f1ffffff : Distributed Processing Technology SmartRAID V Controller
  f2000000-f2000fff : Harris Semiconductor Prism 2.5 Wavelan chipset
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

PCI info
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
Controller (rev 11)        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz+ UDF- 
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-        
Latency: 32        Region 0: Memory at e0000000 (32-bit, prefetchable) 
[size=256M]        Region 1: Memory at d1300000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1010 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4                Command: RQ=1 ArqSz=0 Cal=0 SBA- 
AGP+ GART64- 64bit- FW- Rate=x4
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(prog-if 00 [Normal decode])        Control: I/O+ Mem+ BusMaster+ SpecCycle- 
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz+ 
UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-     
   Latency: 99        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d0000000-d0ffffff
        Prefetchable memory behind bridge: d1400000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) 
(prog-if 8a [Master SecP PriP])        Subsystem: Advanced Micro Devices [AMD] 
AMD-768 [Opus] IDE        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- 
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        
Latency: 0        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) 
(prog-if 00 [Normal decode])        Control: I/O+ Mem+ BusMaster+ SpecCycle- 
MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz+ 
UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-     
   Latency: 64        Bus: primary=00, secondary=02, subordinate=03, 
sec-latency=168        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d1000000-d10fffff
        Prefetchable memory behind bridge: f0000000-f20fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] 
(rev a3) (prog-if 00 [VGA])        Subsystem: Unknown device 17f2:8007
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 248 
(1250ns min, 250ns max)        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d1400000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4                Command: RQ=16 ArqSz=0 Cal=0 SBA- 
AGP+ GART64- 64bit- FW- Rate=x4
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) 
(prog-if 10 [OHCI])        Subsystem: Advanced Micro Devices [AMD] AMD-768 
[Opus] USB        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B+ 
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+        Latency: 
64 (20000ns max)        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=4K]

02:04.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 02) 
(prog-if 00 [Normal decode])        Control: I/O- Mem+ BusMaster+ SpecCycle- 
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- 
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-     
   Latency: 64, cache line size 10        Bus: primary=02, secondary=03, 
subordinate=03, sec-latency=64        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 00100000-000fffff
        Prefetchable memory behind bridge: 00100000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-
02:04.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev 02) 
(prog-if 01)        Subsystem: Distributed Processing Technology 2000S Ultra3 
Single Channel        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ 
VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- 
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        
Latency: 64 (250ns min, 250ns max), cache line size 10        Interrupt: pin A 
routed to IRQ 16        BIST result: 00
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=32K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-
02:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 64 (500ns 
min, 5000ns max)        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 2080 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-
02:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 64
        Region 0: I/O ports at 20a0 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-
02:07.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 
01)        Subsystem: Linksys WMP11 Wireless 802.11b PCI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 64, cache 
line size 10        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f2000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)                Status: D0 PME-Enable- DSel=0 
DScale=0 PME-
02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: Tyan Computer: Unknown device 2466
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 80 
(2500ns min, 2500ns max), cache line size 10        Interrupt: pin A routed to 
IRQ 19        Region 0: I/O ports at 2000 [size=128]
        Region 1: Memory at d1001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)                Status: D0 PME-Enable+ DSel=0 
DScale=2 PME-

SCSI info
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: IC35L018UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Adaptec I2O RAID Driver Version: 2.4 Build 5

Vendor: Adaptec  Model: 2100S            FW:370F
SCSI Host=scsi0  Control Node=/dev/dpti0  irq=16
        post fifo size  = 255
        reply fifo size = 255
        sg table size   = 56

Devices:
        IBM     IC35L018UWD210-0 Rev: S5BS
        TID=518, (Channel=0, Target=3, Lun=0)  (online)

Ouput of compile





eric@broken:~$ su root
Password:
root@broken:/home/eric# cd /usr/src/linux
root@broken:/usr/src/linux# ls
COPYING        MAINTAINERS  REPORTING-BUGS  drivers  init    lib  scripts   usr
CREDITS        Makefile     arch            fs       ipc     mm   security
Documentation  README       crypto          include  kernel  net  sound
root@broken:/usr/src/linux# make mrproper
  RM  $(CLEAN_FILES)
  Making mrproper in the srctree
  RM  $(MRPROPER_DIRS) + $(MRPROPER_FILES)
root@broken:/usr/src/linux# make clean
  RM  $(CLEAN_FILES)
root@broken:/usr/src/linux# make xconfig
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 
's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
/usr/lib/qt-3.1.2/bin/moc -i scripts/kconfig/qconf.h -o 
scripts/kconfig/qconf.moc  HOSTCXX scripts/kconfig/qconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/qconf
./scripts/kconfig/qconf arch/i386/Kconfig
boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
#
# using defaults found in arch/i386/defconfig
#
root@broken:/usr/src/linux# make bzImage
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  Making asm->asm-i386 symlink
  CC      scripts/empty.o
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/i386/kernel/asm-offsets.s
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/i386/kernel/process.o
  CC      arch/i386/kernel/semaphore.o
  CC      arch/i386/kernel/signal.o
  AS      arch/i386/kernel/entry.o
  CC      arch/i386/kernel/traps.o
  CC      arch/i386/kernel/irq.o
  CC      arch/i386/kernel/vm86.o
  CC      arch/i386/kernel/ptrace.o
  CC      arch/i386/kernel/i8259.o
  CC      arch/i386/kernel/ioport.o
  CC      arch/i386/kernel/ldt.o
  CC      arch/i386/kernel/setup.o
  CC      arch/i386/kernel/time.o
  CC      arch/i386/kernel/sys_i386.o
  CC      arch/i386/kernel/pci-dma.o
  CC      arch/i386/kernel/i386_ksyms.o
  CC      arch/i386/kernel/i387.o
  CC      arch/i386/kernel/dmi_scan.o
  CC      arch/i386/kernel/bootflag.o
  CC      arch/i386/kernel/doublefault.o
  CC      arch/i386/kernel/acpi/boot.o
  LD      arch/i386/kernel/acpi/built-in.o
  CC      arch/i386/kernel/cpu/common.o
  CC      arch/i386/kernel/cpu/proc.o
  CC      arch/i386/kernel/cpu/amd.o
  CC      arch/i386/kernel/cpu/cyrix.o
  CC      arch/i386/kernel/cpu/centaur.o
  CC      arch/i386/kernel/cpu/transmeta.o
  CC      arch/i386/kernel/cpu/intel.o
  CC      arch/i386/kernel/cpu/rise.o
  CC      arch/i386/kernel/cpu/nexgen.o
  CC      arch/i386/kernel/cpu/umc.o
  CC      arch/i386/kernel/cpu/mcheck/mce.o
  CC      arch/i386/kernel/cpu/mcheck/k7.o
  CC      arch/i386/kernel/cpu/mcheck/p4.o
  CC      arch/i386/kernel/cpu/mcheck/p5.o
  CC      arch/i386/kernel/cpu/mcheck/p6.o
  CC      arch/i386/kernel/cpu/mcheck/winchip.o
  CC      arch/i386/kernel/cpu/mcheck/non-fatal.o
  LD      arch/i386/kernel/cpu/mcheck/built-in.o
  CC      arch/i386/kernel/cpu/mtrr/main.o
  CC      arch/i386/kernel/cpu/mtrr/if.o
  CC      arch/i386/kernel/cpu/mtrr/generic.o
  CC      arch/i386/kernel/cpu/mtrr/state.o
  CC      arch/i386/kernel/cpu/mtrr/amd.o
  CC      arch/i386/kernel/cpu/mtrr/cyrix.o
  CC      arch/i386/kernel/cpu/mtrr/centaur.o
  LD      arch/i386/kernel/cpu/mtrr/built-in.o
  LD      arch/i386/kernel/cpu/built-in.o
  CC      arch/i386/kernel/timers/timer.o
  CC      arch/i386/kernel/timers/timer_none.o
  CC      arch/i386/kernel/timers/timer_tsc.o
  CC      arch/i386/kernel/timers/timer_pit.o
  LD      arch/i386/kernel/timers/built-in.o
  CC      arch/i386/kernel/reboot.o
  CC      arch/i386/kernel/suspend.o
  CC      arch/i386/kernel/smp.o
  CC      arch/i386/kernel/smpboot.o
  AS      arch/i386/kernel/trampoline.o
  CC      arch/i386/kernel/mpparse.o
  CC      arch/i386/kernel/apic.o
  CC      arch/i386/kernel/nmi.o
  CC      arch/i386/kernel/io_apic.o
  CC      arch/i386/kernel/module.o
  CC      arch/i386/kernel/sysenter.o
  AS      arch/i386/kernel/vsyscall-int80.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
  AS      arch/i386/kernel/vsyscall-sysenter.o
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
  AS      arch/i386/kernel/vsyscall.o
  SYSCALL arch/i386/kernel/vsyscall-syms.o
  LD      arch/i386/kernel/built-in.o
  AS      arch/i386/kernel/head.o
  CC      arch/i386/kernel/init_task.o
  CPP     arch/i386/kernel/vmlinux.lds.s
  CC      arch/i386/mm/init.o
  CC      arch/i386/mm/pgtable.o
  CC      arch/i386/mm/fault.o
  CC      arch/i386/mm/ioremap.o
  CC      arch/i386/mm/extable.o
  CC      arch/i386/mm/pageattr.o
  LD      arch/i386/mm/built-in.o
  CC      arch/i386/mach-default/setup.o
  CC      arch/i386/mach-default/topology.o
  LD      arch/i386/mach-default/built-in.o
  CC      kernel/sched.o
  CC      kernel/fork.o
  CC      kernel/exec_domain.o
  CC      kernel/panic.o
  CC      kernel/printk.o
  CC      kernel/profile.o
  CC      kernel/exit.o
  CC      kernel/itimer.o
  CC      kernel/time.o
  CC      kernel/softirq.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
  CC      kernel/capability.o
  CC      kernel/ptrace.o
  CC      kernel/timer.o
  CC      kernel/user.o
  CC      kernel/signal.o
  CC      kernel/sys.o
  CC      kernel/kmod.o
  CC      kernel/workqueue.o
  CC      kernel/pid.o
  CC      kernel/rcupdate.o
  CC      kernel/intermodule.o
  CC      kernel/extable.o
  CC      kernel/params.o
  CC      kernel/posix-timers.o
  CC      kernel/futex.o
  CC      kernel/dma.o
  CC      kernel/cpu.o
  CC      kernel/uid16.o
  CC      kernel/ksyms.o
  CC      kernel/module.o
  CC      kernel/kallsyms.o
  CC      kernel/power/main.o
  CC      kernel/power/process.o
  CC      kernel/power/console.o
  CC      kernel/power/pm.o
  LD      kernel/power/built-in.o
  LD      kernel/built-in.o
  CC      mm/bootmem.o
  CC      mm/filemap.o
  CC      mm/mempool.o
  CC      mm/oom_kill.o
  CC      mm/fadvise.o
  CC      mm/page_alloc.o
  CC      mm/page-writeback.o
  CC      mm/pdflush.o
  CC      mm/readahead.o
  CC      mm/slab.o
  CC      mm/swap.o
  CC      mm/truncate.o
  CC      mm/vcache.o
  CC      mm/vmscan.o
  CC      mm/fremap.o
  CC      mm/highmem.o
  CC      mm/madvise.o
  CC      mm/memory.o
  CC      mm/mincore.o
  CC      mm/mlock.o
  CC      mm/mmap.o
  CC      mm/mprotect.o
  CC      mm/mremap.o
  CC      mm/msync.o
  CC      mm/rmap.o
  CC      mm/shmem.o
  CC      mm/vmalloc.o
  CC      mm/page_io.o
  CC      mm/swap_state.o
  CC      mm/swapfile.o
  LD      mm/built-in.o
  CC      fs/open.o
  CC      fs/read_write.o
  CC      fs/file_table.o
  CC      fs/buffer.o
  CC      fs/bio.o
  CC      fs/super.o
  CC      fs/block_dev.o
  CC      fs/char_dev.o
  CC      fs/stat.o
  CC      fs/exec.o
  CC      fs/pipe.o
  CC      fs/namei.o
  CC      fs/fcntl.o
  CC      fs/ioctl.o
  CC      fs/readdir.o
  CC      fs/select.o
  CC      fs/fifo.o
  CC      fs/locks.o
  CC      fs/dcache.o
  CC      fs/inode.o
  CC      fs/attr.o
  CC      fs/bad_inode.o
  CC      fs/file.o
  CC      fs/dnotify.o
  CC      fs/filesystems.o
  CC      fs/namespace.o
  CC      fs/seq_file.o
  CC      fs/xattr.o
  CC      fs/libfs.o
  CC      fs/fs-writeback.o
  CC      fs/mpage.o
  CC      fs/direct-io.o
  CC      fs/aio.o
  CC      fs/eventpoll.o
  CC      fs/nfsctl.o
  CC      fs/binfmt_aout.o
  CC      fs/binfmt_misc.o
  CC      fs/binfmt_script.o
  CC      fs/binfmt_elf.o
  CC      fs/mbcache.o
  CC      fs/autofs4/init.o
  CC      fs/autofs4/inode.o
  CC      fs/autofs4/root.o
  CC      fs/autofs4/symlink.o
  CC      fs/autofs4/waitq.o
  CC      fs/autofs4/expire.o
  LD      fs/autofs4/autofs4.o
  LD      fs/autofs4/built-in.o
  CC      fs/cifs/cifsfs.o
  CC      fs/cifs/cifssmb.o
  CC      fs/cifs/cifs_debug.o
  CC      fs/cifs/connect.o
  CC      fs/cifs/dir.o
  CC      fs/cifs/file.o
  CC      fs/cifs/inode.o
  CC      fs/cifs/link.o
  CC      fs/cifs/misc.o
  CC      fs/cifs/netmisc.o
  CC      fs/cifs/smbdes.o
  CC      fs/cifs/smbencrypt.o
  CC      fs/cifs/transport.o
  CC      fs/cifs/asn1.o
  CC      fs/cifs/md4.o
  CC      fs/cifs/md5.o
  CC      fs/cifs/cifs_unicode.o
  CC      fs/cifs/nterr.o
  CC      fs/cifs/xattr.o
  CC      fs/cifs/cifsencrypt.o
  LD      fs/cifs/cifs.o
  LD      fs/cifs/built-in.o
  CC      fs/devpts/inode.o
  LD      fs/devpts/devpts.o
  LD      fs/devpts/built-in.o
  CC      fs/exportfs/expfs.o
  LD      fs/exportfs/exportfs.o
  LD      fs/exportfs/built-in.o
  CC      fs/ext3/balloc.o
  CC      fs/ext3/bitmap.o
  CC      fs/ext3/dir.o
  CC      fs/ext3/file.o
  CC      fs/ext3/fsync.o
  CC      fs/ext3/ialloc.o
  CC      fs/ext3/inode.o
  CC      fs/ext3/ioctl.o
  CC      fs/ext3/namei.o
  CC      fs/ext3/super.o
  CC      fs/ext3/symlink.o
  CC      fs/ext3/hash.o
  CC      fs/ext3/xattr.o
  CC      fs/ext3/xattr_user.o
  CC      fs/ext3/xattr_trusted.o
  LD      fs/ext3/ext3.o
  LD      fs/ext3/built-in.o
  CC      fs/fat/cache.o
  CC      fs/fat/dir.o
  CC      fs/fat/file.o
  CC      fs/fat/inode.o
  CC      fs/fat/misc.o
  CC      fs/fat/fatfs_syms.o
  LD      fs/fat/fat.o
  LD      fs/fat/built-in.o
  CC      fs/isofs/namei.o
  CC      fs/isofs/inode.o
  CC      fs/isofs/dir.o
  CC      fs/isofs/util.o
  CC      fs/isofs/rock.o
  CC      fs/isofs/joliet.o
  LD      fs/isofs/isofs.o
  LD      fs/isofs/built-in.o
  CC      fs/jbd/transaction.o
  CC      fs/jbd/commit.o
  CC      fs/jbd/recovery.o
  CC      fs/jbd/checkpoint.o
  CC      fs/jbd/revoke.o
  CC      fs/jbd/journal.o
  LD      fs/jbd/jbd.o
  LD      fs/jbd/built-in.o
  CC      fs/lockd/clntlock.o
  CC      fs/lockd/clntproc.o
  CC      fs/lockd/host.o
  CC      fs/lockd/svc.o
  CC      fs/lockd/svclock.o
  CC      fs/lockd/svcshare.o
  CC      fs/lockd/svcproc.o
  CC      fs/lockd/svcsubs.o
  CC      fs/lockd/mon.o
  CC      fs/lockd/xdr.o
  CC      fs/lockd/lockd_syms.o
  LD      fs/lockd/lockd.o
  LD      fs/lockd/built-in.o
  CC      fs/msdos/namei.o
  CC      fs/msdos/msdosfs_syms.o
  LD      fs/msdos/msdos.o
  LD      fs/msdos/built-in.o
  CC      fs/nfs/dir.o
  CC      fs/nfs/file.o
  CC      fs/nfs/inode.o
  CC      fs/nfs/nfs2xdr.o
  CC      fs/nfs/pagelist.o
  CC      fs/nfs/proc.o
  CC      fs/nfs/read.o
  CC      fs/nfs/symlink.o
  CC      fs/nfs/unlink.o
  CC      fs/nfs/write.o
  LD      fs/nfs/nfs.o
  LD      fs/nfs/built-in.o
  CC      fs/nfsd/nfssvc.o
  CC      fs/nfsd/nfsctl.o
  CC      fs/nfsd/nfsproc.o
  CC      fs/nfsd/nfsfh.o
  CC      fs/nfsd/vfs.o
  CC      fs/nfsd/export.o
  CC      fs/nfsd/auth.o
  CC      fs/nfsd/lockd.o
  CC      fs/nfsd/nfscache.o
  CC      fs/nfsd/nfsxdr.o
  CC      fs/nfsd/stats.o
  LD      fs/nfsd/nfsd.o
  LD      fs/nfsd/built-in.o
  CC      fs/nls/nls_base.o
  CC      fs/nls/nls_cp437.o
  CC      fs/nls/nls_iso8859-1.o
  LD      fs/nls/built-in.o
  CC      fs/ntfs/aops.o
  CC      fs/ntfs/attrib.o
  CC      fs/ntfs/compress.o
  CC      fs/ntfs/debug.o
  CC      fs/ntfs/dir.o
  CC      fs/ntfs/file.o
  CC      fs/ntfs/inode.o
  CC      fs/ntfs/mft.o
  CC      fs/ntfs/mst.o
  CC      fs/ntfs/namei.o
  CC      fs/ntfs/super.o
  CC      fs/ntfs/sysctl.o
  CC      fs/ntfs/time.o
  CC      fs/ntfs/unistr.o
  CC      fs/ntfs/upcase.o
  LD      fs/ntfs/ntfs.o
  LD      fs/ntfs/built-in.o
  CC      fs/partitions/check.o
  CC      fs/partitions/msdos.o
  LD      fs/partitions/built-in.o
  CC      fs/proc/task_mmu.o
  CC      fs/proc/inode.o
  CC      fs/proc/root.o
  CC      fs/proc/base.o
  CC      fs/proc/generic.o
  CC      fs/proc/array.o
  CC      fs/proc/kmsg.o
  CC      fs/proc/proc_tty.o
  CC      fs/proc/proc_misc.o
  CC      fs/proc/kcore.o
  LD      fs/proc/proc.o
  LD      fs/proc/built-in.o
  CC      fs/ramfs/inode.o
  LD      fs/ramfs/ramfs.o
  LD      fs/ramfs/built-in.o
  CC      fs/smbfs/proc.o
  CC      fs/smbfs/dir.o
  CC      fs/smbfs/cache.o
  CC      fs/smbfs/sock.o
  CC      fs/smbfs/inode.o
  CC      fs/smbfs/file.o
  CC      fs/smbfs/ioctl.o
  CC      fs/smbfs/getopt.o
  CC      fs/smbfs/symlink.o
  CC      fs/smbfs/smbiod.o
  CC      fs/smbfs/request.o
  LD      fs/smbfs/smbfs.o
  LD      fs/smbfs/built-in.o
  CC      fs/sysfs/inode.o
  CC      fs/sysfs/file.o
  CC      fs/sysfs/dir.o
  CC      fs/sysfs/symlink.o
  CC      fs/sysfs/mount.o
  CC      fs/sysfs/bin.o
  CC      fs/sysfs/group.o
  LD      fs/sysfs/built-in.o
  CC      fs/udf/balloc.o
  CC      fs/udf/dir.o
  CC      fs/udf/file.o
  CC      fs/udf/ialloc.o
  CC      fs/udf/inode.o
  CC      fs/udf/lowlevel.o
  CC      fs/udf/namei.o
  CC      fs/udf/partition.o
  CC      fs/udf/super.o
  CC      fs/udf/truncate.o
  CC      fs/udf/symlink.o
  CC      fs/udf/fsync.o
  CC      fs/udf/crc.o
  CC      fs/udf/directory.o
  CC      fs/udf/misc.o
  CC      fs/udf/udftime.o
  CC      fs/udf/unicode.o
  LD      fs/udf/udf.o
  LD      fs/udf/built-in.o
  CC      fs/vfat/namei.o
  CC      fs/vfat/vfatfs_syms.o
  LD      fs/vfat/vfat.o
  LD      fs/vfat/built-in.o
  LD      fs/built-in.o
  CC      ipc/util.o
  CC      ipc/msg.o
  CC      ipc/sem.o
  CC      ipc/shm.o
  LD      ipc/built-in.o
  CC      security/capability.o
  LD      security/built-in.o
  LD      crypto/built-in.o
  CC      drivers/acpi/acpi_ksyms.o
  CC      drivers/acpi/tables.o
  CC      drivers/acpi/blacklist.o
  CC      drivers/acpi/osl.o
  CC      drivers/acpi/utils.o
  CC      drivers/acpi/dispatcher/dsfield.o
  CC      drivers/acpi/dispatcher/dsmthdat.o
  CC      drivers/acpi/dispatcher/dsopcode.o
  CC      drivers/acpi/dispatcher/dswexec.o
  CC      drivers/acpi/dispatcher/dswscope.o
  CC      drivers/acpi/dispatcher/dsmethod.o
  CC      drivers/acpi/dispatcher/dsobject.o
  CC      drivers/acpi/dispatcher/dsutils.o
  CC      drivers/acpi/dispatcher/dswload.o
  CC      drivers/acpi/dispatcher/dswstate.o
  CC      drivers/acpi/dispatcher/dsinit.o
  LD      drivers/acpi/dispatcher/built-in.o
  CC      drivers/acpi/events/evevent.o
  CC      drivers/acpi/events/evregion.o
  CC      drivers/acpi/events/evsci.o
  CC      drivers/acpi/events/evxfevnt.o
  CC      drivers/acpi/events/evmisc.o
  CC      drivers/acpi/events/evrgnini.o
  CC      drivers/acpi/events/evxface.o
  CC      drivers/acpi/events/evxfregn.o
  CC      drivers/acpi/events/evgpe.o
  CC      drivers/acpi/events/evgpeblk.o
  LD      drivers/acpi/events/built-in.o
  CC      drivers/acpi/executer/exconfig.o
  CC      drivers/acpi/executer/exfield.o
  CC      drivers/acpi/executer/exnames.o
  CC      drivers/acpi/executer/exoparg6.o
  CC      drivers/acpi/executer/exresolv.o
  CC      drivers/acpi/executer/exstorob.o
  CC      drivers/acpi/executer/exconvrt.o
  CC      drivers/acpi/executer/exfldio.o
  CC      drivers/acpi/executer/exoparg1.o
  CC      drivers/acpi/executer/exprep.o
  CC      drivers/acpi/executer/exresop.o
  CC      drivers/acpi/executer/exsystem.o
  CC      drivers/acpi/executer/excreate.o
  CC      drivers/acpi/executer/exmisc.o
  CC      drivers/acpi/executer/exoparg2.o
  CC      drivers/acpi/executer/exregion.o
  CC      drivers/acpi/executer/exstore.o
  CC      drivers/acpi/executer/exutils.o
  CC      drivers/acpi/executer/exdump.o
  CC      drivers/acpi/executer/exmutex.o
  CC      drivers/acpi/executer/exoparg3.o
  CC      drivers/acpi/executer/exresnte.o
  CC      drivers/acpi/executer/exstoren.o
  LD      drivers/acpi/executer/built-in.o
  CC      drivers/acpi/hardware/hwacpi.o
  CC      drivers/acpi/hardware/hwgpe.o
  CC      drivers/acpi/hardware/hwregs.o
  CC      drivers/acpi/hardware/hwsleep.o
  CC      drivers/acpi/hardware/hwtimer.o
  LD      drivers/acpi/hardware/built-in.o
  CC      drivers/acpi/namespace/nsaccess.o
  CC      drivers/acpi/namespace/nsdumpdv.o
  CC      drivers/acpi/namespace/nsload.o
  CC      drivers/acpi/namespace/nssearch.o
  CC      drivers/acpi/namespace/nsxfeval.o
  CC      drivers/acpi/namespace/nsalloc.o
  CC      drivers/acpi/namespace/nseval.o
  CC      drivers/acpi/namespace/nsnames.o
  CC      drivers/acpi/namespace/nsutils.o
  CC      drivers/acpi/namespace/nsxfname.o
  CC      drivers/acpi/namespace/nsdump.o
  CC      drivers/acpi/namespace/nsinit.o
  CC      drivers/acpi/namespace/nsobject.o
  CC      drivers/acpi/namespace/nswalk.o
  CC      drivers/acpi/namespace/nsxfobj.o
  CC      drivers/acpi/namespace/nsparse.o
  LD      drivers/acpi/namespace/built-in.o
  CC      drivers/acpi/parser/psargs.o
  CC      drivers/acpi/parser/psparse.o
  CC      drivers/acpi/parser/pstree.o
  CC      drivers/acpi/parser/pswalk.o
  CC      drivers/acpi/parser/psopcode.o
  CC      drivers/acpi/parser/psscope.o
  CC      drivers/acpi/parser/psutils.o
  CC      drivers/acpi/parser/psxface.o
  LD      drivers/acpi/parser/built-in.o
  CC      drivers/acpi/resources/rsaddr.o
  CC      drivers/acpi/resources/rscreate.o
  CC      drivers/acpi/resources/rsio.o
  CC      drivers/acpi/resources/rslist.o
  CC      drivers/acpi/resources/rsmisc.o
  CC      drivers/acpi/resources/rsxface.o
  CC      drivers/acpi/resources/rscalc.o
  CC      drivers/acpi/resources/rsdump.o
  CC      drivers/acpi/resources/rsirq.o
  CC      drivers/acpi/resources/rsmemory.o
  CC      drivers/acpi/resources/rsutils.o
  LD      drivers/acpi/resources/built-in.o
  CC      drivers/acpi/sleep/poweroff.o
  LD      drivers/acpi/sleep/built-in.o
  CC      drivers/acpi/tables/tbconvrt.o
  CC      drivers/acpi/tables/tbget.o
  CC      drivers/acpi/tables/tbrsdt.o
  CC      drivers/acpi/tables/tbxface.o
  CC      drivers/acpi/tables/tbgetall.o
  CC      drivers/acpi/tables/tbinstal.o
  CC      drivers/acpi/tables/tbutils.o
  CC      drivers/acpi/tables/tbxfroot.o
  LD      drivers/acpi/tables/built-in.o
  CC      drivers/acpi/utilities/utalloc.o
  CC      drivers/acpi/utilities/utdebug.o
  CC      drivers/acpi/utilities/uteval.o
  CC      drivers/acpi/utilities/utinit.o
  CC      drivers/acpi/utilities/utmisc.o
  CC      drivers/acpi/utilities/utxface.o
  CC      drivers/acpi/utilities/utcopy.o
  CC      drivers/acpi/utilities/utdelete.o
  CC      drivers/acpi/utilities/utglobal.o
  CC      drivers/acpi/utilities/utmath.o
  CC      drivers/acpi/utilities/utobject.o
  LD      drivers/acpi/utilities/built-in.o
  CC      drivers/acpi/bus.o
  CC      drivers/acpi/button.o
  CC      drivers/acpi/ec.o
  CC      drivers/acpi/fan.o
  CC      drivers/acpi/pci_root.o
  CC      drivers/acpi/pci_link.o
  CC      drivers/acpi/pci_irq.o
  CC      drivers/acpi/pci_bind.o
  CC      drivers/acpi/power.o
  CC      drivers/acpi/processor.o
  CC      drivers/acpi/thermal.o
  CC      drivers/acpi/system.o
  CC      drivers/acpi/event.o
  CC      drivers/acpi/scan.o
  LD      drivers/acpi/built-in.o
  CC      drivers/base/core.o
  CC      drivers/base/sys.o
  CC      drivers/base/interface.o
  CC      drivers/base/bus.o
  CC      drivers/base/driver.o
  CC      drivers/base/class.o
  CC      drivers/base/platform.o
  CC      drivers/base/cpu.o
  CC      drivers/base/firmware.o
  CC      drivers/base/init.o
  CC      drivers/base/map.o
  CC      drivers/base/power/shutdown.o
  CC      drivers/base/power/main.o
  CC      drivers/base/power/suspend.o
  CC      drivers/base/power/resume.o
  CC      drivers/base/power/runtime.o
  CC      drivers/base/power/sysfs.o
  LD      drivers/base/power/built-in.o
  LD      drivers/base/built-in.o
  CC      drivers/block/elevator.o
  CC      drivers/block/ll_rw_blk.o
  CC      drivers/block/ioctl.o
  CC      drivers/block/genhd.o
  CC      drivers/block/scsi_ioctl.o
  CC      drivers/block/noop-iosched.o
  CC      drivers/block/as-iosched.o
  CC      drivers/block/deadline-iosched.o
  CC      drivers/block/floppy.o
  CC      drivers/block/nbd.o
  LD      drivers/block/built-in.o
  CC      drivers/cdrom/cdrom.o
  LD      drivers/cdrom/built-in.o
  CC      drivers/char/mem.o
  CC      drivers/char/tty_io.o
  CC      drivers/char/n_tty.o
  CC      drivers/char/tty_ioctl.o
  CC      drivers/char/pty.o
  CC      drivers/char/misc.o
  CC      drivers/char/random.o
  CC      drivers/char/vt_ioctl.o
  CC      drivers/char/vc_screen.o
  CC      drivers/char/consolemap.o
  CONMK   drivers/char/consolemap_deftbl.c
  CC      drivers/char/consolemap_deftbl.o
  CC      drivers/char/selection.o
  CC      drivers/char/keyboard.o
  CC      drivers/char/vt.o
  SHIPPED drivers/char/defkeymap.c
  CC      drivers/char/defkeymap.o
  CC      drivers/char/rtc.o
  CC      drivers/char/hw_random.o
  CC      drivers/char/agp/backend.o
  CC      drivers/char/agp/frontend.o
  CC      drivers/char/agp/generic.o
  CC      drivers/char/agp/isoch.o
  LD      drivers/char/agp/agpgart.o
  CC      drivers/char/agp/amd-k7-agp.o
  LD      drivers/char/agp/built-in.o
  LD      drivers/char/built-in.o
  LD      drivers/i2c/busses/built-in.o
  LD      drivers/i2c/chips/built-in.o
  LD      drivers/i2c/built-in.o
  LD      drivers/ide/arm/built-in.o
  LD      drivers/ide/legacy/built-in.o
  CC      drivers/ide/pci/amd74xx.o
  CC      drivers/ide/pci/generic.o
  LD      drivers/ide/pci/built-in.o
  LD      drivers/ide/ppc/built-in.o
  CC      drivers/ide/ide-io.o
  CC      drivers/ide/ide-probe.o
  CC      drivers/ide/ide-iops.o
  CC      drivers/ide/ide-taskfile.o
  CC      drivers/ide/ide.o
  CC      drivers/ide/ide-lib.o
  CC      drivers/ide/ide-default.o
  CC      drivers/ide/ide-disk.o
  CC      drivers/ide/ide-cd.o
  CC      drivers/ide/setup-pci.o
  CC      drivers/ide/ide-dma.o
  CC      drivers/ide/ide-proc.o
  LD      drivers/ide/built-in.o
  CC      drivers/input/input.o
  CC      drivers/input/mousedev.o
  CC      drivers/input/evdev.o
  CC      drivers/input/keyboard/atkbd.o
  LD      drivers/input/keyboard/built-in.o
  LD      drivers/input/mouse/built-in.o
  LD      drivers/input/built-in.o
  CC      drivers/input/serio/i8042.o
  LD      drivers/input/serio/built-in.o
  LD      drivers/media/common/built-in.o
  LD      drivers/media/dvb/b2c2/built-in.o
  LD      drivers/media/dvb/dvb-core/built-in.o
  LD      drivers/media/dvb/frontends/built-in.o
  LD      drivers/media/dvb/ttpci/built-in.o
  LD      drivers/media/dvb/ttusb-budget/built-in.o
  LD      drivers/media/dvb/ttusb-dec/built-in.o
  LD      drivers/media/dvb/built-in.o
  LD      drivers/media/radio/built-in.o
  LD      drivers/media/video/built-in.o
  LD      drivers/media/built-in.o
  CC      drivers/message/i2o/i2o_core.o
  CC      drivers/message/i2o/i2o_config.o
  CC      drivers/message/i2o/i2o_block.o
  CC      drivers/message/i2o/i2o_scsi.o
  CC      drivers/message/i2o/i2o_proc.o
  LD      drivers/message/i2o/built-in.o
  LD      drivers/message/built-in.o
  LD      drivers/misc/built-in.o
  CC      drivers/net/Space.o
  CC      drivers/net/net_init.o
  CC      drivers/net/loopback.o
  CC      drivers/net/wireless/orinoco.o
  CC      drivers/net/wireless/hermes.o
  CC      drivers/net/wireless/orinoco_pci.o
  LD      drivers/net/wireless/built-in.o
  LD      drivers/net/built-in.o
  CC      drivers/pci/access.o
  CC      drivers/pci/bus.o
  CC      drivers/pci/probe.o
  CC      drivers/pci/remove.o
  CC      drivers/pci/pci.o
  CC      drivers/pci/pool.o
  CC      drivers/pci/quirks.o
  HOSTCC  drivers/pci/gen-devlist
  DEVLIST drivers/pci/devlist.h
  CC      drivers/pci/names.o
  CC      drivers/pci/pci-driver.o
  CC      drivers/pci/search.o
  CC      drivers/pci/pci-sysfs.o
  CC      drivers/pci/power.o
  CC      drivers/pci/proc.o
  CC      drivers/pci/setup-res.o
  CC      drivers/pci/hotplug.o
  CC      drivers/pci/setup-bus.o
  LD      drivers/pci/built-in.o
  CC      drivers/pnp/core.o
  CC      drivers/pnp/card.o
  CC      drivers/pnp/driver.o
  CC      drivers/pnp/resource.o
  CC      drivers/pnp/manager.o
  CC      drivers/pnp/support.o
  CC      drivers/pnp/interface.o
  CC      drivers/pnp/quirks.o
  CC      drivers/pnp/system.o
  CC      drivers/pnp/pnpbios/core.o
  CC      drivers/pnp/pnpbios/bioscalls.o
  CC      drivers/pnp/pnpbios/rsparser.o
  CC      drivers/pnp/pnpbios/proc.o
  LD      drivers/pnp/pnpbios/built-in.o
  LD      drivers/pnp/built-in.o
  CC      drivers/scsi/scsi.o
  CC      drivers/scsi/hosts.o
  CC      drivers/scsi/scsi_ioctl.o
  CC      drivers/scsi/constants.o
  CC      drivers/scsi/scsicam.o
  CC      drivers/scsi/scsi_error.o
  CC      drivers/scsi/scsi_lib.o
  CC      drivers/scsi/scsi_scan.o
  CC      drivers/scsi/scsi_syms.o
  CC      drivers/scsi/scsi_sysfs.o
  CC      drivers/scsi/scsi_devinfo.o
  CC      drivers/scsi/scsi_proc.o
  CC      drivers/scsi/sd.o
  LD      drivers/scsi/scsi_mod.o
  CC      drivers/scsi/dpt_i2o.o
drivers/scsi/dpt_i2o.c:32:2: #error Please convert me to 
Documentation/DMA-mapping.txtdrivers/scsi/dpt_i2o.c: In function 
`adpt_install_hba':drivers/scsi/dpt_i2o.c:977: warning: passing arg 2 of 
`request_irq' from incompatible pointer typedrivers/scsi/dpt_i2o.c: In function 
`adpt_scsi_to_i2o':drivers/scsi/dpt_i2o.c:2118: structure has no member named 
`address'
--Boundary-00=_puST/2pcJE95bQA--

