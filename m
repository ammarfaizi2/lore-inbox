Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQLWSxG>; Sat, 23 Dec 2000 13:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbQLWSw4>; Sat, 23 Dec 2000 13:52:56 -0500
Received: from 195-171-218-40.btconnect.com ([195.171.218.40]:8196 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130386AbQLWSwn>;
	Sat, 23 Dec 2000 13:52:43 -0500
Date: Sat, 23 Dec 2000 18:24:27 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: rkreiner@sbox.tu-graz.ac.at
cc: linux-kernel@vger.kernel.org
Subject: FEATURE (was Re: PROBLEM: multiple mount of devices possible
 2.4.0-test1 -  2.4.0-test13-pre4
In-Reply-To: <3A44DEE4.2D94574F@sbox.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.21.0012231824020.838-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it is not a problem, it is a feature. (and a useful one!)

On Sat, 23 Dec 2000 rkreiner@sbox.tu-graz.ac.at wrote:

> 
> 1. multiple mount of devices possible 2.4.0-test1 - 2.4.0-test13-pre4
> 
> 2. its still possible to mount devices several times.
>    IMHO it shouldnt be possible like 2.2.18
>    with umount in /proc/mounts is still the real information,
>    in /etc/mtab all corresponding mountpoints are deleted.
> 
> 3. kernel, filesystem, mount
> 
> 4. Linux version 2.4.0-test13-pre4 (root@apollo) (gcc version 2.95.2
> 19991024 (release)) #1 SMP Sat Dec 23 17:04:07 CET 2000
> 
> 5. none
> 
> 6. example
>    #!/bin/sh
>    mount /dev/hda2 /gate
>    mount -t nfs gate:/ /gate
>    mount -t nfs gate:/ /gate
>    mount /dev/hda2 /mnt
> 
> 7. 
> 
> 7.1
> -- Versions installed: (if some fields are empty or look
> -- unusual then possibly you have very old versions)
> Linux apollo 2.4.0-test13-pre4 #1 SMP Sat Dec 23 17:04:07 CET 2000 i586
> unknown
> Kernel modules         2.3.11
> Gnu C                  2.95.2
> Gnu Make               3.79.1
> Binutils               2.9.5.0.24
> Linux C Library        x   1 root     root      4070406 Jul 30 21:41
> /lib/libc.so.6
> Dynamic linker         ldd (GNU libc) 2.1.3
> Procps                 2.0.6
> Mount                  2.10m
> Net-tools              1.56
> Kbd                    0.99
> Sh-utils               2.0
> Modules Loaded         
> 
> 7.2
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 5
> model		: 8
> model name	: AMD-K6(tm) 3D processor
> stepping	: 12
> cpu MHz		: 400.906
> cache size	: 64 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
> bogomips	: 799.54
> 
> 7.3
> 
> 7.4
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0213-0213 : isapnp read
> 02f8-02ff : serial(auto)
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0a79-0a79 : isapnp write
> 0cf8-0cff : PCI conf1
> 5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
> d000-d00f : Acer Laboratories Inc. [ALi] M5229 IDE
> d400-d43f : Ensoniq ES1371 [AudioPCI-97]
>   d400-d43f : es1371
> d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   d800-d8ff : eth0
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-07ffbfff : System RAM
>   00100000-002ef4af : Kernel code
>   002ef4b0-0031193f : Kernel data
> 07ffc000-07ffefff : ACPI Tables
> 07fff000-07ffffff : ACPI Non-volatile Storage
> de000000-de0000ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   de000000-de0000ff : eth0
> df000000-dfffffff : PCI Bus #01
>   df000000-df7fffff : Matrox Graphics, Inc. MGA G400 AGP
>   df800000-df803fff : Matrox Graphics, Inc. MGA G400 AGP
> e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
> e5f00000-e7ffffff : PCI Bus #01
>   e6000000-e7ffffff : Matrox Graphics, Inc. MGA G400 AGP
> ffff0000-ffffffff : reserved
> 
> 7.5
> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
> 	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP
> System Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR-
> 	Latency: 64
> 	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
> 	Capabilities: [b0] AGP version 1.0
> 		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if
> 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	I/O behind bridge: 0000e000-0000dfff
> 	Memory behind bridge: df000000-dfffffff
> 	Prefetchable memory behind bridge: e5f00000-e7ffffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
> 
> 00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
> 	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management
> Controller
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
> [Aladdin IV] (rev c3)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort+ <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
> (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: I/O ports at d800 [size=256]
> 	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
> 
> 00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
> 06)
> 	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
> 	Latency: 32 (3000ns min, 32000ns max)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at d400 [size=64]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
> PME(D0+,D1-,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
> (prog-if 8a [Master SecP PriP])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 1000ns max)
> 	Interrupt: pin A routed to IRQ 0
> 	Region 4: I/O ports at d000 [size=16]
> 
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
> (rev 03) (prog-if 00 [VGA])
> 	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (4000ns min, 8000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
> 	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at e5ff0000 [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
> 
> 7.6
> 
> 7.7
> Mount Version:
> mount: mount-2.10m
> 
> Output of /proc/mounts:
> /dev/root / ext2 rw 0 0
> proc /proc proc rw 0 0
> /dev/hda7 /home ext2 rw 0 0
> /dev/hda9 /data vfat rw 0 0
> /dev/hda8 /datax vfat rw 0 0
> /dev/hda10 /data2 vfat rw 0 0
> /dev/hdb1 /data3 vfat rw 0 0
> /dev/hda3 /win98 vfat rw 0 0
> /dev/hda6 /redhat ext2 rw 0 0
> /dev/hda11 /sicher ext2 ro 0 0
> /dev/hda13 /sicher2 ext2 ro 0 0
> /dev/hdb6 /sicher3 ext2 rw 0 0
> devpts /dev/pts devpts rw 0 0
> /dev/hda2 /gate vfat rw 0 0
> gate:/ /gate nfs rw,v2,rsize=8192,wsize=8192,hard,udp,lock,addr=gate 0 0
> gate:/ /gate nfs rw,v2,rsize=8192,wsize=8192,hard,udp,lock,addr=gate 0 0
> /dev/hda2 /mnt vfat rw 0 0
> 
> X.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
