Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267821AbUBRStj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUBRStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:49:39 -0500
Received: from gprs156-45.eurotel.cz ([160.218.156.45]:30337 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267821AbUBRSte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:49:34 -0500
Date: Wed, 18 Feb 2004 19:48:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       linux-kernel@vger.kernel.org,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>, George Anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040218184832.GB321@elf.ucw.cz>
References: <20040217220236.GA16881@smtp.west.cox.net> <200402181026.29813.amitkale@emsyssoft.com> <20040218125647.GA4706@atrey.karlin.mff.cuni.cz> <200402181845.01628.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402181845.01628.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > The following is my next attempt at a different KGDB stub
> > > > > > for your tree
> > > > >
> > > > > Is this the patch which everyone agrees on?
> > > >
> > > > It is based on Amit's version, so I think answer is "yes". I certainly
> > > > like this one.
> > >
> > > I don't agree. I did a few more cleanups after Andi expressed concerns
> > > over globals kgdb_memerr and debugger_memerr_expected.
> > >
> > > I liked Pavel's approach. Let's first get a minimal kgdb stub into
> > > mainline kernel. Even this much is going to involve some effort. We can
> > > merge other features later.
> > >
> > > Let's create a cvs tree at kgdb.sourceforge.net for kgdb components to be
> > > pushed int mainline kernel. This split is to keep current kgdb
> > > unaffected. People who are already using it won't be affected.
> >
> > I do not think we want separate CVS tree.
> >
> > What about simply splitting core.patch into core-lite.patch and
> > core.patch, maybe do the same with i386 patch, and be done with that?
> > [We do not have enough people for a fork, I think].
> 
> Agreed. Let's create core-lite.patch and i386-lite.patch
> It makes it somewhat difficult to maintain them, but should be easier than 
> maintaining a separate CVS tree.

There's tool called quilt that is pretty good at exactly this. (It is
small enough to do by hand, but ...)

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
