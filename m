Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSJaRC2>; Thu, 31 Oct 2002 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbSJaRC2>; Thu, 31 Oct 2002 12:02:28 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:31762 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265236AbSJaRCY>; Thu, 31 Oct 2002 12:02:24 -0500
Date: Thu, 31 Oct 2002 12:10:20 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org, <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210311201260.9552-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

>
> On Wed, 30 Oct 2002, Matt D. Robinson wrote:
>
> > Linus Torvalds wrote:
> > > > Crash Dumping (LKCD)
> > >
> > > This is definitely a vendor-driven thing. I don't believe it has any
> > > relevance unless vendors actively support it.
> >
> > There are people within IBM in Germany, India and England, as well as
> > a number of companies (Intel, NEC, Hitachi, Fujitsu), as well as SGI
> > that are PAID to support this.

To add to that list, here at Purdue University, we actively look at crash
dumps on other architectures, such as IBM AIX, and are starting to do the
same on Linux machines, after discovery of LKCD.

> What I'm saying by "vendor driven" is that it has no relevance for the
> standard kernel, and since it has no relevance to that, then I have no
> incentives to merge it. The crash dump is only useful with people who
> actively look at the dumps, and I don't know _anybody_ outside of the
> specialized vendors you mention who actually do that.

This has much relevance for the standard kernel, as much relevance as gdb
has for people using applications.  While a majority of non-techno-geek
end-users probably don't care about the patch, I'm certain that there are
plenty of organizations out there like Purdue that WANT lkcd to become a
standard part of the Linux kernel.   Until then, we're forced to do our
own kernel patching every time we push out a new kernel.

> I will merge it when there are real users who want it - usually as a
> result of having gotten used to it through a vendor who supports it. (And
> by "support" I do not mean "maintain the patches", but "actively uses it"
> to work out the users problems or whatever).

We actively use it.

> People have to realize that my kernel is not for random new features. The
> stuff I consider important are things that people use on their own, or
> stuff that is the base for other work. Quite often I want vendors to merge
> patches _they_ care about long long before I will merge them (examples of
> this are quite common, things like reiserfs and ext3 etc).

LKCD isn't a 'random new feature'.  It's something that is present in
nearly ever other "Unix" on the market. (Yes I know Unix != Linux).  It's
a feature that should have been integrated by now IMHO.

> THAT is what I mean by vendor-driven. If vendors decide they really want
> the patches, and I actually start seeing noises on linux-kernel or getting
> requests for it being merged from _users_ rather than developers, then
> that means that the vendor is on to something.

Again, we're the end-user, not the vendor, and we're trying to drive to
have it included.  I've talked with outher sys admins in my department
here at Purdue, and have gotten a unanimous response that "It would be a
good and useful feature to have."

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif




