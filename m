Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSGDRmB>; Thu, 4 Jul 2002 13:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGDRmA>; Thu, 4 Jul 2002 13:42:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20892 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313181AbSGDRl7>; Thu, 4 Jul 2002 13:41:59 -0400
Date: Thu, 4 Jul 2002 19:44:09 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 97
In-Reply-To: <20020704153313.F11601@flint.arm.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0207041940310.28459-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Jul 2002, Russell King wrote:

> On Thu, Jul 04, 2002 at 04:18:09PM +0200, Vojtech Pavlik wrote:
> > I think the best solution (for now) probably would be to supply the mode
> > map to the core IDE driver so that it can choose which modes (and
> > whether DMA) are available.
>
> I'm not really following your proposal, so I'll only say that as long as
> the chipset driver can tell the core what its capabilities are _after_
> running some chipset specific code, I'll be happy.

My tuning scheme satisfies your both demands, by ch->dma_base,
ch->autodma and ch->modes_map host informs generic code about its
capabilities.

>
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>

