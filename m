Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWFRHc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWFRHc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWFRHcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:32:33 -0400
Received: from mail31.syd.optusnet.com.au ([211.29.132.102]:61602 "EHLO
	mail31.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932123AbWFRHbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][11/29] defaultcfq.diff
Date: Sun, 18 Jun 2006 17:31:44 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1257
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.44344.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the cfq I/O Scheduler as the default.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 block/Kconfig.iosched |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-ck-dev/block/Kconfig.iosched
===================================================================
--- linux-ck-dev.orig/block/Kconfig.iosched	2006-06-18 15:20:13.000000000 +1000
+++ linux-ck-dev/block/Kconfig.iosched	2006-06-18 15:23:51.000000000 +1000
@@ -40,7 +40,7 @@ config IOSCHED_CFQ
 
 choice
 	prompt "Default I/O scheduler"
-	default DEFAULT_AS
+	default DEFAULT_CFQ
 	help
 	  Select the I/O scheduler which will be used by default for all
 	  block devices.

-- 
-ck
