Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUBRM4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUBRM4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:56:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18093 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266704AbUBRM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:56:52 -0500
Date: Wed, 18 Feb 2004 13:56:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>, George Anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040218125647.GA4706@atrey.karlin.mff.cuni.cz>
References: <20040217220236.GA16881@smtp.west.cox.net> <20040217143628.0aafd018.akpm@osdl.org> <20040217225241.GC666@elf.ucw.cz> <200402181026.29813.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402181026.29813.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The following is my next attempt at a different KGDB stub
> > > > for your tree
> > >
> > > Is this the patch which everyone agrees on?
> >
> > It is based on Amit's version, so I think answer is "yes". I certainly
> > like this one.
> 
> I don't agree. I did a few more cleanups after Andi expressed concerns over 
> globals kgdb_memerr and debugger_memerr_expected.
> 
> I liked Pavel's approach. Let's first get a minimal kgdb stub into mainline 
> kernel. Even this much is going to involve some effort. We can merge other 
> features later.
> 
> Let's create a cvs tree at kgdb.sourceforge.net for kgdb components to be 
> pushed int mainline kernel. This split is to keep current kgdb unaffected. 
> People who are already using it won't be affected.

I do not think we want separate CVS tree.

What about simply splitting core.patch into core-lite.patch and
core.patch, maybe do the same with i386 patch, and be done with that?
[We do not have enough people for a fork, I think].

Hopefully soon after that *-lite is merged, so it disappears, and
stuff is easy once again.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
