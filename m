Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSLBNSQ>; Mon, 2 Dec 2002 08:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSLBNSQ>; Mon, 2 Dec 2002 08:18:16 -0500
Received: from bay1-f174.bay1.hotmail.com ([65.54.245.174]:15111 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S263135AbSLBNSO>;
	Mon, 2 Dec 2002 08:18:14 -0500
X-Originating-IP: [193.227.168.2]
From: "Elie =?ISO-8859-1?Q?Dadd=E9=22?= <ginolb89@hotmail.com>"@vax.home.local
To: linux-kernel@vger.kernel.org
Subject: bug in alim15x3(kernel 2.4.20)
Date: Mon, 02 Dec 2002 13:25:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F174ETQtU6Go6x000061ef@hotmail.com>
X-OriginalArrivalTime: 02 Dec 2002 13:25:38.0588 (UTC) FILETIME=[4DD1EDC0:01C29A06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey


00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1671 (rev 
02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [b0] AGP version 2.0
        Capabilities: [a4] Power Management version 1

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal 
decode])
        Flags: bus master, slow devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0100000-e01fffff
        Prefetchable memory behind bridge: e8000000-efffffff

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OH
CI])
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2

0:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown 
device 5451
(rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1400 [size=256]
        Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: medium devsel

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 0
        Capabilities: [a0] Power Management version 1
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
        Subsystem: QUANTA Computer Inc: Unknown device 9904
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1800 [size=256]
        Memory at e0002000 (32-bit, non-prefetchable) [size=256]

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

00:0b.0 Communication controller: ESS Technology ES2838/2839 SuperLink Modem 
(rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 0020
        Flags: fast devsel, IRQ 11
        I/O ports at 1010 [disabled] [size=16]
        Capabilities: [c0] Power Management version 2
0:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) 
(prog-if fa)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1000 [size=16]
        Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 
(prog-if 0
0 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Flags: stepping, fast Back2Back, 66Mhz, medium devsel, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 9000 [size=256]
        Memory at e0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2
####
/dev/hda:

Model=IC25N020ATCS04-0, FwRev=CA2OA71A, SerialNo=CSL206D9H1N0MA
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
BuffType=DualPortCache, BuffSize=1768kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39070080
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
AdvancedPM=yes: mode=0x80 (128)
Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5
#####
#here the kernel hang up when i use alim15x3  driver to enable dma
ManOwaRR kernel: hdc: timeout waiting for DMA
ManOwaRR kernel: hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
DataRequest }
ManOwaRR kernel: hdc: timeout waiting for DMA
ManOwaRR kernel: hdc: irq timeout: status=0xd0 { Busy }
ManOwaRR kernel: hdc: DMA disabled
ManOwaRR kernel: scsi : aborting command due to timeout : pid 15, scsi0, 
channel 0, id
0, lun 0 0x28 00 00 00 01 00 00 0$
ManOwaRR kernel: SCSI host 0 abort (pid 15) timed out - resetting\
ManOwaRR kernel: SCSI bus is being reset for host 0 channel 0.
ManOwaRR kernel: hdc: ATAPI reset complete
ManOwaRR -- MARK -

####
please  any idea how to fix this  and  enable dma
####




_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

