Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbTAKWyH>; Sat, 11 Jan 2003 17:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268167AbTAKWyH>; Sat, 11 Jan 2003 17:54:07 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:4339 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268165AbTAKWyG>; Sat, 11 Jan 2003 17:54:06 -0500
Date: Sat, 11 Jan 2003 17:57:50 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-reply-to: <20030111233633.A17042@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042325870.1034.45.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com>
 <1042250324.1278.18.camel@RobsPC.RobertWilkens.com>
 <20030111020738.GC9373@work.bitmover.com>
 <1042251202.1259.28.camel@RobsPC.RobertWilkens.com>
 <20030111021741.GF9373@work.bitmover.com>
 <1042252717.1259.51.camel@RobsPC.RobertWilkens.com>
 <20030111214437.GD9153@nbkurt.casa-etp.nl>
 <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
 <20030111233633.A17042@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 17:36, Vojtech Pavlik wrote:
> > I'd say terribly presumptuous, but I don't think it is presumptuous to
> > say that if there are many patches (bug fixes, mostly) coming in that
> > the code that was originally there was of questionable quality.
> 
> Very interesting idea. But not correct.
> 
> The reason is code rot(*). 

Which by definition you gave on the tuxedo.org site is a lack of
robustness in the original code.  Again, pointing to the fact that the
original code was not well designed, and hence the term "kernel hacking"
being more relevant than "software engineering" when it comes to linux.

Of course, that is what makes it fun.. 

> You have never to stop maintaining and patching
> and fixing the code to keep it working. 

That's a software developers dream: Never to become obsolete.  

One problem I remember UNIX having, and I don't know if this has been
addressed yet, was that UNIX systems that I used to work on had a
forthcoming "Year 2036 or Year 2037" (thereabouts) bug coming whereby
they had no method of representing years beyond that year because dates
were stored as the number of [seconds|minutes|days] since a certain
date.  I'm curious if Linux has this same kind of problem, and if we'll
be seeing a rush of "Year 2037 bug fixers" the way we saw year 2000 bug
fixers in 2000 years.

I mention the above to stay relevant to the linux-kernel mailing list,
though forgive me if this is a non-kernel (i.e. library) issue.  The
line between kernel and library is always blurry from a programmer's
perspective.

> A perfectly good and clean code,
> if you don't touch it, becomes crusty and smelly over time(**). 

Per your comment, re: hardware changing over time, why can't linux just
come up with a nice binary plug-in driver architecture (ok, it has
kernel modules, but from one compile of a kernel to another, the modules
aren't portable).  If there were a module plug-in architecture, the
kernel code wouldn't have to change much to support new hardware.

A little "design time" up front (in other words) would save a lot of
coding time later...

Also -- Why hasn't there been a move to something like CVS for the
kernel -- perhaps with linus being the cvs 'god' or whatever the person
who authorizes changes to the code is called.  This way you get to
always have the latest code, and check the changes back in without using
an ancient mail text-based interface, and you can describe your changes
(which get forever stored with the change), and changes can always be
backed out.  Remember, I'm a newbie, so point me to the FAQ if this is
there.

> This is why
> the number of patches daily entering the kernel is actually a sign of good
> overall code quality. ;)

Oh, I should've known there was a smiley coming <smirk>

-Rob
[Pushing the NVIDIA thread further because I have one of these damned
cards and want support for it in the 2.5+ kernels.]

