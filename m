Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbRE3WAT>; Wed, 30 May 2001 18:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbRE3WAM>; Wed, 30 May 2001 18:00:12 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:8325 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S262826AbRE3V7w>; Wed, 30 May 2001 17:59:52 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15125.27981.363139.686900@quark.localdomain>
Date: Wed, 30 May 2001 16:59:41 -0500 (CDT)
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
In-Reply-To: <991254700.786.0.camel@tux.bitfreak.net>
In-Reply-To: <Pine.LNX.4.33.0105300719130.567-100000@mikeg.weiden.de>
	<01053014585700.01976@quark>
	<991254700.786.0.camel@tux.bitfreak.net>
X-Mailer: VM 6.72 under 21.1 (patch 9) "Canyonlands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje writes:
 > On 30 May 2001 14:58:57 -0500, Vincent Stemen wrote:
 > > There was a new 8139too driver added to the the 2.4.5 (I think) kernel
 > > which Alan Cox took back out and reverted to the old one in his
 > > 2.4.5-ac? versions because it is apparently causing lockups.
 > > Shouldn't this new driver have been released in a 2.5.x development
 > > kernel and proven there before replacing the one in the production
 > > kernel?  I haven't even seen a 2.5.x kernel released yet.
 > 
 > If every driver has to go thorugh the complete development cycle (of 2+
 > years), I'm sure very little driver writers will be as motivated as they
 > are now - it takes ages before they see their efforts "rewarded" with a
 > place in the kernel.
 > The ideal case is that odd-numbered kernels are "for testing" and
 > even-numbered kernels are stable. However, this is only theory. In
 > practice, you can't rule out all bugs. And you can't test all things for
 > all cases and every test case, the linux community doesn't have the
 > manpower for that. And to prevent a complete driver development cycle
 > taking 2+ years, you have to compromise.
 > 
 > If you would take 2+ years for a single driver development cycle, nobody
 > would be interested in linux since the new devices would only be
 > supported by a stable kernel two years after their release. See the
 > point? To prevent that, you need to compromise. and thus, sometimes, you
 > have some crashes.

I agree with everything you say up till this point, but you are
arguing against a point I never made.  First of all, bugs like the
8139too lockup was found within the first day or two of release in the
2.4.3 kernel.  Also, most show stopper bugs such as the VM problems
are found fairly quickly.  Even if it takes a long time to figure out
how to fix them, I do not think they should be pushed on through into
production kernels until they are until they are fixed.  I already
said that I do not expect minor bugs not to slip through.  However, if
they are minor, they can usually be fixed quickly once they are
discovered and it is no big deal if they make it into a production
kernel.

 > That's why there's still 2.2.x - that's purely stable
 > and won't crash as fast as 2.4.x, but misses the "newest
 > cutting-edge-technology device support" and "newest technology" (like
 > new SMP handling , ReiserFS, etc... But it *is* stable.
 > 

The reason I suggested more frequent major production releases is so
that you don't have to go back to a 2 or 3 year old kernel and loose
out on years worth of new features to have any stability.  One show
stopper bug like the VM problems would not be as much of a problem if
there was a stable production kernel that we could run that was only 4
or 6 months old.

 > > Based on Linus's original very good plan for even/odd numbers, there
 > > should not have been 2.4.0-test? kernels either.  This was another
 > > example of the rush to increment to 2.4 long before it was ready.
 > > There was a long stretch of test kernels and and now we are all the
 > > way to 2.4.5 and it is still not stable.  We are repeating the 2.2.x
 > > process all over again.
 > 
 > Wrong again.
 > 2.3.x is for development, adding new things, testing, adding, testing,
 > changing, testing, etc.

Which is the same point I made.

 > 2.4-test is for testing only, it's some sort of feature freeze.

Agreed.  My only point here was that it suggests that there are only
minor bugs left to be solved before the production release by setting
the version to 2.4-test.  That is one of the reasons I made the
suggestion to keep it in the 2.3 range, since there were actually
serious VM problems still upon the production 2.4 release.

 > 2.4.x is for final/stable 2.4.
 > It's a standard *nix development cycle. That's how everyone does it.

My point exactly.

 > 
 > Regards,
 > 
 > Ronald Bultje

