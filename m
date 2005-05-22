Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVEVVsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVEVVsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVEVVsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 17:48:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:18122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbVEVVse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 17:48:34 -0400
Date: Sun, 22 May 2005 14:50:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO
 chip
In-Reply-To: <1116796612.5730.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org> 
 <1116763033.19183.14.camel@localhost.localdomain>  <20050522135943.E12146@flint.arm.linux.org.uk>
  <20050522144123.F12146@flint.arm.linux.org.uk> <1116796612.5730.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 May 2005, Alan Cox wrote:
> 
> Take the existing OSDL statement which must be attached to all
> submissions by reference or directly and update it to include

You mean DCO, not OSDL ("Developer's Certificate of Origin").

And yes, I'll update the SubmittingPatches to state explicitly that the 
sign-off is a public record.

> "A public record of contributions is kept which includes the name and
> email address of each contributor. By contributing to the kernel project
> I accept that my email address provided will be part of that public
> record."

Note that we've never _required_ that the sign-off has an email address 
per se. I much much prefer people to have them, because the sign-off lines 
really have been very useful when we've had issues with some patch 
(several times I've just been able to send a directed email to everybody 
involved), but I don't actually want this to be a requirement. After all, 
10 years goes by, and many people will end up having different email 
addresses anyway.

So I'll just update the documentation that explains the DCO to say 
something like this, and not make it part of the official DCO itself. 
After all, all we really want the sign-off to signify is that you've been 
involved and have the right to pass changes on - the fact that the end 
result is public is really a different issue.

So how about just something like the appended? Along with making a very 
public announcement on linux-kernel for the next kernel release (rather 
than this discussion that is taking place under a fairly obscure subject), 
that should make sure that people are aware of the fact that the thing 
isn't exactly private.

(I think everybody realized that anyway, since a private sign-off would be 
totally pointless, but hey, let's make things as explicit as possible).

		Linus

----
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -299,6 +299,16 @@ Some people also put extra tags at the e
 now, but you can do this to mark internal company procedures or just
 point out some special detail about the sign-off. 
 
+PRIVACY NOTE! This sign-off - with full name and preferably email
+address - is for obvious reasons going to be very publicly archived with
+the kernel, and as such we are _not_ going to keep these things private. 
+
+If you want to use a special email address for sign-off procedures for
+this reason, feel free to do that, but since the email address ends up
+being very useful if it turns out that the patch had a bug, we really do
+prefer an active and live email address.  We encourage people to use
+spamassassin etc tools to fight spam. 
+
 
 -----------------------------------
 SECTION 2 - HINTS, TIPS, AND TRICKS
