Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTAJHYp>; Fri, 10 Jan 2003 02:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAJHYp>; Fri, 10 Jan 2003 02:24:45 -0500
Received: from dp.samba.org ([66.70.73.150]:748 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263313AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: Mike Stephens <mike.stephens@intel.com>, linux-kernel@vger.kernel.org,
       bjornw@axis.com, geert@linux-m68k.org, ralf@gnu.org, mkp@mkp.net,
       willy@debian.org, anton@samba.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting 
In-reply-to: Your message of "Mon, 06 Jan 2003 16:37:06 -0800."
             <15898.8498.519625.200668@napali.hpl.hp.com> 
Date: Wed, 08 Jan 2003 22:44:15 +1100
Message-Id: <20030110073328.C96122C2A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15898.8498.519625.200668@napali.hpl.hp.com> you write:
> >>>>> On Mon, 6 Jan 2003 14:41:04 -0800, Richard Henderson <rth@twiddle.net> 
said:
> 
>   Rich> On Mon, Jan 06, 2003 at 11:38:20AM -0800, David Mosberger
>   Rich> wrote:
> 
>   >> What about all the problems that Richard Henderson pointed out
>   >> with the original in-kernel module loader?  Were those solved?
> 
>   Rich> Yes.
> 
> OK, that's good.
> 
> Rusty, have you maintained the ia64 support of your in-kernel loader?

No, but I can update it next week when I'm back in the office.  Should
be trivial to do; I'll pass it by Mike Stephens if he's willing,
though, since he wrote the original code I cribbed off.

> I'd rather prefer the old (user-level loader) 

Really?  Because it already exists (and is maintained by someone else)
or for some other reason?

> or the new shared-object loader.

I thought about letting archs choose which one they wanted to use, but
it would really mess up the core code.  Of course, the transition
won't break userspace (kind of the whole point of the in-kernel module
loader).

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
