Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWJJSV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWJJSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWJJSVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26291 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965010AbWJJSVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:11 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       linux-kernel@vger.kernel.org
Date: Tue, 10 Oct 2006 11:21:07 -0700
Message-Id: <20061010182107.20990.99745.sendpatchset@localhost.localdomain>
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 4/5] Change Documentation to reflect the new interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the interface definition of show_attribute() to use seq_file.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
--

 Documentation/filesystems/configfs/configfs.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18/Documentation/filesystems/configfs/configfs.txt
===================================================================
--- linux-2.6.18.orig/Documentation/filesystems/configfs/configfs.txt
+++ linux-2.6.18/Documentation/filesystems/configfs/configfs.txt
@@ -162,7 +162,7 @@ among other things.  For that, it needs 
 		void (*release)(struct config_item *);
 		ssize_t (*show_attribute)(struct config_item *,
 					  struct configfs_attribute *,
-					  char *);
+					  struct seq_file *);
 		ssize_t (*store_attribute)(struct config_item *,
 					   struct configfs_attribute *,
 					   const char *, size_t);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
