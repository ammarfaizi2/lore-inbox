Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWBBSZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWBBSZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBBSZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:25:40 -0500
Received: from free.wgops.com ([69.51.116.66]:12559 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751163AbWBBSZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:25:39 -0500
Date: Thu, 02 Feb 2006 11:25:24 -0700
From: Michael Loftis <mloftis@wgops.com>
To: David Weinehall <tao@acc.umu.se>
Cc: Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
In-Reply-To: <20060202121653.GI20484@vasa.acc.umu.se>
References: <43D10FF8.8090805@superbug.co.uk>
 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
 <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
 <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
 <20060120200051.GA12610@flint.arm.linux.org.uk>
 <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com>
 <87slrio9wd.fsf@asmodeus.mcnaught.org>
 <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com>
 <20060202121653.GI20484@vasa.acc.umu.se>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On February 2, 2006 1:16:53 PM +0100 David Weinehall <tao@acc.umu.se> 
wrote:

> [snip]
>
> So, let's summarise what you've been saying in this thread so far:
>
> o You want advance warning of API changes, but when you get them
>   (devfs, for instance), you ignore them and complain anyway -- check

The problem is that there's no more stable kernel first, and secondly that 
there's not much if any pointers abotu the change.  People complained I 
didn't have specific problems to solve, I don't CARE abotu any specific 
problems.  I could hardly give a rats ass about devfs.  It's the whole new 
development model that's the problem, and will only get worse for the types 
of companies who I work with who normally right now support Linux 
development.  I only brought up devfs because certain members of the 
community can't see past bootstrings to the bigger issue.

>
> o You want security fixes and only minor other fixes (done magically
>   by someone else as you're not willing to pay for it, nor are you
>   willing to help yourself), for at least 6 months, but you ignore
>   the existance of the 2.6.x.y kernel series, which does exactly
>   that -- check

There's noone out there that does that, I'd LOVE to be able to pay for it 
and not have to do it myself.  RedHat kernels don't work on most of our 
gear, and RH, up to and including fedora core, and centos have some 'great' 
issues, like the listener processes for Apache and MySQL using up *ALL* of 
the system CPU when *NOTHING* is happening.  We've tried to track it down, 
it's gotten to where we just don't care and we just don't deploy RedHat 
anymore.  SuSE's kernels suffer the same problem of too many patches I 
mentioned before for totally unrelated, non-security things.

Further, I'm not the only one.  I'm the only one who has enough asbestos to 
jump onto LKML and say it because they all know that it's completely 
hostile in here when someone brings up something that looks like a major 
issue.

> o You think that 2.4.x isn't supporting enough new hardware,
>   and yet you claim that adding new PCI ID:s is enough to add
>   support for new hardware in most cases -- check

No I don't i said in MANY or atleast SOME.  further 2.4 is supposedly DEAD 
anyway.

> o You're going on and on about API breakage between kernel and
>   userspace, yet the only example you keep repeating is devfs -- check
>
> So far, I'd say you're just trolling.  Please calm down, *breathe*,
> and start reading what people actually respond to you, think it
> through, and consider if maybe, just maybe, there might be more sense
> in their opinions than in yours.  And maybe, just maybe, people that
> spend a lot of their spare time (or work time, for that matter) to
> give you for free (and FREE) the best kernel there is, deserve a
> bit more than your whining.

And it's only been the best because there's been a way for people to sue 
it, get security patches even teh occasional new hardware support when it's 
not disruptive.  Now that entire development model has changed into 
something that noone uses because it doesn't' work for a project needing a 
stable tree, such as a kernel.  It seems most people here just can't 
understand how it can become a problem unfortunately because they can't 
really see the big picture.  Everyone wants to take one little piece and go 
hey hey see that's not a problem and then self satisfied at their attacking 
and dismissal think they've solved the problem.  This is not a single 
problem issue.

>
> Or in short:
>
> "Don't complain, contribute!"

I'm damned sick of the number of people who just *ATTACK* people who 
contribute.  Constructive criticism is a form of contribution, feedback if 
those words are too big for some to understand.  Because of the development 
model changes there are projects not going to use Linux at several 
companies that I work for contracting.  Because there is no way that any 
single entity can look at 4+MB of compressed code changes and be able to be 
even remotely sure that the kernel is going to work, and that's been the 
case.  That combined with the rapid API changes, and noone is developing a 
long lived stable kernel anymore means that commercial support of this OS 
is being lost.  I'm in an odd situation where because of NDAs and etc. I 
can not disclose any real details about the commercial backers, but I'm 
sure they're not the only ones, and probably much more important ones are 
getting frustrated.

Informational input can and often is as valuable as code.  Getting someone 
to think of something they hadn't thought of can save that person or the 
whole group lots of effors.

So, if you don't have anything USEFUL to retort back, shut up.  I'm getting 
sick of hearing the people who can't contribute *ANYTHING NEW* to the 
conversation and I'm in a very short mood.

The ... attitude and atmosphere here on LKML when someone brings up 
something even slightly controversial is detrimental.  I know all of you 
mean well.  But really.  If you're not contributing then you can stay quiet 
just as well as the person you're complaining at.

This thread has been closed for what?   A week now?  I'm working on trying 
to get the systems that are currently my big problems going, and after that 
then I can focus more attention on the points I've brought up earlier.  I'm 
only one person and just because I can't act immediately to do something 
does not mean I won't.  Any of us who has an extremely busy day job sure 
can understand that statement.




