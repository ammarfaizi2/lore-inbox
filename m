Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbULLTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbULLTnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbULLTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:43:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35601 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262097AbULLTnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:43:05 -0500
Date: Sun, 12 Dec 2004 20:42:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] lib/kernel_lock.c: make kernel_sem static
Message-ID: <20041212194255.GD22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes kernel_sem static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/lib/kernel_lock.c.old	2004-12-12 03:44:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/lib/kernel_lock.c	2004-12-12 03:44:09.000000000 +0100
@@ -79,7 +79,7 @@
  *
  * Don't use in new code.
  */
-DECLARE_MUTEX(kernel_sem);
+static DECLARE_MUTEX(kernel_sem);
 
 /*
  * Re-acquire the kernel semaphore.

