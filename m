Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbUKYAxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUKYAxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUKYAtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:49:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30980 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262908AbUKYArI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:47:08 -0500
Date: Wed, 24 Nov 2004 19:47:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: dpt_i2o.c: make some code static (fwd)
Message-ID: <20041124184702.GI19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 15 Nov 2004 02:57:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: deanna_bonds@adaptec.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: dpt_i2o.c: make some code static

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c.old	2004-11-13 21:01:47.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c	2004-11-13 21:01:57.000000000 +0100
@@ -108,7 +108,7 @@
  *============================================================================
  */
 
-DECLARE_MUTEX(adpt_configuration_lock);
+static DECLARE_MUTEX(adpt_configuration_lock);
 
 static struct i2o_sys_tbl *sys_tbl = NULL;
 static int sys_tbl_ind = 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

