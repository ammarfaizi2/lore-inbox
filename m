Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQK0WTM>; Mon, 27 Nov 2000 17:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129514AbQK0WTC>; Mon, 27 Nov 2000 17:19:02 -0500
Received: from p3EE1EE54.dip.t-dialin.net ([62.225.238.84]:14600 "EHLO master")
        by vger.kernel.org with ESMTP id <S129231AbQK0WSu>;
        Mon, 27 Nov 2000 17:18:50 -0500
Date: Tue, 28 Nov 2000 00:01:26 +0100
From: Udo Held <udo@udoheld.de>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Hardware recognization error on Davicom 9102 with Tulip DS21140 driver
Message-ID: <20001128000125.A295@udoheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I didn't know which driver was the right one for my network card so I
just compiled all network-card drivers that where listed into my kernel
I tried it with test9 and test11. The DS21140 Tulip driver found my card
and crashes the system during boot up. My card is a Davicom 9102(?). It's
working fine with the right driver.

I give you the cutted output of lspci -m and lspci -vvv

lspci -m:

Device: 00:09.0
Class:  Ethernet controller
Vendor: Davicom Semiconductor, Inc.
Device: Ethernet 100/10 MBit
SVendor:        1282
SDevice:        9102
Rev:    31

lspci -vvv

00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
Subsystem: Unknown device 4554:434e
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (5000ns min, 10000ns max)
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at 6100 [size=256]
Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=256]
Expansion ROM at <unassigned> [disabled] [size=256K]
Capabilities: [50] Power Management version 1
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

I will send this mail to:

linux@vger.kernel.org
linux-net@vger.kernel.org
netdev@oss.sgi.com

I'm not in any of these lists anymore, because the digest service is
not offered anymore. :-(%

Questions are welcome.

Cheers,
Udo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
