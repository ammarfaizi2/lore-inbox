Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSJZItz>; Sat, 26 Oct 2002 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJZItz>; Sat, 26 Oct 2002 04:49:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:59494 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261996AbSJZItx>;
	Sat, 26 Oct 2002 04:49:53 -0400
Date: Sat, 26 Oct 2002 10:56:11 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available
Message-Id: <20021026105611.3d6a540c.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, Hi Dominik

Why is cpufreq on my laptop not available? I know it works with window$.
My laptop has an Intel P3 speedstep cpu which supports 600Mhz and 500Mhz clock frequency. Will it be supported in the future?

Some additional infos:

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 595.577
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1189.47


lspci -v
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Subsystem: Sony Corporation: Unknown device 806f
        Flags: bus master, medium devsel, latency 64
        Memory at 40000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fe800000-fecfffff
        Prefetchable memory behind bridge: fd000000-fdffffff

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Flags: medium devsel, IRQ 9

00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 8071
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at fedf7000 (32-bit, non-prefetchable) [size=2K]
        Memory at fedf7c00 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
        Subsystem: Sony Corporation: Unknown device 8072
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
        I/O ports at fcc0 [size=64]
        I/O ports at fc8c [size=4]
        Capabilities: [50] Power Management version 1

00:0a.0 Communication controller: Conexant HSF 56k Data/Fax Modem (Mob WorldW SmartDAA) (rev 01)
        Subsystem: Sony Corporation Modem
        Flags: medium devsel, IRQ 9
        Memory at fede0000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at fc78 [size=8]
        Capabilities: [40] Power Management version 2

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
        Subsystem: Sony Corporation: Unknown device 8073
        Flags: bus master, medium devsel, latency 168, IRQ 9
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
        Subsystem: Sony Corporation: Unknown device 8073
        Flags: bus master, medium devsel, latency 168, IRQ 9
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV+] (rev 30) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80a2
        Flags: bus master, fast Back2Back, medium devsel, latency 128, IRQ 9
        Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1

06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 4800 [size=256]
        Memory at 11000000 (32-bit, non-prefetchable) [size=512]
        Capabilities: [50] Power Management version 2

Thank you

Kind regards

Marc
