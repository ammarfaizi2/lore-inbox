Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRCSJQq>; Mon, 19 Mar 2001 04:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCSJQh>; Mon, 19 Mar 2001 04:16:37 -0500
Received: from imladris.infradead.org ([194.205.184.45]:46609 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S131375AbRCSJQd>;
	Mon, 19 Mar 2001 04:16:33 -0500
Date: Mon, 19 Mar 2001 09:15:37 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <Andries.Brouwer@cwi.nl>, <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <200103190650.f2J6o1S240830@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0103190846590.21272-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert.

 >>> The rule should be like this:
 >>>
 >>>	List the lowest version number required to get
 >>>	2.2.xx-level features while running a 2.4.xx kernel.

 >> That's a meaningless definition, and can only be taken as such. What
 >> use would such a list be to somebody wishing (like I recently was) to
 >> upgrade a system running the 2.0.12 kernel so it runs the 2.4.2
 >> kernel instead?

 > ...

 >>> Basically I ask: would existing scripts for a 2.2.xx kernel
 >>> break? If the old mount can still do what it used to do, then
 >>> "mount" need not be listed at all.

 >> Replace that "a 2.2.xx" with "my current" and remove all restrictions
 >> on what the current kernel is, and that becomes an important question.

 > No, not "my current" but "the previous stable". I say "2.2.xx" because
 > that is the previous stable kernel.

Again, saying either "2.2.xx" or "the previous stable" is meaningless.
Saying "The 2.2 kernel series" might have some meaning if it was not
for the fact that the requirements differ for different members of
that (or any other) kernel series.

On Saturday night, I had the pleasure of upgrading a system from the
2.2.4 kernel to the 2.4.2 one, and another system from the 2.2.14
kernel to the 2.4.2 one. Although the target kernel version was the
same, several subsystems needed upgrading on the former that did NOT
need upgrading on the latter, and that was just to compile the thing!

According to you, both of these upgrades would have required EXACTLY
THE SAME upgrades to be made, but that isn't the case.

 > If you upgrade from 2.0.xx, you should read the 2.2.xx changes file.

Fairy Nuff.

However, your argument still fails, simply because of its reliance on
the assumption that an entire kernel series has static requirements
when such just isn't the case.

 > The important thing is to avoid version number inflation. I don't
 > even bother reading the changes file, because I know it is bogus.
 > Nearly all of my old software works great with a 2.4.xx kernel.

The fact that you said "Nearly all" shows that your argument is false,
since your argument has been that NO software needs upgrading.

Can I suggest that you re-read my previous missive, and actually look
at the points raised. If you do, we might just get a sensible
discussion on this subject...

Incidentally, your argument to date has assumed that everybody always
installs every single kernel version. In my opinion, that is a very
dangerous assumption to make. A more responsible assumption would be
that the person wishing to upgrade to the version in this particular
kernel source tree has a random system installed, and wishes to know:

 1. What is the absolute minimum upgrades required to compile the
    kernel in the source tree I have just downloaded?

 2. What is the absolute minimum upgrades required to install the
    kernel in the source tree I have just downloaded and compiled?

 3. What is the absolute minimum upgrades required to enable me
    to run the kernel I have just compiled from this source tree,
    assuming that I wish to retain the use of the shell scripts
    that I developed under my previous kernel?

 4. What other upgrades are recommended for reasons of system
    security or stability?

 5. What further upgrades are required to enable me to make use
    of the advertised new facilities in this kernel?

 6. What additional subsystems could be upgraded if desired?

 7. I note that some upgrades are only required if certain of the
    subsystems are installed. Which upgrades are these, and which
    subsystems are they dependant on?

Personally, I'd be quite willing to work on a system to document the
requirements and classifying each requirement according to the above
system. However, as a pre-requisite, I would need agreement that such
was (a) worth doing, and (b) of interest to the kernel developers.

Best wishes from Riley.

