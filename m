Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWF3LcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWF3LcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWF3Lb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:31:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12552 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750927AbWF3Lby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:31:54 -0400
Date: Fri, 30 Jun 2006 13:31:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/fremap.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113153.GM19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/mm/fremap.c.old	2006-06-30 02:44:43.000000000 +0200
+++ linux-2.6.17-mm4-full/mm/fremap.c	2006-06-30 02:45:20.000000000 +0200
@@ -90,7 +90,7 @@
 out:
 	return err;
 }
-EXPORT_SYMBOL(install_page);
+EXPORT_UNUSED_SYMBOL(install_page);  /*  June 2006  */
 
 /*
  * Install a file pte to a given virtual memory address, release any

