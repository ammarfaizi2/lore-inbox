Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUL3UZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUL3UZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUL3UZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:25:16 -0500
Received: from mail1.cluenet.de ([195.20.121.7]:31940 "EHLO mail1.cluenet.de")
	by vger.kernel.org with ESMTP id S261711AbUL3UZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:25:12 -0500
Date: Thu, 30 Dec 2004 21:25:11 +0100
From: Daniel Roesen <dr@cluenet.de>
To: Andrew Morton <akpm@osdl.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial comment wording/typo fix regarding taint flags
Message-ID: <20041230202511.GA6359@srv01.cluenet.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

trivial patch to 2.6.10 correcting a comment.


Best regards,
Daniel

Signed-off-by: Daniel Roesen <dr@cluenet.de>

diff -uprN linux-2.6.10.orig/kernel/panic.c linux-2.6.10/kernel/panic.c
--- linux-2.6.10.orig/kernel/panic.c	2004-12-24 22:35:29.000000000 +0100
+++ linux-2.6.10/kernel/panic.c	2004-12-30 19:11:07.000000000 +0100
@@ -128,7 +128,7 @@ EXPORT_SYMBOL(panic);
  *  'F' - Module has been forcibly loaded.
  *  'S' - SMP with CPUs not designed for SMP.
  *  'R' - User forced a module unload.
- *  'M' - Machine had a machine check experience.
+ *  'M' - System experienced a machine check exception.
  *  'B' - System has hit bad_page.
  *
  *	The string is overwritten by the next call to print_taint().
