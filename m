Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJPSGB>; Tue, 16 Oct 2001 14:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276594AbRJPSFv>; Tue, 16 Oct 2001 14:05:51 -0400
Received: from [209.195.52.30] ([209.195.52.30]:35076 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S276591AbRJPSFm>;
	Tue, 16 Oct 2001 14:05:42 -0400
From: David Lang <david.lang@digitalinsight.com>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 16 Oct 2001 09:44:24 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <E7405EE40489D411B30F00508BF38F8D049677E2@wlvexc01.diginsite.com>
Message-ID: <Pine.LNX.4.40.0110160932370.6108-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the previous non-Rik VM kernel (other then the current linus tree) is the
2.2 kernels, and they are lacking a LOT of features that are in 2.4

it's not a case of wanting to run 2.4.latest on production, it's a matter
of wanting to run 2.4.anything on production. currently this is a serious
problem to do becouse the VM system has not been stable and predictable
enough to be trusted. there have been to many cases of people putting 2.4
on a production system and it slowing to a crawl when the real production
load hits.

when 2.4 works it is FAR better then 2.2 and it has features not available
on 2.2, but with the Rik VM (versions that were in the linus kernels up
through 2.4.9) it has not reliably worked. running 2.4 is not supposed to
be bleading edge, it's supposed to be the stable kernel series (although
you do have to wait a few days after a kernel is released to avoid paper
bag bugs :-)

if we want a kernel series that should not be used in production servers
we need to get 2.4 stable enough to be used there and then we can open the
2.5 series

David Lang

On Tue, 16 Oct 2001, safemode wrote:
<SNIP>
> People who use the latest 2.4.x kernel aren't running critical servers,
> rebooting back to their previous non-Rik vm kernel wont be much of an issue.
> It wont "break" anything, rather just be better or worse performance wise.
> If you can afford to reboot to upgrade to the latest 2.4.x, you can afford to
> reboot to move back to your backup kernel.
> Makeing a standard way of testing "real world" things is bad.  Real world
> tests are unlimited and thus can be very hard to recreate but with this way
> you can actually see the "special" cases that become more apparent when more
> users use the kernel much earlier.  This would be the same as your statement
> above about releasing a bad kernel onto the public as a stable kernel.  If
> you tune to a standard real world test that some people come up with, then
> you are no longer tuning for the real world since you lose that
> unpredictability that real users can enter into the equation.
>
> Like i said before, tests are a lose lose situation,  if you dont do them you
> release code unto the world that is well, untested.  If you do them, then
> you're tuning for your test and not the real world and you have people saying
> that the test is invalid or biased.  Well, so far not using a test is out of
> the question and Both VM's certainly get their round of testing, the
> contraversy with that is what tests are important in the real world.  Figure
> that out and maybe you'll get somewhere with figuring out which VM is better
> for everyone.  If you manage to convince everyone that those tests are
> important to the real world, you're probably writing the code and/or a
> god-like being.
>
