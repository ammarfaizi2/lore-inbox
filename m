Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130319AbQLVSSY>; Fri, 22 Dec 2000 13:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbQLVSSP>; Fri, 22 Dec 2000 13:18:15 -0500
Received: from ns1.tu-graz.ac.at ([129.27.2.3]:16620 "EHLO ns1.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S130319AbQLVSSD>;
	Fri, 22 Dec 2000 13:18:03 -0500
From: rkreiner@sbox.tu-graz.ac.at
Message-ID: <3A43945E.6B34955B@sbox.tu-graz.ac.at>
Date: Fri, 22 Dec 2000 18:50:22 +0100
X-Mailer: Mozilla 4.74 [de] (X11; U; Linux 2.4.0-test13-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: test13-pre3, e2fs corruption
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. test13-pre3, e2fs corruption

2. running my box 4h 30min i wanted edit some files, the filenames 
   were wrong and other files didnt have the correct data.
   i unmounted the drive with the data and a e2fsck said
   wrong group names...bad superblock...
   after reboot without check or repair on 2.2.18 no problems 
   reported and all my data are correct.
   some days before i tried mount my atapi-cdrom and my box hangs
   completly with test12 or test13-pre1, couldnt reproduce it yet.
   (no overclocking)

3. e2fs filesystem

4. Linux version 2.4.0-test13-pre3 (root@apollo) (gcc version 2.95.2
19991024 (release)) #3 SMP Mon Dec 18 02:30:28 CET 2000

5. none

6. none

7. none

7.1 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux apollo 2.4.0-test13-pre3 #3 SMP Mon Dec 18 02:30:28 CET 2000 i586
unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070406 Jul 30 21:41
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         

7.2
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 400.906
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 799.54

7.3
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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
d000-d00f : Acer Laboratories Inc. [ALi] M5229 IDE
d400-d43f : Ensoniq ES1371 [AudioPCI-97]
  d400-d43f : es1371
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d800-d8ff : eth0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffbfff : System RAM
  00100000-002ef4af : Kernel code
  002ef4b0-0031193f : Kernel data
07ffc000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
de000000-de0000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  de000000-de0000ff : eth0
df000000-dfffffff : PCI Bus #01
  df000000-df7fffff : Matrox Graphics, Inc. MGA G400 AGP
  df800000-df803fff : Matrox Graphics, Inc. MGA G400 AGP
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
e5f00000-e7ffffff : PCI Bus #01
  e6000000-e7ffffff : Matrox Graphics, Inc. MGA G400 AGP
ffff0000-ffffffff : reserved

7.5
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP
System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: df000000-dfffffff
	Prefetchable memory behind bridge: e5f00000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management
Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d000 [size=16]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e5ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

7.6 none

7.7 none

X

i try to reproduce this. dont know which other information is important
now
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
