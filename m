Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286424AbRL0SIS>; Thu, 27 Dec 2001 13:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286415AbRL0SIB>; Thu, 27 Dec 2001 13:08:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286411AbRL0SHr>; Thu, 27 Dec 2001 13:07:47 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: The direction linux is taking
Date: Thu, 27 Dec 2001 18:05:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a0fntk$ukm$1@penguin.transmeta.com>
In-Reply-To: <20011227165752.A19618@flint.arm.linux.org.uk> <Pine.LNX.4.33L.0112271509570.12225-100000@duckman.distro.conectiva>
X-Trace: palladium.transmeta.com 1009476464 8958 127.0.0.1 (27 Dec 2001 18:07:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Dec 2001 18:07:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L.0112271509570.12225-100000@duckman.distro.conectiva>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>On Thu, 27 Dec 2001, Russell King wrote:
>
>> I envy Alan, Linus, and Marcelo for having the ability to silently
>> drop patches and wait for resends.

This is absolutely true - it's a _very_ powerful thing. Old patches
simply grow stale: keeping track of them is not necessarily at all
useful, and can add more work than anything else. 

One of the problems I had with jitterbug was that after a while the
thing just grew a lot, and I spent a lot of time with a cumbersome web
interface just acknowledging the patches.  And that was despite the fact
that not very many people actually actively used jitterbug to submit
patches to me, so I could see it just getting a _lot_ worse. 

>I'm not going to resend more than twice. If after that
>a critical bugfix isn't applied, I'll put it in our
>kernel RPM and the rest of the world has tough luck.

Which, btw, explains why I don't consider you a kernel maintainer, Rik,
and I don't tend to apply any patches at all from you.  It's just not
worth my time to worry about people who aren't willing to sustain their
patches.

When Al Viro sends me a patch that I apply, and later sends me a fix to
it that I miss for whatever reason, I can feel comfortable in the
knowledge that he _will_ follow up, not just whine.  This makes me very
willing to apply his patches in the first place.

Replace "Al Viro" with Jeff Garzik, David Miller, Alan Cox, etc etc. See
my point?

This is not about technology.  This is about sustainable development. 
The most important part to that is the developers themselves - I refuse
to put myself in a situation where _I_ need to scale, because that would
be stupid - people simply do not scale.  So I require others to do more
of the work. Think distributed development.

Note that things like CVS do not help the fundamental problem at all. 
They allow automatic acceptance of patches, and positively _encourage_
people to "dump" their patches on other people, and not act as real
maintainers. 

We've seen this several times in Linux - David, for example, used to
maintain his CVS tree, and he ended up being rather frustrated about
having to then maintain it all and clean up the bad parts because I
didn't want to apply them (and he didn't really want me to) and he
couldn't make people clean up themselves because "once it was in, it was
in". 

I know that source control advocates say that using source control makes
it easy to revert bad stuff, but that's simply not TRUE.  It's _not_
easy to revert bad stuff.  The only way to handle bad stuff is to make
people _responsible_ for their own sh*t, and have them maintain it
themselves. 

And you refuse to do that, and then you complain when others do not want
to maintain your code for you. 

		Linus
