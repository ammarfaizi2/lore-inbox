Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDXJgR>; Wed, 24 Apr 2002 05:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSDXJgQ>; Wed, 24 Apr 2002 05:36:16 -0400
Received: from Expansa.sns.it ([192.167.206.189]:41743 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310749AbSDXJgP>;
	Wed, 24 Apr 2002 05:36:15 -0400
Date: Wed, 24 Apr 2002 11:32:59 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "J.A. Magallon" <jamagallon@able.es>, <m.knoblauch@TeraPort.de>,
        Stephen Lord <lord@sgi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <E16zwWW-0002Mi-00@starship>
Message-ID: <Pine.LNX.4.44.0204241131160.24630-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It also depends on what XFS guys want to do.
They are probably confortable with this sort of interface so that XFS
works de facto like if it has to do with Irix.

To go to Linux VFS will be a lot of work for them I think.

On Tue, 23 Apr 2002, Daniel Phillips wrote:

> On Tuesday 23 April 2002 23:37, J.A. Magallon wrote:
> > On 2002.04.23 Martin Knoblauch wrote:
> > If XFS is so good (i do not doubt it), I see some issues (plz correct me
> > if I'm wrong...):
> >
> > - XFS needs substantial changes in the VFS layer to work
> > - This changes are good (or make xfs so good)
> > - *THE THING* to do is to integrate this changes in mainline tree VFS,
> >   so XFS will stop duplicating half the kernel code.
> >
> > Why those features are not merged ? Incompatibilities ? Licensing ?
> > Religious wars about some way of doing things ?
>
> No.  It's simply a matter of nobody having done the required analysis to
> find a really good way to reconcile XFS's way of doing things with
> mainline vfs.  This is time-consuming work that requires a good deal of
> skill, and right now there are many projects in the same category.
>
> My advice to anyone who wants to make it go faster?  Jump in and start
> doing the analysis (start with xfs/pagebuf.c).  If you are a company who
> wants it to go faster, try offering money.  Otherwise, it goes at its own
> speed, and this work will likely come up to the top of the pile later in
> the 2.5 cycle.
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

