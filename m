Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWEVTlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWEVTlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWEVTlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:41:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62153 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751157AbWEVTlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:41:51 -0400
Date: Mon, 22 May 2006 21:41:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522194108.GF2979@elf.ucw.cz>
References: <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net> <20060522184003.GD2979@elf.ucw.cz> <44720ACB.7040808@comcast.net> <20060522191230.GE2979@elf.ucw.cz> <447210B3.10401@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447210B3.10401@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> Good. So fix emacs/oracle/pine, and year or so and some time after it
> >>> is fixed, we can change kernel defaults. That's still less bad than
> >>> having
> >>>
> >>> [ ] Break emacs
> >>>
> >>> in kernel config.
> >> Nobody is going to fix emacs/oracle/pine, they don't have to.  Nothing
> >> is making them.  The kernel will wait for them so who cares.
> > 
> > No, _you_ have to fix emacs/oracle/pine. You claimed your patch is
> > interesting for secure distros, so you obviously have manpower for
> > that, right?
> 
> RHAT probably fixed Emacs already since it broke on them.  Adamantix and
> Hardened Gentoo are most likely to put manpower into things like pine..
> they put a lot of work into removing textrels on i386.
> 
> Oracle we can't do anything about.  It's commercial.  If we break it,
> they will recommend running it on Solaris or Windows 2003.

Well, if RedHat ships randomization, it will make Oracle fix it quite
quickly :-).

> > As you may have noticed, I'm at receiving end of those bug
> > reports. And what you propose is actually *worse* than IDE, because at
> > least you get relatively clear error message when misconfiguring IDE.
> 
> Yes but when you misconfigure IDE the system doesn't boot.  When you
> turn up randomization too high, everything works but 1 or 2
> programs.

Yes, you'll very quickly realize you misconfigured IDE... while stack
randomization is going to break 2 apps and you'll not know why.

> > For x86-64... why not?
> 
> On x86-64 he may, if you can convince him it's useful (asserting that

I do not care much about randomization, sorry. I see it may be useful
on x86-64, but I do not think configurability helps. Sorry.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
