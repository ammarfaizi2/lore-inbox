Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVAQPXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVAQPXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVAQPXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:23:45 -0500
Received: from gprs215-94.eurotel.cz ([160.218.215.94]:16871 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261592AbVAQPXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:23:44 -0500
Date: Mon, 17 Jan 2005 16:22:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050117152230.GA1379@elf.ucw.cz>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501152243.21483.rjw@sisk.pl> <20050116215145.GF2757@elf.ucw.cz> <200501171553.02565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501171553.02565.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > > > > > or an alternative?
> > > > > > 
> > > > > 
> > > > > Ok, Here is a new patch with x86_64 support, But I have not machine, So
> > > > > Need someone test it. 
> > > > 
> > > > OK, I will.
> > > 
> > > I have tested it and it works well.  For me, it speeds up the resume process significantly,
> > > so I vote for including it into -mm (at least ;-)).  I'll be testing it further to see if it really
> > > solves my "out of memory" problems on resume.
> > 
> > Try Lukas's patch, it should provide equivalent speedups.
> 
> It does.  Still, I don't think it'll solve memory allocation problems on resume,
> and the hugang's patch has such a potential.

Yes, but it is also small/nonintrusive enough to be merged now.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
