Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVAJC4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVAJC4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVAJC4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:56:55 -0500
Received: from cantor.suse.de ([195.135.220.2]:45763 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262060AbVAJCzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:55:51 -0500
Date: Mon, 10 Jan 2005 03:55:42 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.com
Subject: [PATCH] Fix gcc 4 compilation in bttv
Message-ID: <20050110025542.GB6880@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix gcc 4 compilation in bttv driver. 

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/media/video/bttv.h
===================================================================
--- linux.orig/drivers/media/video/bttv.h	2005-01-09 18:19:22.%N +0100
+++ linux/drivers/media/video/bttv.h	2005-01-09 18:59:27.%N +0100
@@ -219,7 +219,6 @@
 };
 
 extern struct tvcard bttv_tvcards[];
-extern const unsigned int bttv_num_tvcards;
 
 /* identification / initialization of the card */
 extern void bttv_idcard(struct bttv *btv);
