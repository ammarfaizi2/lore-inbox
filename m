Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUDAQVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUDAQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:20:29 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:6604 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S262956AbUDAQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:20:03 -0500
Date: Thu, 01 Apr 2004 10:19:53 -0600
From: Matt Gulick <gulickconsulting@direcway.com>
Subject: Re: TI Firewire controller ?
In-reply-to: <200403312354.17104.gene.heskett@verizon.net>
To: gene.heskett@verizon.net
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Reply-to: gulickconsulting@direcway.com
Message-id: <1080836393.5300.20.camel@localhost.localdomain>
Organization: Gulick Consulting
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <200403312354.17104.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 22:54, Gene Heskett wrote:
> Greetings;
> 
> I bought, 3 or so years back, a 1394 controller, thinking
> that maybe it had a chance to become a standard, like USB
> is now.
> 
> lspci -vv reports this:
> 00:0b.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller (rev 01) (prog-if 10 [OHCI])
>         Subsystem: Texas Instruments: Unknown device 8010
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (750ns min, 1000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e3007000 (32-bit, non-prefetchable) [size=2K]
>         Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> Is there any chance that this card can actually be used with modern devices?
> Or should I bin it and save the couple of watts its burning?

There should probably be a mail list for 1394 (and USB for that matter)
as this is the kernel mail list.

I will respond to your query though.

If the information is correct and the card is OHCI (not the same as USB
OHCI), then it should work just fine.  OHCI is a standard interface to
the 1394 link chip.  If you plug that card into a Mac or Windose box, it
would be recognized as such and the drivers loaded. The same holds true
for Linux.

Matt

----------------------------------------
Matt Gulick
Sr. Staff Engineer
Adaptec, Inc.
gulickconsulting@direcway.com
matt_gulick@adaptec.com
(715) 426-0884


