Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVCDAyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVCDAyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVCDAso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:48:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23052 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262825AbVCDAsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:48:19 -0500
Date: Fri, 4 Mar 2005 01:48:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport insert_resource
Message-ID: <20050304004809.GW4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

