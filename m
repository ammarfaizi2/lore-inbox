Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVCCLOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVCCLOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVCCLOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:14:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261582AbVCCLN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:13:56 -0500
Date: Thu, 3 Mar 2005 12:13:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: unexport dmi_get_system_info
Message-ID: <20050303111350.GM4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any possible modular usage of dmi_get_system_info in the 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Jan 2005

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/dmi_scan.c.old	2005-01-20 23:37:44.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/dmi_scan.c	2005-01-20 23:37:52.000000000 +0100
@@ -487,4 +487,3 @@
 	return dmi_ident[field];
 }
 
-EXPORT_SYMBOL(dmi_get_system_info);
