Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUIBSzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUIBSzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUIBSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:55:44 -0400
Received: from spark.combustionlabs.com ([66.165.42.10]:46742 "EHLO
	spark.combustionlabs.com") by vger.kernel.org with ESMTP
	id S268064AbUIBSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:55:18 -0400
From: Piotr Banasik <piotr@t-p-l.com>
To: linux-kernel@vger.kernel.org
Subject: kernel bug: 2.6.8.1
Date: Thu, 2 Sep 2004 11:58:11 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7024180.ke407RY7vc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409021158.15192.piotr@t-p-l.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7024180.ke407RY7vc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[1.] One line summary of the problem: =20
abnormaly slow download speeds (~10k/s)
[2.] Full description of the problem/report:=20
any download .. for example:=20
http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.1.tar.bz2 .. is throttl=
ed=20
down to 10k/s
[3.] Keywords (i.e., modules, networking, kernel):
networking, kernel
[4.] Kernel version (from /proc/version):
Linux version 2.6.8.1 (root@ember) (gcc version 3.3.3 20040412 (Gentoo Linu=
x=20
3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 SMP Thu Sep 2 22:42:42 PDT 2004
[6.] A small shell script or example program which triggers the
     problem (if possible)
# wget http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.1.tar.bz2
[7.1.] Software (add the output of the ver_linux script here)
Linux ember 2.6.8.1 #2 SMP Thu Sep 2 22:42:42 PDT 2004 i686 Intel(R) Xeon(T=
M)=20
CPU 2.80GHz GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
quota-tools            3.06.
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         usbcore
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 5
cpu MHz         : 2800.448
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5521.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 5
cpu MHz         : 2800.448
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5586.94

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2800.448
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5586.94

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2800.448
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5586.94
[7.3.] Module information (from /proc/modules):
usbcore 102628 1 - Live 0xf899d000
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0400-047f : 0000:00:1f.0
  0408-040b : ACPI timer
  0410-0415 : ACPI CPU throttle
0500-053f : 0000:00:1f.0
0540-055f : 0000:00:1f.3
0cf8-0cff : PCI conf1
a000-a0ff : 0000:01:04.0
b000-cfff : PCI Bus #02
  b000-bfff : PCI Bus #03
    b400-b43f : 0000:03:01.0
      b400-b43f : e1000
    b800-b83f : 0000:03:02.0
      b800-b83f : e1000
  c000-cfff : PCI Bus #04
    c800-c8ff : 0000:04:01.0
      c800-c8ff : 3w-9xxx
e000-e01f : 0000:00:1d.0
e400-e41f : 0000:00:1d.1
e800-e81f : 0000:00:1d.2
ffa0-ffaf : 0000:00:1f.1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000cafff : Adapter ROM
000cb000-000cc7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-003226f2 : Kernel code
  003226f3-0041027f : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
80000000-800003ff : 0000:00:1f.1
fb300000-fc5fffff : PCI Bus #02
  fb300000-fb3fffff : PCI Bus #03
  fb400000-fc4fffff : PCI Bus #04
    fb800000-fbffffff : 0000:04:01.0
      fb800000-fbffffff : 3w-9xxx
fd000000-fdffffff : 0000:01:04.0
fe6ff000-fe6fffff : 0000:01:04.0
fe800000-feafffff : PCI Bus #02
  fe800000-fe8fffff : PCI Bus #03
    fe8a0000-fe8bffff : 0000:03:01.0
      fe8a0000-fe8bffff : e1000
    fe8e0000-fe8fffff : 0000:03:02.0
      fe8e0000-fe8fffff : e1000
  fe900000-fe9fffff : PCI Bus #04
    fe9ffc00-fe9ffcff : 0000:04:01.0
      fe9ffc00-fe9ffcff : 3w-9xxx
  feafe000-feafefff : 0000:02:1c.0
  feaff000-feafffff : 0000:02:1e.0
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
# lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [1105]

0000:00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PC=
I=20
Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=3D00, secondary=3D02, subordinate=3D04, sec-latency=3D0
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: fe800000-feafffff
        Prefetchable memory behind bridge: fb300000-fc5fffff
        Expansion ROM at 0000b000 [disabled] [size=3D8K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)=
=20
(prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at e000 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)=
=20
(prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at e400 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)=
=20
(prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at e800 [size=3D32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to P=
CI=20
Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fc700000-fe7fffff
        Prefetchable memory behind bridge: fb200000-fb2fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev =
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controlle=
r=20
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=3D16]
        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D1K]

0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 4880
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0540 [size=3D32]

0000:01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 2=
7)=20
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)=20
[size=3Dfe6c0000]
        Region 1: I/O ports at a000 [size=3D256]
        Region 2: Memory at fe6ff000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20=20
[IO(X)-APIC])
        Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at feafe000 (32-bit, non-prefetchable)
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-,=
=20
DC=3Dsimple, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)=
=20
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=3D02, secondary=3D04, subordinate=3D04, sec-latency=3D=
64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: 00000000fb400000-00000000fc400000
        Expansion ROM at 0000c000 [disabled] [size=3D4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD-=20
=46req=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, =
SCO-,=20
SRD-
                : Upstream: Capacity=3D0, Commitment Limit=3D0
                : Downstream: Capacity=3D0, Commitment Limit=3D0

0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20=20
[IO(X)-APIC])
        Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at feaff000 (32-bit, non-prefetchable)
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-,=
=20
DC=3Dsimple, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)=
=20
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D=
64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: 00000000fb300000-00000000fb300000
        Expansion ROM at 0000b000 [disabled] [size=3D4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD-=20
=46req=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, =
SCO-,=20
SRD-
                : Upstream: Capacity=3D0, Commitment Limit=3D0
                : Downstream: Capacity=3D0, Commitment Limit=3D0

0000:03:01.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet=20
Controller (Copper)
        Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at fe8a0000 (32-bit, non-prefetchable)
        Region 2: I/O ports at b400 [size=3D64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-,=
=20
DC=3Dsimple, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
0000:03:02.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet=20
Controller (Copper)
        Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at fe8e0000 (32-bit, non-prefetchable)
        Region 2: I/O ports at b800 [size=3D64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-,=
=20
DC=3Dsimple, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
0000:04:01.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 48
        Region 0: I/O ports at c800 [size=3Dfe9e0000]
        Region 1: Memory at fe9ffc00 (64-bit, non-prefetchable) [size=3D256]
        Region 3: Memory at fb800000 (64-bit, prefetchable) [size=3D8M]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-,=
=20
DC=3Dsimple, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-      Capabilities: [4=
8] Power=20
Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA=20
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 00  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff

[X.] Other notes, patches, fixes, workarounds:
This appears to be fine in 2.6.7 and breaks in 2.6.8.1 so its something tha=
t=20
was added inbetween there I'd imagine

--nextPart7024180.ke407RY7vc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBN21HK/moK1eYP3MRAkrdAKCW2Bo1OILIJ9e6N33KAA+coEKr3QCdGZpA
5xEzQt98idqcopSWks/iSDw=
=yzQo
-----END PGP SIGNATURE-----

--nextPart7024180.ke407RY7vc--
