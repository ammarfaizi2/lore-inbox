Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVAUKO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVAUKO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAUKMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:12:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8976 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262288AbVAUKJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:09:02 -0500
Date: Fri, 21 Jan 2005 11:09:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] i386: unexport dmi_get_system_info
Message-ID: <20050121100900.GG3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any modular usage of dmi_get_system_info in the kernel.

Is this patch correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/dmi_scan.c.old	2005-01-20 23:37:44.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/dmi_scan.c	2005-01-20 23:37:52.000000000 +0100
@@ -487,4 +487,3 @@
 	return dmi_ident[field];
 }
 
-EXPORT_SYMBOL(dmi_get_system_info);
