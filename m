Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWENRYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWENRYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWENRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:24:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63631 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751288AbWENRYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:24:22 -0400
Date: Sun, 14 May 2006 19:23:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Cleanups to Doc*/SubmittingPatches
Message-ID: <20060514172330.GH2438@elf.ucw.cz>
References: <20060514143037.GA2886@elf.ucw.cz> <20060514101254.f731daf1.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514101254.f731daf1.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This cleans up Submitting patches a bit. Missing/inconsistent full
> > stops, mostly.
> 
> Incomplete sentences (fragments) don't need full stops, but they
> should be consistent.
> 
> > diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > index c2c85bc..07b87ce 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -173,17 +173,17 @@ copy the maintainer when you change thei
> >  For small patches you may want to CC the Trivial Patch Monkey
> >  trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
> >  patches. Trivial patches must qualify for one of the following rules:
> > - Spelling fixes in documentation
> > + Spelling fixes in documentation.
> >   Spelling fixes which could break grep(1).
> 
> I would just remove that '.' above and skip the rest of the
> changes in this section.

Does this look better? (Sorry, english is my 2nd language).
								Pavel

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c2c85bc..6f873e5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -174,15 +174,15 @@ For small patches you may want to CC the
 trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
 patches. Trivial patches must qualify for one of the following rules:
  Spelling fixes in documentation
- Spelling fixes which could break grep(1).
+ Spelling fixes which could break grep(1)
  Warning fixes (cluttering with useless warnings is bad)
  Compilation fixes (only if they are actually correct)
  Runtime fixes (only if they actually fix things)
- Removing use of deprecated functions/macros (eg. check_region).
+ Removing use of deprecated functions/macros (eg. check_region)
  Contact detail and documentation fixes
  Non-portable code replaced by portable code (even in arch-specific,
  since people copy, as long as it's trivial)
- Any fix by the author/maintainer of the file. (ie. patch monkey
+ Any fix by the author/maintainer of the file (ie. patch monkey
  in re-transmission mode)
 URL: <http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/>
 
@@ -246,13 +246,13 @@ updated change.
 It is quite common for Linus to "drop" your patch without comment.
 That's the nature of the system.  If he drops your patch, it could be
 due to
-* Your patch did not apply cleanly to the latest kernel version
+* Your patch did not apply cleanly to the latest kernel version.
 * Your patch was not sufficiently discussed on linux-kernel.
-* A style issue (see section 2),
-* An e-mail formatting issue (re-read this section)
-* A technical problem with your change
-* He gets tons of e-mail, and yours got lost in the shuffle
-* You are being annoying (See Figure 1)
+* A style issue (see section 2).
+* An e-mail formatting issue (re-read this section).
+* A technical problem with your change.
+* He gets tons of e-mail, and yours got lost in the shuffle.
+* You are being annoying.
 
 When in doubt, solicit comments on linux-kernel mailing list.
 
@@ -475,22 +475,22 @@ SECTION 3 - REFERENCES
 Andrew Morton, "The perfect patch" (tpp).
   <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
 
-Jeff Garzik, "Linux kernel patch submission format."
+Jeff Garzik, "Linux kernel patch submission format".
   <http://linux.yyz.us/patch-format.html>
 
-Greg Kroah-Hartman "How to piss off a kernel subsystem maintainer".
+Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/2005/03/31/>
   <http://www.kroah.com/log/2005/07/08/>
   <http://www.kroah.com/log/2005/10/19/>
   <http://www.kroah.com/log/2006/01/11/>
 
-NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!.
+NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <http://marc.theaimsgroup.com/?l=linux-kernel&m=112112749912944&w=2>
 
-Kernel Documentation/CodingStyle
+Kernel Documentation/CodingStyle:
   <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
 
-Linus Torvald's mail on the canonical patch format:
+Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
 --
 Last updated on 17 Nov 2005.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
