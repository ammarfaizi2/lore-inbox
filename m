Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVACSNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVACSNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVACSKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:10:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261649AbVACSGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:06:01 -0500
Date: Mon, 3 Jan 2005 19:05:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: drzeus-wbsd@drzeus.cx, Andrew Morton <akpm@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, wbsd-devel@list.drzeus.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix warning in wbsd (fwd)
Message-ID: <20050103180559.GN2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below by Pierre Ossman <drzeus-list@drzeus.cx> still
applies and compiles against 2.6.10-mm1.

Please apply.


Signed-off-by: Adrian Bunk <bunk@stusta.de>



----- Forwarded message from Pierre Ossman <drzeus-list@drzeus.cx> -----

Date:	Mon, 27 Dec 2004 02:01:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] Fix warning in wbsd

Cleanup that fixes a warning in the wbsd module.

Index: linux-wbsd/drivers/mmc/wbsd.c
===================================================================
--- linux-wbsd/drivers/mmc/wbsd.c	(revision 109)
+++ linux-wbsd/drivers/mmc/wbsd.c	(working copy)
@@ -205,8 +205,6 @@
 
 static inline void wbsd_init_sg(struct wbsd_host* host, struct mmc_data* data)
 {
-	struct request* req = data->req;
-	
 	/*
 	 * Get info. about SG list from data structure.
 	 */


----- End forwarded message -----

