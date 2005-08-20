Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVHTT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVHTT1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVHTT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:27:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31243 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750711AbVHTT13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:27:29 -0400
Date: Sat, 20 Aug 2005 21:27:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/constants.c should include scsi_dbg.h
Message-ID: <20050820192727.GF3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C files should include the files with the prototypes for their global 
functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1/drivers/scsi/constants.c.old	2005-08-20 14:42:12.000000000 +0200
+++ linux-2.6.13-rc6-mm1/drivers/scsi/constants.c	2005-08-20 14:43:03.000000000 +0200
@@ -17,6 +17,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_request.h>
 #include <scsi/scsi_eh.h>
+#include <scsi/scsi_dbg.h>
 
 
 

