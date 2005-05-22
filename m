Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVEVWio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEVWio (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVEVWio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 18:38:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:46030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEVWik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 18:38:40 -0400
Date: Sun, 22 May 2005 15:40:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO
 chip
In-Reply-To: <1116800555.5744.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org> 
 <1116763033.19183.14.camel@localhost.localdomain>  <20050522135943.E12146@flint.arm.linux.org.uk>
  <20050522144123.F12146@flint.arm.linux.org.uk>  <1116796612.5730.15.camel@localhost.localdomain>
  <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org>
 <1116800555.5744.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 May 2005, Alan Cox wrote:
> 
> You have to -actively- agree to the DCO to submit a change, and that is
> what makes it work (whether you put something in submitting patches or
> not that is more explanatory).

Ok, that would imply that we'll need to bump the version to 1.1 or
something. So how about something like this? I'll also run it past the
OSDL lawyer, and if others were to run it past their lawyers, that would
be good.

I can't imagine that this change really would upset anybody, but hey,
let's double- and triple-check before I commit something like this.. As
mentioned, I think everybody is _very_ aware that Linux is a public
project, and I can't imagine that there are kernel developers who haven't
seen the changelogs we keep, so this feels a bit unnecessary, but let's 
be careful..

		Linus

----
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -271,7 +271,7 @@ patch, which certifies that you wrote it
 pass it on as a open-source patch.  The rules are pretty simple: if you
 can certify the below:
 
-        Developer's Certificate of Origin 1.0
+        Developer's Certificate of Origin 1.1
 
         By making a contribution to this project, I certify that:
 
@@ -291,6 +291,11 @@ can certify the below:
             person who certified (a), (b) or (c) and I have not modified
             it.
 
+	(d) I understand that the project is public, and that a record is
+	    kept of not just my submission but also of my sign-off,
+	    including whatever personal information (eg email address)
+	    that I include in the submission.
+
 then you just add a line saying
 
 	Signed-off-by: Random J Developer <random@developer.org>
