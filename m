Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUFUTQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUFUTQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUFUTQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:16:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:22748 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264228AbUFUTQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:16:07 -0400
Date: Mon, 21 Jun 2004 21:15:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [Patch] tiny update to Documentation/SubmittingDrivers - list X.Org
 as well as XFree86
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F95@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small patch that lists X.Org as well as XFree86 in
Documentation/SubmittingDrivers in the section talking about video
drivers. I think that since a lot of distributions and individuals are
moving to X.Org, but a lot are also staying with XFree86, it makes sense
to list both.
Patch is against 2.6.7

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/Documentation/SubmittingDrivers	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.7/Documentation/SubmittingDrivers	2004-06-21 21:05:27.000000000 +0200
@@ -3,7 +3,8 @@

 This document is intended to explain how to submit device drivers to the
 various kernel trees. Note that if you are interested in video card drivers
-you should probably talk to XFree86 (http://www.xfree86.org) instead.
+you should probably talk to XFree86 (http://www.xfree86.org/) and/or X.Org
+(http://x.org/) instead.

 Also read the Documentation/SubmittingPatches document.


--
Jesper Juhl <juhl-lkml@dif.dk>

