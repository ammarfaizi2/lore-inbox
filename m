Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUKOEDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUKOEDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUKOCOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:14:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6670 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbUKOCMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:12:41 -0500
Date: Mon, 15 Nov 2004 02:59:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: faith@cs.unc.edu
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: fdomain.c: make a struct static
Message-ID: <20041115015958.GI2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/fdomain.c.old	2004-11-13 21:03:26.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/fdomain.c	2004-11-13 21:03:45.000000000 +0100
@@ -458,7 +458,7 @@
 
 */
 
-struct signature {
+static struct signature {
    const char *signature;
    int  sig_offset;
    int  sig_length;

