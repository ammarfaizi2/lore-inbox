Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVDOPYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVDOPYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDOPW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:22:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261835AbVDOPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:45 -0400
Date: Fri, 15 Apr 2005 17:10:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport insert_resource
Message-ID: <20050415151043.GJ5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/resource.c.old	2005-03-04 01:01:30.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/resource.c	2005-03-04 01:01:42.000000000 +0100
@@ -371,8 +371,6 @@
 	return result;
 }
 
-EXPORT_SYMBOL(insert_resource);
-
 /*
  * Given an existing resource, change its start and size to match the
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of

