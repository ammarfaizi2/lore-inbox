Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUESIoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUESIoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUESIoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 04:44:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4736 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264113AbUESIn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 04:43:59 -0400
Date: Wed, 19 May 2004 09:49:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
To: Rob Landley <rob@landley.net>, Rene Rebe <rene@rocklinux-consulting.de>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
In-Reply-To: <200405121412.00068.rob@landley.net>
References: <409BB334.7080305@pobox.com>
 <20040509.105253.26927810.rene@rocklinux-consulting.de>
 <200405091053.i49ArBnh000172@81-2-122-30.bradfords.org.uk>
 <200405121412.00068.rob@landley.net>
Subject: Re: Distributions vs kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rob Landley <rob@landley.net>:
> On Sunday 09 May 2004 05:53, John Bradford wrote:
> 
> > > And no, it is not like Gentoo where you need to rebuild on each box or
> > > so.
> >
> > I keep hearing about projects which I hope will be what you describe above
> > for ROCK Linux.  Unfortunately, I haven't found one that goes far enough in
> > that direction yet.  Maybe there just isn't the demand for it these days.
> 
> As a side effect of debugging busybox, I created a shellscript that compiles a 
> stripped down Linux From Scratch system entirely from source.

That's interesting - what I find dissapointing about the Linux From Scratch
project is that it basically involves first setting up a minimal system, then
booting in to that new system at an early stage to complete the construction
of the system.

Although it lets the user 'escape' their original system quite quickly, my
interest lies more in creating a custom Linux installation using an existing
development environment.

[snip]

> As for the rest of your article: don't assume that trading a familiar set of 
> problems for an unfamiliar set of problems automatically solves more than it 
> causes.

Well, I don't just assume that, but in this case, I think I've demonstrated
to myself that pre-compiled binaries are more difficult to support than
programs compiled from source.

Of course, it's possible to learn a lot about one specific version of one
specific distribution, and doing that might make it easier to support any
pre-compiled binaries in that particular version of that particular
distribution than an installation from source.

However, surely that is just learning about more and more special cases.

It might even be possible to learn about such a large number of special cases
that a user can solve all the problems they encounter without any generic
knowledge of a system, but I think that is a bad thing to encourage.

If I get a phone call asking for help with a program I've never heard of
before, possibly on a distribution I've never heard of before, I belive that
I can offer much better generic advice based on an overall knowledge of the
system if everything is source-based, than if a distribution's pre-compiled
binaries have been installed.  To me, those pre-compiled binaries are
"non-standard".

This is one reason why I do not advertise support services for proprietrary
systems.  I do not want to fix problems by learning about many, many, special
cases - I want to use my generic knowledge of computers to fix problems, and
I believe that it is a better way to use computers in general.

> Build from source has more potential, sure.  And when the standard 
> laptop has a 10 ghz 64 bit processor and 4 gigabytes of ram, it'll make a lot 
> of sense

I don't think compiling from source is particularly inpractical on a typical
modern desktop machine today.

[snip]

> But compiling stuff from source is HEAVILY dependent on sequencing; 
> ./configure won't add ncurses support unless you installed ncurses first.  

That's true for a lot of libraries and basic components of a system, but I
don't think it's so much of a problem in general.

> How much stuff do you rebuild because you just added openssl, or switched to 
> alsa from oss?

Not too much to make it impractical, in my opinion.

> How do you keep track of the dependencies so it CAN rebuild?

In practice, I haven't found it to be particularly complicated.

> If your build system is a static command set like my shellscript, "build this 
> list of packages in this order",

It's not.  My 'build system' is basically me sitting at the console.

> how much of an improvement is this really 
> over a binary distro?

For the initial installation, maybe not much of an improvement, but for
on-going use of a system, I think compiling from source is better overall.

John.
