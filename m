Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131384AbQLFOBd>; Wed, 6 Dec 2000 09:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130560AbQLFOBX>; Wed, 6 Dec 2000 09:01:23 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:42248 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S131384AbQLFOBE>; Wed, 6 Dec 2000 09:01:04 -0500
Message-ID: <3A2E3F1C.3050608@megapathdsl.net>
Date: Wed, 06 Dec 2000 05:29:00 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
In-Reply-To: <Pine.LNX.4.21.0012061334500.5492-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:

<snip>

> The way I see it, 2.4.0-test12-pre6 is just a much longer name for 2.4.0.  
> Keep going like this and we may end up calling you Linus "Santa" Torvalds!  
> It has a nice ring to it, don't you think?  :-)  Or should that be *-<:-)

I appreciate your enthusiasm, but I'd love it if I could use
both my 3c575 and Belkin BusPort Mobile Cardbus cards
simultaneously without them thrashing over IRQ11.  This is
still happening in test12-pre6 and seems to me to indicate
that all is not well somewhere in IRQ management land.

Just call me Scrooge.  :-)  On the other hand, maybe
I wasn't nice this year and am getting coal for
<insert holiday of preference here>.


00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(AGP disabled) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 64 set
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:02.0 VGA compatible controller: Neomagic Corporation NM2160 
[MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 16 min, 255 max, 128 set
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

00:04.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168 set, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at fcf0 [size=16]

(Ignore the follow USB host-controller entry.  It's the built-in,
not the Cardbus USB host-controller).

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at fcc0 [disabled] [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

(Here are the two conflicting cards)

01:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 
LAN CardBus (rev 01)
	Subsystem: 3Com Corporation: Unknown device 5b57
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 10 min, 5 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10400000 [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc.: Unknown device c861
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 11000000 (32-bit, non-prefetchable) [size=4K]


Ho ho ho,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
