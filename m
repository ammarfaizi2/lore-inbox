Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVBKS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVBKS7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVBKS4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:56:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262305AbVBKSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:27 -0500
Date: Fri, 11 Feb 2005 19:54:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: dpt_i2o.c: make some code static
Message-ID: <20050211185422.GD3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Nov 2004
- 24 Nov 2004

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c.old	2004-11-13 21:01:47.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c	2004-11-13 21:01:57.000000000 +0100
@@ -108,7 +108,7 @@
  *============================================================================
  */
 
-DECLARE_MUTEX(adpt_configuration_lock);
+static DECLARE_MUTEX(adpt_configuration_lock);
 
 static struct i2o_sys_tbl *sys_tbl = NULL;
 static int sys_tbl_ind = 0;

