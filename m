Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSJaPj5>; Thu, 31 Oct 2002 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSJaPj4>; Thu, 31 Oct 2002 10:39:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63247 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262453AbSJaPjz>; Thu, 31 Oct 2002 10:39:55 -0500
Date: Thu, 31 Oct 2002 07:46:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Matt D. Robinson" <yakker@aparity.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210302224180.20210-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Oct 2002, Matt D. Robinson wrote:

> Linus Torvalds wrote:
> > > Crash Dumping (LKCD)
> > 
> > This is definitely a vendor-driven thing. I don't believe it has any
> > relevance unless vendors actively support it.
> 
> There are people within IBM in Germany, India and England, as well as
> a number of companies (Intel, NEC, Hitachi, Fujitsu), as well as SGI
> that are PAID to support this.

That's fine. And since they are paid to support it, they can apply the 
patches.  

What I'm saying by "vendor driven" is that it has no relevance for the 
standard kernel, and since it has no relevance to that, then I have no 
incentives to merge it. The crash dump is only useful with people who 
actively look at the dumps, and I don't know _anybody_ outside of the 
specialized vendors you mention who actually do that.

I will merge it when there are real users who want it - usually as a
result of having gotten used to it through a vendor who supports it. (And
by "support" I do not mean "maintain the patches", but "actively uses it"
to work out the users problems or whatever).

Horse before the cart and all that thing.

People have to realize that my kernel is not for random new features. The
stuff I consider important are things that people use on their own, or
stuff that is the base for other work. Quite often I want vendors to merge
patches _they_ care about long long before I will merge them (examples of
this are quite common, things like reiserfs and ext3 etc).

THAT is what I mean by vendor-driven. If vendors decide they really want
the patches, and I actually start seeing noises on linux-kernel or getting
requests for it being merged from _users_ rather than developers, then
that means that the vendor is on to something.

		Linus

