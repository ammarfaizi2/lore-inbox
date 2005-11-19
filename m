Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVKSJzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVKSJzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 04:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKSJzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 04:55:16 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:29633 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750881AbVKSJzO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 04:55:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OxRwJiuT41nPWCwojw7fhuRwgT3/gjiMnNBUP5hESlugsY+T/sp0sAYLXP3QPvcWPwIlUT2kpZL26vcZcuig22QWn2zZoKHYBfakcPT4bCNs40Gpl7SKfIeM8xs1o00bJBc6bYtM7e4Ztbb9sQim2bom/rbELaUnlH/a4hToJjY=
Message-ID: <3aa654a40511190155h6751c424qd5de8cc702f4d7cc@mail.gmail.com>
Date: Sat, 19 Nov 2005 01:55:13 -0800
From: Avuton Olrich <avuton@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Machine check exception
In-Reply-To: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have put my dmesg output in the last email:

dmesg:

Bootdata ok (command line is root=/dev/sda3)
Linux version 2.6.15-rc1-mm2 (root@rocket) (gcc version 3.4.4 (Gentoo
3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #4 SMP PREEMPT Fri Nov 18
23:13:49 PST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000f8000000 - 00000000fa000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 GBT                                   ) @ 0x00000000000f6bc0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000003fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000003fff3040
ACPI: MCFG (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000003fff7e80
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000003fff7e00
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000003fff0000
Using 31 for the hash shift.
Using node hash shift of 31
Bootmem setup node 0 0000000000000000-000000003fff0000
On node 0 totalpages: 257253
  DMA zone: 2748 pages, LIFO batch:2
  DMA32 zone: 254505 pages, LIFO batch:64
  Normal zone: 0 pages, LIFO batch:2
  HighMem zone: 0 pages, LIFO batch:2
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:b8000000)
Checking aperture...
CPU 0: aperture @ 20000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda3
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2210.078 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1027236k/1048512k available (3077k kernel code, 20888k
reserved, 1083k data, 232k init)
Calibrating delay using timer specific routine.. 4425.08 BogoMIPS (lpj=2212543)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.557 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4419.58 BogoMIPS (lpj=2209792)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 804 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
-> [0][1][  65536]   0.0 [  0.0] (0): (   21955    10977)
-> [0][1][  68985]   0.0 [  0.0] (0): (   22132     5577)
-> [0][1][  72615]   0.0 [  0.0] (0): (   23733     3589)
-> [0][1][  76436]   0.0 [  0.0] (0): (   25086     2471)
-> [0][1][  80458]   0.0 [  0.0] (0): (   20524     3516)
-> [0][1][  84692]   0.0 [  0.0] (0): (   26850     4921)
-> [0][1][  89149]   0.0 [  0.0] (0): (   27712     2891)
-> [0][1][  93841]   0.0 [  0.0] (0): (   31285     3232)
-> [0][1][  98780]   0.0 [  0.0] (0): (   29505     2506)
-> [0][1][ 103978]   0.0 [  0.0] (0): (   31868     2434)
-> [0][1][ 109450]   0.0 [  0.0] (0): (   32108     1337)
-> [0][1][ 115210]   0.0 [  0.0] (0): (   43463     6346)
-> [0][1][ 121273]   0.0 [  0.0] (0): (   40247     4781)
-> [0][1][ 127655]   0.0 [  0.0] (0): (   37516     3756)
-> [0][1][ 134373]   0.0 [  0.0] (0): (   31863     4704)
-> [0][1][ 141445]   0.0 [  0.0] (0): (   35574     4207)
-> [0][1][ 148889]   0.0 [  0.0] (0): (   37936     3284)
-> [0][1][ 156725]   0.0 [  0.0] (0): (   40380     2864)
-> [0][1][ 164973]   0.0 [  0.0] (0): (   52933     7708)
-> [0][1][ 173655]   0.0 [  0.0] (0): (   39999    10321)
-> [0][1][ 182794]   0.0 [  0.0] (0): (   57232    13777)
-> [0][1][ 192414]   0.0 [  0.0] (0): (   52584     9212)
-> [0][1][ 202541]   0.0 [  0.0] (0): (   58599     7613)
-> [0][1][ 213201]   0.0 [  0.0] (0): (   70512     9763)
-> [0][1][ 224422]   0.0 [  0.0] (0): (   79904     9577)
-> [0][1][ 236233]   0.0 [  0.0] (0): (   76571     6455)
-> [0][1][ 248666]   0.0 [  0.0] (0): (   84583     7233)
-> [0][1][ 261753]   0.0 [  0.0] (0): (   75409     8203)
-> [0][1][ 275529]   0.0 [  0.0] (0): (   75093     4259)
-> [0][1][ 290030]   0.0 [  0.0] (0): (   90647     9906)
-> [0][1][ 305294]   0.0 [  0.0] (0): (   86767     6893)
-> [0][1][ 321362]   0.0 [  0.0] (0): (   97974     9050)
-> [0][1][ 338275]   0.0 [  0.0] (0): (   96683     5170)
-> [0][1][ 356078]   0.1 [  0.1] (0): (  112340    10413)
-> [0][1][ 374818]   0.1 [  0.1] (0): (  129420    13746)
-> [0][1][ 394545]   0.1 [  0.1] (0): (  141612    12969)
-> [0][1][ 415310]   0.1 [  0.1] (0): (  149744    10550)
-> [0][1][ 437168]   0.1 [  0.1] (0): (  144297     7998)
-> [0][1][ 460176]   0.1 [  0.1] (0): (  154842     9271)
-> [0][1][ 484395]   0.1 [  0.1] (0): (  161900     8164)
-> [0][1][ 509889]   0.1 [  0.1] (0): (  164008     5136)
-> [0][1][ 536725]   0.1 [  0.1] (0): (  164707     2917)
-> [0][1][ 564973]   0.1 [  0.1] (0): (  179625     8917)
-> [0][1][ 594708]   0.1 [  0.1] (0): (  178789     4876)
-> [0][1][ 626008]   0.0 [  0.1] (0): (   85089    49288)
-> [0][1][ 658955]   0.-1 [  0.1] (0): ( -146767   140572)
-> [0][1][ 693636]   0.-3 [  0.1] (0): ( -321956   157880)
-> [0][1][ 730143]   0.-4 [  0.1] (0): ( -444498   140211)
-> [0][1][ 768571]   0.-4 [  0.1] (0): ( -472184    83948)
-> [0][1][ 809022]   0.-5 [  0.1] (0): ( -501515    56639)
-> [0][1][ 851602]   0.-5 [  0.1] (0): ( -500558    28798)
-> [0][1][ 896423]   0.-5 [  0.1] (0): ( -506987    17613)
-> [0][1][ 943603]   0.-5 [  0.1] (0): ( -507422     9024)
-> [0][1][ 993266]   0.-5 [  0.1] (0): ( -516885     9243)
-> [0][1][1045543]   0.-5 [  0.1] (0): ( -503300    11414)
-> [0][1][1100571]   0.-5 [  0.1] (0): ( -525094    16604)
-> [0][1][1158495]   0.-5 [  0.1] (0): ( -519583    11057)
-> [0][1][1219468]   0.-5 [  0.1] (0): ( -525278     8376)
-> [0][1][1283650]   0.-5 [  0.1] (0): ( -518600     7527)
-> [0][1][1351210]   0.-5 [  0.1] (0): ( -518917     3922)
-> [0][1][1422326]   0.-5 [  0.1] (0): ( -507599     7620)
-> [0][1][1497185]   0.-5 [  0.1] (0): ( -534885    17453)
-> [0][1][1575984]   0.-5 [  0.1] (0): ( -560591    21579)
-> [0][1][1658930]   0.-5 [  0.1] (0): ( -532122    25024)
-> [0][1][1746242]   0.-5 [  0.1] (0): ( -510695    23225)
-> [0][1][1838149]   0.-5 [  0.1] (0): ( -511424    11977)
-> [0][1][1934893]   0.-5 [  0.1] (0): ( -543910    22231)
-> [0][1][2036729]   0.-5 [  0.1] (0): ( -517005    24568)
-> [0][1][2143925]   0.-5 [  0.1] (0): ( -522191    14877)
-> [0][1][2256763]   0.-5 [  0.1] (0): ( -528988    10837)
-> [0][1][2375540]   0.-5 [  0.1] (0): ( -540112    10980)
-> [0][1][2500568]   0.-4 [  0.1] (0): ( -497335    26878)
-> [0][1][2632176]   0.-5 [  0.1] (0): ( -513725    21634)
-> [0][1][2770711]   0.-5 [  0.1] (0): ( -523357    15633)
-> [0][1][2916537]   0.-5 [  0.1] (0): ( -516274    11358)
-> [0][1][3070038]   0.-5 [  0.1] (0): ( -530954    13019)
-> [0][1][3231618]   0.-5 [  0.1] (0): ( -527952     8010)
-> [0][1][3401703]   0.-5 [  0.1] (0): ( -505304    15329)
-> [0][1][3580740]   0.-5 [  0.1] (0): ( -510377    10201)
-> [0][1][3769200]   0.-5 [  0.1] (0): ( -514292     7058)
-> [0][1][3967578]   0.-5 [  0.1] (0): ( -529834    11300)
-> [0][1][4176397]   0.-4 [  0.1] (0): ( -498504    21315)
-> [0][1][4396207]   0.-5 [  0.1] (0): ( -511231    17021)
-> [0][1][4627586]   0.-5 [  0.1] (0): ( -525432    15611)
-> [0][1][4871143]   0.-5 [  0.1] (0): ( -515371    12836)
-> [0][1][5127518]   0.-5 [  0.1] (0): ( -539979    18722)
-> [0][1][5397387]   0.-5 [  0.1] (0): ( -526922    15889)
-> [0][1][5681460]   0.-5 [  0.1] (0): ( -521052    10879)
-> [0][1][5980484]   0.-5 [  0.1] (0): ( -532440    11133)
-> [0][1][6295246]   0.-5 [  0.1] (0): ( -549374    14033)
-> [0][1][6626574]   0.-5 [  0.1] (0): ( -527536    17935)
-> [0][1][6975341]   0.-5 [  0.1] (0): ( -535395    12897)
-> [0][1][7342464]   0.-5 [  0.1] (0): ( -506225    21033)
-> [0][1][7728909]   0.-4 [  0.1] (0): ( -489228    19015)
-> [0][1][8135693]   0.-5 [  0.1] (0): ( -512646    21216)
-> [0][1][8563887]   0.-5 [  0.1] (0): ( -512680    10625)
-> [0][1][9014617]   0.-5 [  0.1] (0): ( -533341    15643)
-> [0][1][9489070]   0.-5 [  0.1] (0): ( -519401    14791)
-> [0][1][9988494]   0.-5 [  0.1] (0): ( -521016     8203)
[0][1] working set size found: 564973, cost: 179625
---------------------
| migration cost matrix (max_cache_size: 0, cpu: 2210 MHz):
---------------------
          [00]    [01]
[00]:     -     0.3(0)
[01]:   0.3(0)    -
--------------------------------
| cacheflush times [1]: 0.3 (359250)
| calibration delay: 5 seconds
--------------------------------
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at f8000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: Subsystem revision 20050916
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:02:00.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
    ACPI-0412: *** Error: Handler for [SystemMemory] returned AE_AML_ALIGNMENT
    ACPI-0508: *** Error: Method execution failed [\_SB_.MEM_._CRS]
(Node ffff81003ffba780), AE_AML_ALIGNMENT
    ACPI-0156: *** Error: Method execution failed [\_SB_.MEM_._CRS]
(Node ffff81003ffba780), AE_AML_ALIGNMENT
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: f0000000-f7ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:10.0
  IO window: b000-cfff
  MEM window: fa000000-fbffffff
  PREFETCH window: 50000000-500fffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 23 (level,
low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: irq 16, io mem 0xfc005000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 22 (level,
low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 17, io mem 0xfc004000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-2: new low speed USB device using ohci_hcd and address 2
usb 2-4: new low speed USB device using ohci_hcd and address 3
usb 2-5: new low speed USB device using ohci_hcd and address 4
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
input: S.T.D. Interact Gaming Device as /class/input/input0
input: USB HID v1.10 Joystick [S.T.D. Interact Gaming Device] on
usb-0000:00:0b.0-2
input: Wish Technologies Adaptoid as /class/input/input1
input: USB HID v1.00 Joystick [Wish Technologies Adaptoid] on usb-0000:00:0b.0-4
input: Logitech USB RECEIVER as /class/input/input2
input: USB HID v1.11 Mouse [Logitech USB RECEIVER] on usb-0000:00:0b.0-5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.47.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 21 (level,
low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:14.0 to 64
input: AT Translated Set 2 keyboard as /class/input/input3
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:14.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1200JB-75CRA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD2000JB-00DUA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:01:06.0
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC1] -> GSI 16 (level,
low) -> IRQ 19
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0x50000000
PDC20269: 100% native mode on irq 19
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hdf: MATSHITADVD-RAM SW-9571, ATAPI CD/DVD-ROM drive
ide2 at 0xb000-0xb007,0xb402 on irq 19
Probing IDE interface ide3...
hdg: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
ide3 at 0xb800-0xb807,0xbc02 on irq 19
hda: max request size: 128KiB
hda: 234375120 sectors (120000 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1
hdc: max request size: 1024KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
hdf: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdg: ATAPI 32X DVD-ROM drive, 256kB Cache
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 20
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 20 (level,
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE400 irq 20
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE408 irq 20
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c68 86:3e01 87:4003 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 320170943 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c68 86:3e01 87:4003 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
i2c /dev entries driver
md: raid0 personality registered as nr 2
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
MC: drivers/edac/edac_mc.c version MC $Revision: 1.4.2.10 $
PCI- Signalled System Error on 0000:00:00.1 0000:00:00.1
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 21
ALSA device list:
  #0: SBLive! Value [CT4670] (rev.4, serial:0x201102) at 0xc400, irq 21
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xe, vid 0x8
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda4 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1>
md: bind<hdc1>
md: bind<sda4>
md: bind<sdb1>
md: running: <sdb1><sda4><hdc1><hda1>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb1
raid0:   comparing sdb1(160079552) with sdb1(160079552)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda4
raid0:   comparing sda4(79417216) with sdb1(160079552)
raid0:   NOT EQUAL
raid0:   comparing sda4(79417216) with sda4(79417216)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: looking at hdc1
raid0:   comparing hdc1(195358336) with sdb1(160079552)
raid0:   NOT EQUAL
raid0:   comparing hdc1(195358336) with sda4(79417216)
raid0:   NOT EQUAL
raid0:   comparing hdc1(195358336) with hdc1(195358336)
raid0:   END
raid0:   ==> UNIQUE
raid0: 3 zones
raid0: looking at hda1
raid0:   comparing hda1(117187456) with sdb1(160079552)
raid0:   NOT EQUAL
raid0:   comparing hda1(117187456) with sda4(79417216)
raid0:   NOT EQUAL
raid0:   comparing hda1(117187456) with hdc1(195358336)
raid0:   NOT EQUAL
raid0:   comparing hda1(117187456) with hda1(117187456)
raid0:   END
raid0:   ==> UNIQUE
raid0: 4 zones
raid0: FINAL 4 zones
raid0: zone 1
raid0: checking hda1 ... contained as device 0
  (117187456) is smallest!.
raid0: checking hdc1 ... contained as device 1
raid0: checking sda4 ... nope.
raid0: checking sdb1 ... contained as device 2
raid0: zone->nb_dev: 3, size: 113310720
raid0: current zone offset: 117187456
raid0: zone 2
raid0: checking hda1 ... nope.
raid0: checking hdc1 ... contained as device 0
  (195358336) is smallest!.
raid0: checking sda4 ... nope.
raid0: checking sdb1 ... contained as device 1
  (160079552) is smallest!.
raid0: zone->nb_dev: 2, size: 85784192
raid0: current zone offset: 160079552
raid0: zone 3
raid0: checking hda1 ... nope.
raid0: checking hdc1 ... contained as device 0
  (195358336) is smallest!.
raid0: checking sda4 ... nope.
raid0: checking sdb1 ... nope.
raid0: zone->nb_dev: 1, size: 35278784
raid0: current zone offset: 195358336
raid0: done.
raid0 : md_size is 552042560 blocks.
raid0 : conf->hash_spacing is 85784192 blocks.
raid0 : nb_zone is 7.
raid0 : Allocating 56 bytes for hash.
md: ... autorun DONE.
VFS: Mounted root (reiser4 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding 489972k swap on /dev/sda2.  Priority:-1 extents:1 across:489972k
cdrom: open failed.
cdrom: open failed.
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC5] -> GSI 16 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:02:00.0 to 64

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
