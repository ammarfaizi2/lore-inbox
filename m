Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVAHWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVAHWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVAHWG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:06:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29445 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261417AbVAHWCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:02:25 -0500
Date: Sat, 8 Jan 2005 23:02:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/proc/kcore.c: make a function static
Message-ID: <20050108220215.GD14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/proc/kcore.c.old	2005-01-08 17:13:25.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/proc/kcore.c	2005-01-08 17:13:37.000000000 +0100
@@ -97,7 +97,7 @@
 /*
  * determine size of ELF note
  */
-int notesize(struct memelfnote *en)
+static int notesize(struct memelfnote *en)
 {
 	int sz;
 

