Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbRF2Qkm>; Fri, 29 Jun 2001 12:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266119AbRF2Qkc>; Fri, 29 Jun 2001 12:40:32 -0400
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:60354 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S266115AbRF2QkX>; Fri, 29 Jun 2001 12:40:23 -0400
Date: Fri, 29 Jun 2001 11:40:15 -0500 (CDT)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A Possible 2.5 Idea, maybe?
In-Reply-To: <Pine.LNX.4.33L2.0106291901550.14545-100000@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.33.0106291124490.26820-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats why we have /proc/... To echo things into it.

I don't know of a proc entry that lets the user tell the VM not to cache
as much or use swap in a different manner.

> Several kernel threads are hard to maintain, hard to evolve, hard to
> bugfix, modify patches, etc. Mainly, we should have a single kernel that
> can be tuned to fit people's needs.

I agree that keeping several threads would be difficult, but is there not
a way to have certain values plugged into the code for something like
cache pressure before swapping, or extended boot messages instead of a
quiet boot?  These values would be dependant on the config options that
were selected in the config.  I am not talking about forking the kernel.
I am instead talking about a process to select a different concept that
the same kernel runs under and have this concept selected at compile time.

> IMO, the Linux distributions out there should configure the kernel based
> on the type of system the (l[inux])user wants. Those who have the balls to
> compile their own system should know such things anyway. The rest, better
> rely on the distribution default and/or ask around and get some more
> info [the kernel configuration help is explicit enough anyway, given a
> decent level of common sense is used].

This leaves several people out in the rain though.  First how would a
distro make a system that works well for the desktop users if the kernel
is designed to work well on servers?  Also I should be able to run debian
on my desktop if I want without having to suffer through interactivity
issues, because debian builds their distros for servers and has most of
the hard drives cached.  Also I know several people that recompile kernels
and such, but have no clue as the process to go through to optimize it for
their particular setup.  If people are hoping that linux will move into
other markets besides servers then you cannot have the attitude that
everyone has to suffer with a) what the distros give them or b) be come
fluent enought in kernel programming and desgin to be able to edit the
code so that it works better for them.

Brent Norris

Executive Advisor -- WKU-Linux

