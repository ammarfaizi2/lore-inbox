Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbTLFOZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTLFOZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:25:48 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26305 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265171AbTLFOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:25:45 -0500
Date: Sat, 6 Dec 2003 09:13:00 -0500
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206141300.GA13372@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206030037.GB28765@work.bitmover.com>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 07:00:37PM -0800, Larry McVoy wrote:
> In my opinion, you are playing with fire and playing well into SCO's
> hands.  I haven't read the original Unix license but I have heard that
> it had a somewhat similar viral effect, like the GPL does.  I've heard
> that it claims ownership of derived works, which I doubt is true.
> But I've also heard that it claimed certain distribution rights for
> derived works and that I do believe.  It's entirely plausible that a
> commercial entity would have a license which says "you can't build on
> my work and give to someone who hasn't also obtained a license from us".
> Makes perfect sense and is quite likely.
> 
> However, if someone did take derived code (which is now covered by the
> viral license) and add it illegally to Linux, it is entirely reasonable
> for the license holder to say that all of Linux now has the virus.  Just
> as reasonable as someone saying "hey, that's the Linux XYZ driver in 
> Solaris, Solaris is now GPLed".

This last is unfounded.  It may be true to say that Sun could only
release Solaris+XYZ under the GPL, but it is fantasy to imagine that
this makes Solaris now GPLed.  That is simply not one of the
available legal remedies for breach of a copyright license.  Pamela
Jones of groklaw.net fame wrote a more authoritative article
covering this point at http://lwn.net/Articles/61292/ (unfortunately
subscriber-only for the next week, I think).  She cited (FSF's
lawyer) Eben Moglen:

    The claim that a GPL violation could lead to the forcing open of
    proprietary code that has wrongfully included GPL'd components
    is simply wrong. There is no provision in the Copyright Act to
    require distribution of infringing work on altered terms. What
    copyright plaintiffs are entitled to, under the Act, are
    damages, injunctions to prevent infringing distribution,
    and--where appropriate--attorneys' fees. A defendant found to
    have wrongfully included GPL'd code in its own proprietary work
    can be mulcted in damages for the distribution that has already
    occurred, and prevented from distributing its product further.
    That's a sufficient disincentive to make wrongful use of GPL'd
    program code. And it is all that the Copyright Act permits.

(At first, I had hoped that "mulcted" was a typo for "mulched", but
then I looked it up.)

It might be true that Sun's misdeed perpetually voids their license
to XYZ.  RMS argued similarly after QT was GPLed to accomodate KDE
(and explicitly "forgave" the breach wrt FSF-owned code).  But this
is entirely different from forcing anyone to put their own code
under some particular license.

> There seems to be this sentiment (a pleasant one) in this community that
> if you do the wrong thing and then undo it, all is forgiven.  That's not
> how the license reads.  The GPL doesn't say "if you uncombine the work you
> are no longer obligated to obey the GPL".  Neither would any other license.

Again, totally groundless AFAICT.  This is not within the scope of
what a copyright license can require, and runs directly counter to
my (meager) knowledge of case law.  Courts generally don't force
violators to license material under specific terms (except perhaps
in antitrust cases).

> Roll forward a bit and see how this plays out in court.  Suppose there is
> code in Linux that is derived from Unix.  Remember, if Unix licenses had
> the same viral effect as the GPL, all it takes is a function or two and
> the rest of the code is GPL-ed (or in this case, Unix-ed).  If you are
> arguing that an API isn't a boundary for the GPL you are going to look
> bloody two faced when you go and argue that an API is a boundary for Unix.

Your comparisons to the SCO case are far-fetched.  In part because
of what I said above (your idea of "viral" is divorced from
reality), and in part because there is a diverse range of
boundaries, and any judge can see that there is a wide gulf between
the kernel-module boundary and the unix-"anything that's ever
touched unix even through N indirections" boundary.  We are not on a
slippery slope.

> And all of this discussion is nicely indexed by Google for SCO's lawyers
> to dig through and say "see, the leader of Linux doesn't think that
> boundaries apply.  Linux is now covered *completely* by the SCO Unix
> license.  Pay up".

You seem to think that this boundary thing is black and white.  "If
the GPL crosses the kernel-module boundary, any license can cross
any boundary."  I think you have to do better than that.

Andrew
