Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265427AbRF2QIj>; Fri, 29 Jun 2001 12:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266107AbRF2QI3>; Fri, 29 Jun 2001 12:08:29 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:20608 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S265427AbRF2QIU>;
	Fri, 29 Jun 2001 12:08:20 -0400
Date: Fri, 29 Jun 2001 19:10:14 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A Possible 2.5 Idea, maybe?
In-Reply-To: <Pine.LNX.4.33.0106290753340.25959-100000@biglinux.tccw.wku.edu>
Message-ID: <Pine.LNX.4.33L2.0106291901550.14545-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Brent D. Norris wrote:

> Recently one more than one subject there have been comments along the
> lines of, "Do x, y and z because it would be great on desktops" and then
> someone else will say "NO! becausing doing x, y, and z will make servers
> run slow."  Then as a final note someone else will say "Do y and z, but
> not x, because that will make my handheld linux project a lot better."
> Now whatever is eventually decided in each discusion, normally one
> group/user walks away feeling they are getting the shortend of the stick.

Ok, this is a problem. Though it was sort of discussed before when someone
came with the idea of creating a 'home' linux-kernel edition (yuck!).

> Now many of these things are configurable.  If it is the amount of
> messages that the boot of the kernel makes or even the "motivation" and
> actions that the VM takes.  It seems possible to configure the kernel so
> that it would work optimally for each of the groups.  The problem is that
> the code in these sections is having to work in too different of
> situations.  Example : The VM is now somewhat more tweaked for servers
> than it was previously.  Many people were concerned about the
> "interactivity" of it.  Now it seems that it would be possible to change
> the vm code so that it worked better for desktop users, but the
> maintainers are not eager to do that because it would slow linux down in
> the server market.

Thats why we have /proc/... To echo things into it.

> This all stems from one problem, which is a really great problem to have
> if you must have a problem.  Linux is spreading to largely different
> kinds of machines with many different purposes.  Microsoft solved this
> problem by having several different kernels (NT code base for servers, 9x
> code base for desktops, CE code base for handhelds), and this is somewhat
> like what the "forking is a good thing" messge recommended for linux.  I
> disagree with that concept though.  It is easy to see the trouble
> microsoft is having with that and now they are trying to slowly merge the
> two (NT,9x) together.

Several kernel threads are hard to maintain, hard to evolve, hard to
bugfix, modify patches, etc. Mainly, we should have a single kernel that
can be tuned to fit people's needs.


> Instead of forking the kernel or catering only to one group, instead why
> not try this:  Using the new CML2 tools and rulesets, make it possible to
> have the kernel configured for the type of job it will be doing?  Just
> like CML2 asks our CPU type (i386, alpha, althon ...) and then goes out
> and configures options for that, have it ask people "Is your machine a
> server, workstation, embedded/handheld?" and configure things in the
> kernel like the VM, bootup and others to optimize it for that job type?

IMO, the Linux distributions out there should configure the kernel based
on the type of system the (l[inux])user wants. Those who have the balls to
compile their own system should know such things anyway. The rest, better
rely on the distribution default and/or ask around and get some more
info [the kernel configuration help is explicit enough anyway, given a
decent level of common sense is used].


Dan.


