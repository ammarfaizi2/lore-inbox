Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTAANV3>; Wed, 1 Jan 2003 08:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbTAANV3>; Wed, 1 Jan 2003 08:21:29 -0500
Received: from tomts12.bellnexxia.net ([209.226.175.56]:58780 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267222AbTAANV2>; Wed, 1 Jan 2003 08:21:28 -0500
Date: Wed, 1 Jan 2003 08:28:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
In-Reply-To: <20030101131925.GA14184@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301010824510.11858-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> > [torvalds@transmeta.com]
> > 
> > On Tue, 31 Dec 2002, Tomas Szepe wrote:
> > > 
> > > The attached unidiff creates a parent entry for all gigabit ethernet
> > > interfaces, making the submenu consistent with that of 10/100.  Suggested
> > > by Robert P. J. Day.  Trivial patch against 2.5-bkcurrent.
> > 
> > Hmm.. Wouldn't it be nicer to instead of :
> > [snip]
> > have
> > [snip]
> > so that the you don't even see the things if you don't select for them?
> > Untested, but it would seem to be the more natural approach..
> 
> Oh yes, definitely, I just wanted to be consistent with 10/100.
> So here comes gigabit the way you suggested (tested, seems to work
> fine), next I'll be sending a fix for 10/100, then see if there are
> any more menus like that left in the current config setup.
> 
> -- 
> Tomas Szepe <szepe@pinerecords.com>
> 
> diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
> --- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
> +++ b/drivers/net/Kconfig	2003-01-01 14:10:09.000000000 +0100

... <snip> ...

perhaps a trivial question:  the first patch you sent out was against
the Config.in file, which made perfect sense to me.  this patch
is against the "Kconfig" file.  i'm not sure what that means,
i see no such file.  (then again, being a kernel newbie, i probably
just don't understand some of the fundamentals.)

is "Kconfig" a precursor to what will eventually become the
Config.in file?

rday

