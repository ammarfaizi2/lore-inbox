Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281087AbRLAFyh>; Sat, 1 Dec 2001 00:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRLAFy2>; Sat, 1 Dec 2001 00:54:28 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:19754 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281087AbRLAFyV>; Sat, 1 Dec 2001 00:54:21 -0500
Message-Id: <4.3.2.7.2.20011130214001.00c21870@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 30 Nov 2001 21:54:12 -0800
To: Tim Hockin <thockin@hockin.org>, torvalds@transmeta.com (Linus Torvalds)
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Coding style - a non-issue
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112010202.fB122bE20177@www.hockin.org>
In-Reply-To: <Pine.LNX.4.33.0111301643170.1224-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list trimmed]

At 06:02 PM 11/30/01 -0800, Tim Hockin wrote:
> > Linux sez:
> > I'm deadly serious: we humans have _never_ been able to replicate
> > something more complicated than what we ourselves are, yet natural
> > selection did it without even thinking.
>
>a very interesting argument, but not very pertinent - we don't have 10's of
>thousands of year or even really 10's of years.  We have to use intellect
>to root out the obviously bad ideas, and even more importantly the
>bad-but-not-obviously-bad ideas.

Disagree with your position strongly.  It's very pertinent.

Most of the bad-but-not-obviously-bad ideas get rooted out by people trying 
them and finding them to be wanting.  Take, for example, the VM flap in the 
2.4.* tree:  an astonishing side effect of the operation of the VM system 
caused people to come up with one that wasn't so astonishing.  We're not 
sure why the original VM caused such problems.  We fixed it anyway.  (No, I 
played no part in that particular adventure, I was just viewing from the 
sidelines.)

The "Linux Way" as I understand it is to release early and release 
often.  That means that we go through a "generation" of released code every 
few weeks, and a "generation" of beta candidates just about daily...and if 
you include the patches that appear here during every 24 hours, the 
generation cycle is even faster than that.  That means that any mutations 
that are detrimental to the organism are exposed within days -- sometimes 
even hours -- of their introduction into the code base.

When we have a development tree open (as 2.5 is now freshly open) there are 
even more generations of code, which further makes natural selection viable 
as a weeding process for good and bad code.  The difference is that the 
number of people affected by the weeding process is smaller, and the 
probability of killing production systems with mutations becomes 
smaller.  The population of the organism is thus healthier because 
mutations affect a smaller fraction of the population, and the chances of 
expensive illness is reduced.

Beneficial mutations are "back-ported" into the 2.4 and even the 2.2 code 
trees, mutations that have proven their worth by extensive experimentation 
and experience.  Unlike the biological equivalent, this selective spreading 
of mutations further improves the health of the population of organisms.

Now that I've stretched the analogy as far as I care to, I will stop 
now.  Please consider the life-cycle of the kernel when thinking about what 
Linus said.

Just my pair-o-pennies(tm).

Stephen Satchell

