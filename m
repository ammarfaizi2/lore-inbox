Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbRABTOP>; Tue, 2 Jan 2001 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRABTOI>; Tue, 2 Jan 2001 14:14:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131371AbRABTN5>; Tue, 2 Jan 2001 14:13:57 -0500
Date: Tue, 2 Jan 2001 10:42:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: David Woodhouse <dwmw2@infradead.org>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <20010102183825.3C0904185@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.10.10101021038410.25012-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Hakan Lennestal wrote:

> In message <12542.978456659@redhat.com>, David Woodhouse writes:
> > 
> > The IBM DTLA drives aren't in the hpt366 bad_ata66_4 list still.
> 
> I second this ! 
> Until the hpt-problem is solved (if it ever will be)
> we really need the IBM DTLA drives in the bad-list.
> This configuration (IBM DTLA disks on hpt3* controller) can't be
> that unusual ?

So why are the IBM drives picked on? I thought this was a hpt366 problem,
and possibly has only shown up with IBM drives so far.

It sounds like the proper fix would be to not enable ata66 by default.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
