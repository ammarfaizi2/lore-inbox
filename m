Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVJXPYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVJXPYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVJXPYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:24:17 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:62009 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751089AbVJXPYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:24:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KbnaaoTcxX8TbTrlKv4iLNLLRaLIdtZSG+qfDx597NusqiSP5QTEA0HzWnOBoqDG+6+6PdkUKN9LuQihxeasvDZMQ4hOrns8y4hfsIyvKsJ5DIE8EyPy+S7xlZq5dwFndOqRTv9bu0FxckylgXCAA4cyiZQ0BvffxsvZqSCxcsA=
Message-ID: <8e9415f80510240824g5b7bca95h@mail.gmail.com>
Date: Mon, 24 Oct 2005 17:24:14 +0200
From: =?ISO-8859-1?Q?Hans-J=FCrgen_Mehnert?= <hjmehnert@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1


[2.]
Since kernel version 2.4.31 we have system crashes with
blank screen and nothing in logs on at least 5 different
Intel and AMD SMP machines. 2.4.32rc1 has the same problem,
2.4.30 is working stable on these machines. We had no crashes
with the newer kernel versions on about 100 single-cpu machines
so far.


[3.]
No keywords.


[4.]
Linux version 2.4.32-grsec (root@d116.x-mailer.de) (gcc version 2.96
20000731 (Red Hat Linux 7.2 2.96-112.7.1)) #32 Mit Okt 12 11:44:29
CEST 2005


[5.]
No Oops output.


[6.]
No shell script.


[7.1.]
[root@d116 linux-2.4.32-rc1]# ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux d116.x-mailer.de 2.4.31-grsec #12 SMP Mon Jun 27 16:40:02 CEST
2005 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.18
e2fsprogs              1.26
quota-tools            3.01.
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 3.2.3
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0


[7.2.]
[root@d102 /]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4784.12

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4797.23

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4797.23

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4797.23


[7.3.]
Kernel module support disabled.


[7.4.]
[root@d102 /]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
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
03f8-03ff : serial(auto)
0540-055f : Intel Corp. 82801CA/CAM SMBus Controller
0cf8-0cff : PCI conf1
c000-c03f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  c000-c03f : e100
c400-c40f : 3ware Inc 3ware 7000-series ATA-RAID
  c400-c40f : 3ware Storage Controller
c800-c8ff : ATI Technologies Inc Rage XL
d000-dfff : PCI Bus #02
  d000-dfff : PCI Bus #04
    d800-d83f : Intel Corp. 82545EM Gigabit Ethernet Controller (Copper)
      d800-d83f : e1000
e800-e81f : Intel Corp. 82801CA/CAM USB (Hub #1)
  e800-e81f : usb-uhci
ffa0-ffaf : Intel Corp. 82801CA Ultra ATA Storage Controller
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

[root@d102 /]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9800-000cafff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00158000-004036d8 : Kernel code
  00485c60-004f6fff : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
80000000-800003ff : Intel Corp. 82801CA Ultra ATA Storage Controller
fc800000-fcffffff : 3ware Inc 3ware 7000-series ATA-RAID
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe7a0000-fe7bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fe7a0000-fe7bffff : e100
fe7fd000-fe7fdfff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fe7fd000-fe7fdfff : e100
fe7fec00-fe7fec0f : 3ware Inc 3ware 7000-series ATA-RAID
fe7ff000-fe7fffff : ATI Technologies Inc Rage XL
fe800000-feafffff : PCI Bus #02
  fe800000-fe8fffff : PCI Bus #03
  fe900000-fe9fffff : PCI Bus #04
    fe9e0000-fe9fffff : Intel Corp. 82545EM Gigabit Ethernet Controller (Copper)
      fe9e0000-fe9fffff : e1000
  feafe000-feafefff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  feaff000-feafffff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
ff700000-ff9fffff : PCI Bus #02
  ff700000-ff7fffff : PCI Bus #03
  ff800000-ff8fffff : PCI Bus #04
ffb80000-ffffffff : reserved


[7.5.]
[root@d102 /]# lspci -vvv
00:00.0 Host bridge: Intel Corporation: Unknown device 254c (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [1105]

00:02.0 PCI bridge: Intel Corporation: Unknown device 2543 (rev 01)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe800000-feafffff
        Prefetchable memory behind bridge: ff700000-ff9fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev
02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 2480
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at e800 [size=32]

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI
(rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: fb700000-fe7fffff
        Prefetchable memory behind bridge: ff600000-ff6fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2480 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02)
(prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation: Unknown device 2480
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 02)
        Subsystem: Intel Corporation: Unknown device 2480
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0540 [size=32]

01:01.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 10)
        Subsystem: Intel Corporation: Unknown device 1040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fe7fd000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c000 [size=64]
        Region 2: Memory at fe7a0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at c800 [size=256]
        Region 2: Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe7c0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:04.0 RAID bus controller: 3ware Inc: Unknown device 1001 (rev 01)
        Subsystem: 3ware Inc: Unknown device 1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at c400 [size=16]
        Region 1: Memory at fe7fec00 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at fc800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at fe7e0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 04) (prog-if
20 [IO(X)-APIC])
        Subsystem: Intel Corporation: Unknown device 1461
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: 00000000ff800000-00000000ff800000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 04) (prog-if
20 [IO(X)-APIC])
        Subsystem: Intel Corporation: Unknown device 1461
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: 00000000ff700000-00000000ff700000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:01.0 Ethernet controller: Intel Corporation: Unknown device 100f (rev 01)
        Subsystem: Intel Corporation: Unknown device 1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
Message Signalled Interrupts: 64bit+ Queu
0/0 Enable-
                Address: 0000000000000000  Data: 0000


[7.6.]
[root@d102 /]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff


H.-J. Mehnert
