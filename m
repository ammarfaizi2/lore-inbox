Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265991AbRF2NRq>; Fri, 29 Jun 2001 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbRF2NRh>; Fri, 29 Jun 2001 09:17:37 -0400
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:44993 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S265991AbRF2NR2>; Fri, 29 Jun 2001 09:17:28 -0400
Date: Fri, 29 Jun 2001 08:17:25 -0500 (CDT)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: A Possible 2.5 Idea, maybe?
Message-ID: <Pine.LNX.4.33.0106290753340.25959-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently one more than one subject there have been comments along the
lines of, "Do x, y and z because it would be great on desktops" and then
someone else will say "NO! becausing doing x, y, and z will make servers
run slow."  Then as a final note someone else will say "Do y and z, but
not x, because that will make my handheld linux project a lot better."
Now whatever is eventually decided in each discusion, normally one
group/user walks away feeling they are getting the shortend of the stick.

Now many of these things are configurable.  If it is the amount of
messages that the boot of the kernel makes or even the "motivation" and
actions that the VM takes.  It seems possible to configure the kernel so
that it would work optimally for each of the groups.  The problem is that
the code in these sections is having to work in too different of
situations.  Example : The VM is now somewhat more tweaked for servers
than it was previously.  Many people were concerned about the
"interactivity" of it.  Now it seems that it would be possible to change
the vm code so that it worked better for desktop users, but the
maintainers are not eager to do that because it would slow linux down in
the server market.

This all stems from one problem, which is a really great problem to have
if you must have a problem.  Linux is spreading to largely different
kinds of machines with many different purposes.  Microsoft solved this
problem by having several different kernels (NT code base for servers, 9x
code base for desktops, CE code base for handhelds), and this is somewhat
like what the "forking is a good thing" messge recommended for linux.  I
disagree with that concept though.  It is easy to see the trouble
microsoft is having with that and now they are trying to slowly merge the
two (NT,9x) together.

Instead of forking the kernel or catering only to one group, instead why
not try this:  Using the new CML2 tools and rulesets, make it possible to
have the kernel configured for the type of job it will be doing?  Just
like CML2 asks our CPU type (i386, alpha, althon ...) and then goes out
and configures options for that, have it ask people "Is your machine a
server, workstation, embedded/handheld?" and configure things in the
kernel like the VM, bootup and others to optimize it for that job type?

Brent Norris

Executive Advisor -- WKU-Linux

