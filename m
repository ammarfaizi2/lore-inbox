Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUG0WJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUG0WJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266658AbUG0WJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:09:23 -0400
Received: from mail.tmr.com ([216.238.38.203]:12556 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266657AbUG0WJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:09:19 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: New dev model (was [PATCH] delete devfs)
Date: Tue, 27 Jul 2004 18:12:14 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6jg2$if1$1@gatekeeper.tmr.com>
References: <20040722193337.GE19329@fs.tum.de><40FEEEBC.7080104@quark.didntduck.org> <20040722152839.019a0ca0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090965826 18913 192.168.12.100 (27 Jul 2004 22:03:46 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040722152839.019a0ca0.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> The direction presented to us now is having smaller, more continuous,
> steps in the head end, over having fewer larger, more disruptive steps. 
> Do we do all the incompatible changes in a big chunk, once every couple
> of years, or do we do them one a week, ongoing.

Do I read that correctly? You are suggesting doing big disruptive 
changes every week? I know what you mean, but this is just what many 
people don't want, being told that they have to give up cyrptoloop or 
devfs to get a better scheduler.
> 
> Now, I repeat, this is at the head end.  End users who want stability
> aren't feeding directly off kernel.org anyway.

Having been bitten by vendor kernels repeatedly, I would say that some 
are and some aren't. And people who want minor new features like a 
device driver or better scheduler don't want to rebuild a system from a 
base install just to get there. It's one thing to get all the new 
features of a 2.N to 2.{N+2} conversion, but it isn't worth a major 
reconfig to get there.
> 
> The affect downstream on real users is this.  If the head end operates
> in big chunky style, then as this big change flows downstream, it makes
> transitions for distros, service providers and middlemen more costly and
> difficult, creating expenses that must be passed on to the end user.

Do you suggest that many disruptive changes are less expensive than one 
every few years? There should be something between RHEL "stable for five 
years" and FC2 "run up2date on the hour" models. The stable series has 
been that in the past, and dropping any disruptive change into the 
stable series seems to belie the term stable.
> 
> Yes - damming up the flow of changes creates stability.  But if you're a
> middleman, you don't need Linus to choose where to build the dam, and
> when to open the flood gates.  It's more efficient for you to choose for
> yourself when to do that damming, based on your particular resources and
> customer needs, rather than have to deal with hundred year floods and
> draughts imposed on you by Zeus.

So everyman becomes his own vendor, if you want a minor feature you have 
to patch it into an old kernel which still works for you? This is a 
major change from the way stable vs. development has ever worked... It's 
not the pace of little things which troubles me, it's Reiser versions, 
and vanishing cryptoloop and devfs, and things like that which require 
major changes in a system.
> 
> The end user always gets their stability, if only because they won't
> upgrade a system that is "working".
> 
> And every change at the head end is disruptive for some poor slob.
> The only perfectly compatible change is no change at all.  We delude
> ourselves if we think we can separate the "safe" fixes and additions
> from the "unsafe" incompatible changes.  Better that we should expend
> some energy on smoothing out and minimizing the cost of change to those
> downstream from us.  This needs to be done the old-fashioned way, one
> change at a time.
> 
> The question is whether we impose, on all those downstream from us,
> occasional hundred year floods, or do we provide a steady stream, and
> let them build their own little beaver dams, as suits their various and
> diverse needs and business cycles.

No matter how you spin it, you are still talking disruptive change over 
and over vs. an occasional major rethink.
> 
> The great lesson of capitalism over communism is that a thousand free
> workers and investors, each optimizing their own little plot or
> portfolio, beats a single centrally imposed five year plan, even if the
> man pulling the levers is a genius such as Linus or Lenin (sorry, Linus,
> couldn't resist ...).
> 
Of course making the end users far more dependent on vendors didn't 
enter into this at all...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
