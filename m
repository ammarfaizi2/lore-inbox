Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWBBWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWBBWCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWBBWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:02:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12560 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932330AbWBBWCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:02:17 -0500
Date: Thu, 2 Feb 2006 23:01:58 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Michael Loftis <mloftis@wgops.com>
Cc: David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202220158.GA11380@w.ods.org>
References: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:25:24AM -0700, Michael Loftis wrote:
> >o You think that 2.4.x isn't supporting enough new hardware,
> >  and yet you claim that adding new PCI ID:s is enough to add
> >  support for new hardware in most cases -- check
> 
> No I don't i said in MANY or atleast SOME.  further 2.4 is supposedly 
> DEAD anyway.

Because it does not get marketting people's attention anymore does not
mean it's dead, the opposite. They've done their work at selling it.
Now it runs at many places. Distro vendors like Red Hat will still
support it for a few years. Mission-critical systems have not moved to
2.6 yet ! Any I'm sure that David could give you amazing examples of
critical systems reliably running on 2.0 with hundreds of days of
uptime !

> I'm damned sick of the number of people who just *ATTACK* people who 
> contribute.  Constructive criticism is a form of contribution, feedback 
> if those words are too big for some to understand.  Because of the 
> development model changes there are projects not going to use Linux at 
> several companies that I work for contracting.  Because there is no way 
> that any single entity can look at 4+MB of compressed code changes and be 
> able to be even remotely sure that the kernel is going to work, and 
> that's been the case.  That combined with the rapid API changes, and 
> noone is developing a long lived stable kernel anymore means that 
> commercial support of this OS is being lost.  I'm in an odd situation 
> where because of NDAs and etc. I can not disclose any real details about 
> the commercial backers, but I'm sure they're not the only ones, and 
> probably much more important ones are getting frustrated.

In fact, I think you have chosen the wrong kernel base to start your
work. If you don't have the skills to follow large updates, you should
choose a stable kernel (stable code-wise). There is nothing ridiculous
in starting a project on 2.0, 2.2 or 2.4 right now. Given the past
experience of 2.4 and the time I can spend on kernel work, I would
not even consider basing anything on 2.6 before something like 2.6.20-25,
when it will hopefully settle down a bit. However, I have some 2.6 kernels
on very specific applications where I know I will not need to upgrade it,
eg: to make a bootloader using kexec, and on my home web server (hppa).

> Informational input can and often is as valuable as code.  Getting 
> someone to think of something they hadn't thought of can save that person 
> or the whole group lots of effors.
> 
> So, if you don't have anything USEFUL to retort back, shut up.  I'm 
> getting sick of hearing the people who can't contribute *ANYTHING NEW* to 
> the conversation and I'm in a very short mood.
> 
> The ... attitude and atmosphere here on LKML when someone brings up 
> something even slightly controversial is detrimental.  I know all of you 
> mean well.  But really.  If you're not contributing then you can stay 
> quiet just as well as the person you're complaining at.
> 
> This thread has been closed for what?   A week now?  I'm working on 
> trying to get the systems that are currently my big problems going, and 
> after that then I can focus more attention on the points I've brought up 
> earlier.  I'm only one person and just because I can't act immediately to 
> do something does not mean I won't.  Any of us who has an extremely busy 
> day job sure can understand that statement.

I understand what you feel but again, you did the wrong choice. You've
chosen 2.6 for various reasons, but you cannot expect its developers to
work the way that suits you best. Observe how kernels evolve and choose
another base to get less work. 2.4 can cost less than a few hours a month.
2.0 would need less than a few hours in a several years. Isn't it worth
spending more time porting your application to those kernels than you
currently spend trying to stay up to date with 2.6 ?

Willy

