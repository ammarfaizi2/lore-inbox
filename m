Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272268AbTHSQPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHSQPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:15:15 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270995AbTHSQN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:28 -0400
Subject: Re: weird pcmcia problem
From: Sven Dowideit <svenud@ozemail.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20030819124547.B18205@flint.arm.linux.org.uk>
References: <87u18efpsc.fsf@mcs.anl.gov>
	 <20030819124547.B18205@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1061336141.593.5.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Aug 2003 09:35:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 21:45, Russell King wrote:
> - make/model of machine
IBM thinkpad t21
> - type of cardbus bridge (from lspci)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 50000000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20000000-203ff000 (prefetchable)
        Memory window 1: 20400000-207ff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00002400-000024ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 50100000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 20800000-20bff000 (prefetchable)
        Memory window 1: 20c00000-20fff000
        I/O window 0: 00002800-000028ff
        I/O window 1: 00002c00-00002cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

> - type of card (pcmcia or cardbus)

> - make/model of card
cisco aironet 340
> - full kernel dmesg (including yenta, card services messages)

> - cardmgr messages from system log

