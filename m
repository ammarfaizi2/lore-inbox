Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946111AbWKKTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946111AbWKKTPS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946270AbWKKTPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 14:15:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60689 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946111AbWKKTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 14:15:16 -0500
Date: Sat, 11 Nov 2006 20:15:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061111191519.GE25057@stusta.de>
References: <200611090757.48744.a1426z@gawab.com> <20061109090502.4d5cd8ef@freekitty> <200611101852.14715.a1426z@gawab.com> <9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com> <4554AC12.6040407@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4554AC12.6040407@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 08:42:58AM -0800, Stephen Hemminger wrote:
>...
>  * Old bugs die, the bugzilla database needs a 6mo prune out.

That's not that much of a problem.

There is me and there are some other people who sometimes go through 
older bugs asking submitters whether the issue is still present in a 
recent kernel.

And if it is not or the submitter doesn't answer the bug gets closed a 
few weeks later.

The problem with this approach is what to do when the bug is still 
present - it's quite unfair to ask a submitter whether a bug is still 
present, but having no way to help the submitter if he confirms it's 
still present.

A positive example is e.g. sparc: davem doesn't use Bugzilla, but when I 
forward bugs to him from Bugzilla I know that there will be an answer.

But for other subsystems like e.g. ext3 I don't know about anyone who 
will answer every time I forward a bug that is still present in the 
latest kernel.

>  * Bugzilla.kernel.org is underutilized and is only a small sample of the
>    real problems. Not sure if it is a training, user, behaviour issue or
>    just that bugzilla is crap.

At least one positive thing about Bugzilla is that it shows how bad our 
bug handling is - bug reports noone took care of are visible...

>  * Vendor bugs (that could be fixed) aren't forwarded to lkml or bugzilla

We do already get more bug reports than we can handle.

As an example, until recently people were spreading the fairy tale noone 
would test -rc kernels. So I started a list of reported regressions by 
people who did test the -rc kernels, and this shows that we are even far 
away from handling recent regressions within one or two weeks - and the 
situation with other bugs looks much worse.

>  * LKML is an overloaded communication channel, do we need:
>      linux-bugs@vger.kernel.org ?

The problem is not how to communicate bugs - the problem is who will 
look after the bugs.

As an example, Andrew is already doing a great job in forwarding bugs 
from Bugzilla and linux-kernel to maintainers. It's not that maintainers 
miss bugs because they don't see them.

>   * Developers can't get (or afford to buy) the new hardware that causes
>      a lot of the pain. Just look at the number of bug reports due to new
>      flavors of motherboards, chipsets, etc. I spent 3mo on a bug that took
>      one day to fix once I got the hardware.

If only this was the only problem...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

