Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTLFDBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLFDBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 22:01:07 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:48074 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264937AbTLFDBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 22:01:01 -0500
Date: Fri, 5 Dec 2003 19:00:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206030037.GB28765@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 05:58:18PM -0800, Linus Torvalds wrote:
> On Thu, 4 Dec 2003, Larry McVoy wrote:
> > > linux/COPYING says: This copyright does *not* cover user programs
> > > that use kernel services by normal system calls - this is merely
> > > considered normal use of the kernel, and does *not* fall under
> > > the heading of "derived work".
> >
> > Yeah, and the GPL specificly invalidates that statement.  We're on thin
> > ice here.  Linus is making up the rules, which is cool (since I tend to
> > like his rules) but the reality is that the GPL doesn't allow you to
> > extend the GPL.  It's the GPL or nothing.
> 
> Larry, you are wrong.

Linus, you are a purple 3 legged frog.  So there.  It is written and it
shall be so :)

> But a license only covers what it _can_ cover - derived works. The fact
> that Linux is under the GPL simply _cannot_matter_ to a user program, if
> the author can show that the user program is not a derived work.

I'll followup on this below.

> And the linux/COPYING addition is not an addition to the license itself
> (indeed, it cannot be, since the GPL itself is a copyrighted work, and so
> by copyright law you aren't allowed to just take it and change it).

Exactly my point.  The addition is not part of the license and given your 
other arguments, userland is 100% GPLed as a result.

> No, the note at the top of the copying file is something totally
> different: it's basically a statement to the effect that the copyright
> holder recognizes that there are limits to a derived work, and spells out
> one such limit that he would never contest in court.

It's one that _you_ apparently will never contest in court but the
amount of code in the kernel that you wrote is quite small.  You are the
leader but that doesn't mean you speak for everyone.  There seem to be
differing opinions.  In this case, that may be a good thing.

In my opinion, you are playing with fire and playing well into SCO's
hands.  I haven't read the original Unix license but I have heard that
it had a somewhat similar viral effect, like the GPL does.  I've heard
that it claims ownership of derived works, which I doubt is true.
But I've also heard that it claimed certain distribution rights for
derived works and that I do believe.  It's entirely plausible that a
commercial entity would have a license which says "you can't build on
my work and give to someone who hasn't also obtained a license from us".
Makes perfect sense and is quite likely.

However, if someone did take derived code (which is now covered by the
viral license) and add it illegally to Linux, it is entirely reasonable
for the license holder to say that all of Linux now has the virus.  Just
as reasonable as someone saying "hey, that's the Linux XYZ driver in 
Solaris, Solaris is now GPLed".

There seems to be this sentiment (a pleasant one) in this community that
if you do the wrong thing and then undo it, all is forgiven.  That's not
how the license reads.  The GPL doesn't say "if you uncombine the work you
are no longer obligated to obey the GPL".  Neither would any other license.

Roll forward a bit and see how this plays out in court.  Suppose there is
code in Linux that is derived from Unix.  Remember, if Unix licenses had
the same viral effect as the GPL, all it takes is a function or two and
the rest of the code is GPL-ed (or in this case, Unix-ed).  If you are
arguing that an API isn't a boundary for the GPL you are going to look
bloody two faced when you go and argue that an API is a boundary for Unix.

And all of this discussion is nicely indexed by Google for SCO's lawyers
to dig through and say "see, the leader of Linux doesn't think that
boundaries apply.  Linux is now covered *completely* by the SCO Unix
license.  Pay up".

I'm not a lawyer but I am someone who pays lawyers to figure this stuff
out and I've explored precisely this area.  I sure hope that what I've
learned is true because if what you are saying is true we are all likely
to be screwed.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
