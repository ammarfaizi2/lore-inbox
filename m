Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWEVTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWEVTNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEVTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:13:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12510 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751088AbWEVTNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:13:14 -0400
Date: Mon, 22 May 2006 21:12:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522191230.GE2979@elf.ucw.cz>
References: <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net> <20060522184003.GD2979@elf.ucw.cz> <44720ACB.7040808@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44720ACB.7040808@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> Well, fix emacs then. We definitely do not want 10000 settable knobs
> >>> that randomly break things. OTOH per-architecture different randomness
> >>> seems like good idea. And if Oracle breaks, fix it.
> >> Fix this, fix that.  In due time perhaps.  I'm pretty sure Linus isn't
> >> going to break anything, esp. since his mail client breaks too.
> > 
> > Good. So fix emacs/oracle/pine, and year or so and some time after it
> > is fixed, we can change kernel defaults. That's still less bad than
> > having
> > 
> > [ ] Break emacs
> > 
> > in kernel config.
> 
> Nobody is going to fix emacs/oracle/pine, they don't have to.  Nothing
> is making them.  The kernel will wait for them so who cares.

No, _you_ have to fix emacs/oracle/pine. You claimed your patch is
interesting for secure distros, so you obviously have manpower for
that, right?

> >> Why should it NOT be configurable anyway?  If you don't configure it,
> >> then it behaves just like it would if it wasn't configurable at all.
> >> This is called "having sane defaults."
> > 
> > Because if it is configurable, someone _will_ configure it wrong, and
> > then ask us why it does not work.
> 
> Oh big deal.  People configure out ide drivers and ask why their kernel
> doesn't boot all the time.  Distro maintainers do most of the work.

As you may have noticed, I'm at receiving end of those bug
reports. And what you propose is actually *worse* than IDE, because at
least you get relatively clear error message when misconfiguring IDE.

> > And if it is configurable, applications will not get fixed for
> > basically forever.
> 
> FUD.  If it's not configurable, applications will not get fixed for
> basically forever, and nobody will put the breaking code into mainline.
>  Linus is NOT giving 256M/256M randomization on mainline as default
> ever.

For x86-64... why not?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
