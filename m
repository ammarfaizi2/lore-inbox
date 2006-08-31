Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWHaMOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWHaMOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWHaMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:14:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41873 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751439AbWHaMOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:14:07 -0400
Date: Thu, 31 Aug 2006 14:13:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: SubmittingPatches cleanups
Message-ID: <20060831121356.GU3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up SubmittingPatches a bit.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2cd7f02..9398fc2 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -173,15 +173,15 @@ For small patches you may want to CC the
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
 
@@ -245,13 +245,13 @@ updated change.
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
 
@@ -474,10 +474,10 @@ SECTION 3 - REFERENCES
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
@@ -486,9 +486,9 @@ Greg Kroah-Hartman "How to piss off a ke
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <http://marc.theaimsgroup.com/?l=linux-kernel&m=112112749912944&w=2>
 
-Kernel Documentation/CodingStyle
+Kernel Documentation/CodingStyle:
   <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
 
-Linus Torvald's mail on the canonical patch format:
+Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
 --

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
