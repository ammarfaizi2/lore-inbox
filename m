Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271304AbSISPlk>; Thu, 19 Sep 2002 11:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271489AbSISPlk>; Thu, 19 Sep 2002 11:41:40 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:19842 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S271304AbSISPlg>; Thu, 19 Sep 2002 11:41:36 -0400
Date: Thu, 19 Sep 2002 08:46:42 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: I have no console and I must type.
Message-ID: <20020919154642.GA8230@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.36 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

No keyboard control on the console or in X

[2.] Full description of the problem/report:

No keyboard control with devfs enabled on boot up.
Is it time to give up on devfs? (This is not flamebait.)

[3.] Keywords (i.e., modules, networking, kernel):
Keyboard console

[4.] Kernel version (from /proc/version):

Linux version 2.5.36 (root@the-penguin) (gcc version 2.95.4 20011002 (Debian prerelease)) #0 Wed Sep 18 15:46:06 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No messages or oops.

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A
[7.] Environment
Debian unstable devfs enabled on bootup.

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.5.36 #0 Wed Sep 18 15:46:06 PDT 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.28
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.1
Modules Loaded         nls_iso8859-1 ncpfs radeon binfmt_misc vfat fat sr_mod cdrom 3c59x
[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1700+
stepping	: 2
cpu MHz		: 1466.587
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2883.58

[7.3.] Module information (from /proc/modules):

nls_iso8859-1           2844   0 (autoclean)
ncpfs                  36184   0 (autoclean)
radeon                 96180   0
binfmt_misc             5796   1
vfat                    9856   0 (unused)
fat                    32920   0 [vfat]
sr_mod                 12324   0 (unused)
cdrom                  29504   0 [sr_mod]
3c59x                  25664   1
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

*ioports*

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial
03c0-03df : vga+
03f8-03ff : serial
0cf8-0cff : PCI conf1
7800-781f : VIA Technologies, Inc. USB (#4)
8000-801f : VIA Technologies, Inc. USB (#3)
8400-840f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
8800-887f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  8800-887f : 00:0f.0
9000-90ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
  9000-907f : sym53c8xx
9400-941f : VIA Technologies, Inc. USB (#2)
9800-981f : VIA Technologies, Inc. USB
a000-a00f : Promise Technology, Inc. PDC20276 IDE
a400-a403 : Promise Technology, Inc. PDC20276 IDE
a800-a807 : Promise Technology, Inc. PDC20276 IDE
b000-b003 : Promise Technology, Inc. PDC20276 IDE
b400-b407 : Promise Technology, Inc. PDC20276 IDE
b800-b8ff : C-Media Electronics Inc CM8738
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Radeon VE QY
*iomem*


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d1fff : Extension ROM
000f0000-000fffff : System ROM
00100000-2fffbfff : System RAM
  00100000-0025b05b : Kernel code
  0025b05c-002fbaef : Kernel data
2fffc000-2fffefff : ACPI Tables
2ffff000-2fffffff : ACPI Non-volatile Storage
d3800000-d380007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d4000000-d4000fff : LSI Logic / Symbios Logic (formerly NCR) 53c895
d4800000-d48000ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
d5000000-d50000ff : VIA Technologies, Inc. USB 2.0
d5800000-d5803fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
d6000000-d60007ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
d6800000-d6803fff : Promise Technology, Inc. PDC20276 IDE
d7000000-d7dfffff : PCI Bus #01
  d7000000-d700ffff : ATI Technologies Inc Radeon VE QY
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at b800 [size=256]
	Capabilities: <available only to root>

00:06.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) (prog-if 85)
	Subsystem: Asustek Computer, Inc.: Unknown device 807e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at d6800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 Controller (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 35 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: <available only to root>

00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: <available only to root>

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 8800 [size=128]
	Region 1: Memory at d3800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8400 [disabled] [size=16]
	Capabilities: <available only to root>

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at 8000 [size=32]
	Capabilities: <available only to root>

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at 7800 [size=32]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: <available only to root>

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1037
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
devfs version:
1.3.25-10 from debian.

[X.] Other notes, patches, fixes, workarounds:
If I disable devfs it works, if devfs is soon not to be supported,
deprecated please tell me and I will make plans to remove it.

Thank you

---
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


