Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUHWV1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUHWV1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHWV1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:27:50 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:49415 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S267957AbUHWV10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:27:26 -0400
Date: Mon, 23 Aug 2004 16:25:17 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tossati@cyclades.com, axboe.suse.de@beardog.cca.cpqcorp.net
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: patch for kernel_stats.h, bump DK_MAJOR_MAX for cciss devices
Message-ID: <20040823212517.GA8811@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch bumps DK_MAX_MAJOR to 111 so various cciss statistics can be
collected just they are with SCSI, IDE, etc.
Applies to 2.4.28-pre1. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx2428-pre1.orig/include/linux/kernel_stat.h lx2428-pre1/include/linux/kernel_stat.h
--- lx2428-pre1.orig/include/linux/kernel_stat.h	2004-08-23 15:41:43.640300000 -0500
+++ lx2428-pre1/include/linux/kernel_stat.h	2004-08-23 15:43:07.097613064 -0500
@@ -12,7 +12,7 @@
  * used by rstatd/perfmeter
  */
 
-#define DK_MAX_MAJOR 16
+#define DK_MAX_MAJOR 111
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
