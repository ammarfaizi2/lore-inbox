Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTLFFOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTLFFOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:14:48 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:32718 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264949AbTLFFOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:14:42 -0500
Date: Fri, 5 Dec 2003 21:14:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206051433.GA25766@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <Pine.LNX.4.58.0312051949210.2092@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312051949210.2092@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 08:39:03PM -0800, Linus Torvalds wrote:
> But if somebody else writes a piece of code for Linux, we now have a
> situation where Linux is comprised of two pieces (a) the original work
> (for simplicity, let's say it's copyright by person A) and (b) the new
> work (copyright person B).
> 
> Now, (a+b) is the new work (joint copyrighted by A+B), and if the original
> code (a) required the GPL, then (a+b) requires the GPL too due to the
> "viral" nature of the GPL. You are right so far.
> 
> BUT THAT DOES NOT MEAN THAT PERSON B LOST _ANY_ RIGTHS WRT WORK (b).

I never said that person B lost any rights at all.

> In particular, person B can still license work (b) under any other
> license. He cannot license (a+b) under any other license, since that is
> required by the GPL to continue to be GPL, but he _can_ license the code
> he retains full copyright to.

Yeah, I know this.  

> The code remains copyright to person B, and as long as it so remains
> (which it does forever, unless B actively gives it away or the US congress
> finally stops playing its silly games and lets copyrights expire
> eventually), person B can re-license his code any which way he pleases.
> 
> Ask a lawyer. Any good lawyer.

I have, I know all this.

> But my claim is that if (b) is compiled into a Linux kernel module, then
> it _is_ part of (a+b) whether (a) is physically present or not. So if
> company B compiles their code (owned 100% by them) into a binary linux
> kernel module, that _does_ make it a part of (a+b). "Physical location"
> has nothing to do with derived works - and the fact that compaby B
> compiled code (b) for Linux and then only distributes the (broken up) part
> of (a+b) doesn't mean that (a+b) didn't exist.

I know all this as well.

The issue is "what is a derived work", your claim is "pretty much anything
combined with the original work" and I don't agree and neither does the GPL.

    These requirements apply to the modified work as a whole.  If
    identifiable sections of that work are not derived from the Program,
    and can be reasonably considered independent and separate works in
    themselves, then this License, and its terms, do not apply to those
    sections when you distribute them as separate works.

A loadable driver doesn't modify the kernel.  I understand that the
license says "when you distribute them as separate works" and I think
that the courts will view providing a driver as just that.

Your view that "(b) is compiled into a Linux kernel module, then it
_is_ part of (a+b) whether (a) is physically present or not." is not
something that I have managed to seen in any caselaw.  On the other hand,
it is widely held that you can't force licenses across an API and it's
perfectly reasonable to see the loadable module interface as an API.

I think this is something that is going to get resolved by the courts,
not you or I.  And whether it get solved "correctly" is more a matter
of money than of correctness, unfortunately.  I stand behind my earlier
point that your thinking, Linus, could well bite you on this one.  I can
see how you are trying to work around the issues but I can also see,
clearly, how a lawyer would use your words against you and for SCO.

For example, you haven't puzzled out what happens if there are two
GPL-like licenses which cover work which is combined.  Which one wins?
What if they have conflicting terms?  The GPL *does not* automatically
win, any more than the other license automatically wins.  Either could
win.

I also don't buy your separation argument in the context of licensed
intellectual property.  Your whole argument seems to allow things to
cross over boundaries but then when something you don't want to cross
over does, you start talking about how the work was separated and the
license you don't like doesn't apply.  I may be missing something but it
sure sounds like you are trying to intepret the law one way when it meets
your goals and another way when it doesn't and that isn't real promising.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
