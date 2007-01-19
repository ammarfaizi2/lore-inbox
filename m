Return-Path: <linux-kernel-owner+w=401wt.eu-S964813AbXASTHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXASTHX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbXASTHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:07:23 -0500
Received: from stephens.ittc.ku.edu ([129.237.125.220]:48981 "EHLO
	stephens.ittc.ku.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845AbXASTHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:07:23 -0500
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 14:07:23 EST
From: Noah Watkins <nwatkins@ittc.ku.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include linux/fs.h in linux/cdev.h for struct inode
Date: Fri, 19 Jan 2007 12:54:07 -0600
Message-Id: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
X-Mailer: git-send-email 1.4.4.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (stephens.ittc.ku.edu [129.237.125.220]); Fri, 19 Jan 2007 12:54:07 -0600 (CST)
X-VirusScan: Clean
X-MailScanner-From: nwatkins@ittc.ku.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 include/linux/cdev.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index f309b00..b53e2a0 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -5,6 +5,7 @@
 #include <linux/kobject.h>
 #include <linux/kdev_t.h>
 #include <linux/list.h>
+#include <linux/fs.h>
 
 struct cdev {
 	struct kobject kobj;
-- 
1.4.4.1

