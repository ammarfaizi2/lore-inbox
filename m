Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130562AbRAQVQx>; Wed, 17 Jan 2001 16:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbRAQVQn>; Wed, 17 Jan 2001 16:16:43 -0500
Received: from anime.net ([63.172.78.150]:3083 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130562AbRAQVQc>;
	Wed, 17 Jan 2001 16:16:32 -0500
Date: Wed, 17 Jan 2001 13:17:41 -0800 (PST)
From: Dan Hollis <goemon@sasami.anime.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Martin Mares <mj@suse.cz>, Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
In-Reply-To: <Pine.GSO.3.96.1010117122300.22695B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.30.0101171314380.18147-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Maciej W. Rozycki wrote:
> On Wed, 17 Jan 2001, Martin Mares wrote:
> > I don't have the ServerWorks chipset documentation at hand, but I think your
> > patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers
> > 0x44 and 0x45 are probably ID's of two primary buses and the code should scan
> > both of them, but not the space between them.
>  Does anyone beside the manufacturer have these docs at all?  Last time I
> contacted them, they required an NDA, even though they weren't actually
> Linux-hostile.

They require not only an NDA, but that you also do all development on-site
at their santa clara HQ under their direct supervision.

The only people who have ever got info out of serverworks are the lm78
guys and (i think) andre hedrick.

What magic incantations they chanted, or which mafia thugs they hired to
manage this, I don't know...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
