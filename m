Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCWJnu>; Fri, 23 Mar 2001 04:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRCWJnb>; Fri, 23 Mar 2001 04:43:31 -0500
Received: from imladris.infradead.org ([194.205.184.45]:6153 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S130438AbRCWJnW>;
	Fri, 23 Mar 2001 04:43:22 -0500
Date: Fri, 23 Mar 2001 09:42:36 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <200103230833.f2N8XiR141134@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0103230936160.2900-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert.

Since you appear to be determined to ignore reason and stick to your
misguided guns I'll leave you to destroy all the good work that has
gone into the Linux kernel's documentation and make it something even
Bill Gates would be proud of. However, I'll stick to documentation
that actually tells people what they need to know whilst you do so.

Best wishes from Riley.

*********************************************************************

On Fri, 23 Mar 2001, Albert D. Cahalan wrote:

 > Riley Williams writes:
 > > Hi Albert.
 >
 > >>>> The rule should be like this:
 > >>>>
 > >>>>	List the lowest version number required to get
 > >>>>	2.2.xx-level features while running a 2.4.xx kernel.
 >
 > >>> Replace that "a 2.2.xx" with "my current" and remove all
 > >>> restrictions on what the current kernel is, and that becomes
 > >>> an important question.
 > >>
 > >> No, not "my current" but "the previous stable". I say "2.2.xx"
 > >> because that is the previous stable kernel.
 > >
 > > Again, saying either "2.2.xx" or "the previous stable" is meaningless.
 > > Saying "The 2.2 kernel series" might have some meaning if it was not
 > > for the fact that the requirements differ for different members of
 > > that (or any other) kernel series.
 >
 > Oh please. List whatever the hell is needed for an upgrade from any
 > of 2.2, 2.2.1, 2.2.2, 2.2.3, 2.2.4, 2.2.5, ..., 2.2.255 of course.
 > Also include previous 2.4.xx kernels, in case some bastard decided to
 > break stuff within a stable kernel series... like PPP for example.
 >
 > > On Saturday night, I had the pleasure of upgrading a system from the
 > > 2.2.4 kernel to the 2.4.2 one, and another system from the 2.2.14
 > > kernel to the 2.4.2 one. Although the target kernel version was the
 > > same, several subsystems needed upgrading on the former that did NOT
 > > need upgrading on the latter, and that was just to compile the thing!
 >
 > So what? Your point is??? Obviously one system was partly upgraded.
 >
 > > According to you, both of these upgrades would have required EXACTLY
 > > THE SAME upgrades to be made, but that isn't the case.
 >
 > I never claimed that.
 >
 > >> If you upgrade from 2.0.xx, you should read the 2.2.xx changes file.
 > >
 > > Fairy Nuff.
 > >
 > > However, your argument still fails, simply because of its reliance on
 > > the assumption that an entire kernel series has static requirements
 > > when such just isn't the case.
 >
 > There is no such assumption.
 >
 > If 2.2.4 needs foo-1.7 while 2.2.5 and 2.4.4 need foo-1.8, then
 > foo gets listed. If 2.1.99 needs bar-0.6 while 2.2.0 and 2.4.4
 > need bar 0.7, then there is no need to list bar. Never mind that
 > both foo and bar are up to version 666, since that isn't needed.
 >
 > >> The important thing is to avoid version number inflation. I don't
 > >> even bother reading the changes file, because I know it is bogus.
 > >> Nearly all of my old software works great with a 2.4.xx kernel.
 > >
 > > The fact that you said "Nearly all" shows that your argument is false,
 > > since your argument has been that NO software needs upgrading.
 > >
 > > Can I suggest that you re-read my previous missive, and actually look
 > > at the points raised. If you do, we might just get a sensible
 > > discussion on this subject...
 >
 > Try it yourself, w/o alcohol. I didn't argue "NO software...".
 >
 > > Incidentally, your argument to date has assumed that everybody always
 > > installs every single kernel version. In my opinion, that is a very
 > > dangerous assumption to make.
 >
 > Nope. Most people go from one stable series to the next, often skipping
 > the first and last few revisions. (2.2.6, 2.2.9, 2.2.17, 2.4.3, 2.4.8...)
 >
 > > A more responsible assumption would be
 > > that the person wishing to upgrade to the version in this particular
 > > kernel source tree has a random system installed, and wishes to know:
 >
 > That random system should be capable of working with at least
 > one kernel from the previous stable series.
 >
 > >  1. What is the absolute minimum upgrades required to compile the
 > >     kernel in the source tree I have just downloaded?
 > >
 > >  2. What is the absolute minimum upgrades required to install the
 > >     kernel in the source tree I have just downloaded and compiled?
 > >
 > >  3. What is the absolute minimum upgrades required to enable me
 > >     to run the kernel I have just compiled from this source tree,
 > >     assuming that I wish to retain the use of the shell scripts
 > >     that I developed under my previous kernel?
 > >
 > >  4. What other upgrades are recommended for reasons of system
 > >     security or stability?
 >
 > Good, assuming "reasons of system security or stability" relates
 > to problems that a kernel upgrade might cause.
 >
 > >  5. What further upgrades are required to enable me to make use
 > >     of the advertised new facilities in this kernel?
 >
 > This is noise. Such upgrades are not required.
 >
 > >  6. What additional subsystems could be upgraded if desired?
 >
 > This is worse noise: "...and The GIMP is now at version..."
 >
 > >  7. I note that some upgrades are only required if certain of the
 > >     subsystems are installed. Which upgrades are these, and which
 > >     subsystems are they dependant on?
 >
 > This is getting too fancy.
 >

