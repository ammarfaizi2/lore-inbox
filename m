Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRC0UWK>; Tue, 27 Mar 2001 15:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131542AbRC0UWC>; Tue, 27 Mar 2001 15:22:02 -0500
Received: from quechua.inka.de ([212.227.14.2]:21844 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131535AbRC0UVs>;
	Tue, 27 Mar 2001 15:21:48 -0500
Message-ID: <006901c0b6fb$9f3597b0$0a0a0a0a@wasserwerk>
From: "Christian Fruth" <jt.kirk@earthling.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: APIC-Errors
Date: Tue, 27 Mar 2001 22:22:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1: One line summary of the problem:

 Logfile is full of APIC errors

2: Full description of the problem/report:

My logfile for kernel-errors is full of messages like that:
Mar 27 20:57:27 E-Werk kernel: APIC error on CPU0: 02(04)
Mar 27 20:57:27 E-Werk kernel: APIC error on CPU1: 08(08)
Mar 27 20:57:34 E-Werk kernel: APIC error on CPU0: 04(02)
Mar 27 21:00:40 E-Werk kernel: APIC error on CPU1: 08(08)
Mar 27 21:00:48 E-Werk kernel: APIC error on CPU0: 02(02)

There aren't any more detailed errormessages

The System seems to run normal. No system-crashs or something like that.
But someone in a Linux-Channel said me that i should report it

3: Keywords (i.e., modules, networking, kernel):

kernel, cpu, smp

4: Kernel version (from /proc/version):

Linux version 2.4.2 (root@E-Werk) (gcc version 2.95.2 19991024
(release)) #5 SMP Sat Mar 24 18:09:27 MET 2001

7: Environment:
    1: Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux E-Werk 2.4.2 #5 SMP Sat Mar 24 18:09:27 MET 2001 i686 unknown
Kernel modules         2.4.3
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4061504 Mar 11  2000
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ipt_REJECT ipt_LOG iptable_filter ipt_MASQUERADE
iptable_nat ip_tables ip_conntrack hisax isdn slhc

    2: Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.147
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
cmov pat pse36 mmx fxsr
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.147
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
cmov pat pse36 mmx fxsr
bogomips        : 999.42

    3: Module information (from /proc/modules):

ipt_REJECT              2016   0 (autoclean)
ipt_LOG                 3344   0 (autoclean)
iptable_filter          1856   0 (autoclean) (unused)
ipt_MASQUERADE          1408   1 (autoclean)
iptable_nat            14944   0 [ipt_MASQUERADE]
ip_tables              10560   7 [ipt_REJECT ipt_LOG iptable_filter
ipt_MASQUERADE iptable_nat]
ip_conntrack           14272   1 [ipt_MASQUERADE iptable_nat]
hisax                 138000   2
isdn                   92848   2 [hisax]
slhc                    4576   1 [isdn]

    4: Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-c01f : Intel Corporation 82371AB PIIX4 USB
c400-c4ff : Symbios Logic Inc. (formerly NCR) 53c875
  c400-c47f : ncr53c8xx
c800-c87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  c800-c87f : eth0
cc00-cc1f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
  cc00-cc1f : avm PCI
d000-d007 : Triones Technologies, Inc. HPT366
d400-d403 : Triones Technologies, Inc. HPT366
d800-d8ff : Triones Technologies, Inc. HPT366
dc00-dc07 : Triones Technologies, Inc. HPT366 (#2)
e000-e003 : Triones Technologies, Inc. HPT366 (#2)
e400-e4ff : Triones Technologies, Inc. HPT366 (#2)
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb3ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-001ef998 : Kernel code
  001ef999-0024a5ff : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e6000000-e6003fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e7000000-e77fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e8000000-e87fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
eb000000-eb000fff : Symbios Logic Inc. (formerly NCR) 53c875
eb001000-eb0010ff : Symbios Logic Inc. (formerly NCR) 53c875
eb002000-eb00201f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN
[Fritz]
eb003000-eb00307f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

    5: PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at f000 [disabled] [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875
(rev 26)
        Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 min, 64 max, 134 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at eb001000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at eb000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e4000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)
        Subsystem: 3Com Corporation: Unknown device 9055
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c800 [size=128]
        Region 1: Memory at eb003000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at e5000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique] (rev 02) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at e7000000 (32-bit, prefetchable) [size=8M]
        Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:11.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH: Unknown
device 0a00
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at eb002000 (32-bit, non-prefetchable) [size=32]
        Region 1: I/O ports at cc00 [size=32]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 248 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at d400 [size=4]
        Region 4: I/O ports at d800 [size=256]
        Expansion ROM at ea000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 248 set, cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=256]

    6: SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-39130W      Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U06S   Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.08
  Type:   Direct-Access                    ANSI SCSI revision: 02

Greetings
    Christian Fruth

