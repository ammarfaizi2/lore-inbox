Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131540AbRABURa>; Tue, 2 Jan 2001 15:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131651AbRABURL>; Tue, 2 Jan 2001 15:17:11 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:38666
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131561AbRABURG>; Tue, 2 Jan 2001 15:17:06 -0500
Date: Tue, 2 Jan 2001 11:44:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hakan Lennestal <hakanl@cdt.luth.se>,
        David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.10.10101021038410.25012-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101021139450.26680-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Tue, 2 Jan 2001, Hakan Lennestal wrote:
> 
> > In message <12542.978456659@redhat.com>, David Woodhouse writes:
> > > 
> > > The IBM DTLA drives aren't in the hpt366 bad_ata66_4 list still.
> > 
> > I second this ! 
> > Until the hpt-problem is solved (if it ever will be)
> > we really need the IBM DTLA drives in the bad-list.
> > This configuration (IBM DTLA disks on hpt3* controller) can't be
> > that unusual ?
> 
> So why are the IBM drives picked on? I thought this was a hpt366 problem,
> and possibly has only shown up with IBM drives so far.
> 
> It sounds like the proper fix would be to not enable ata66 by default.
> 

LT,

This is one of the evolution timing issues that both the drive guys and
the chipset guys point fingers, while both attempt to fix the problem in
their BIOS/Diskware.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
