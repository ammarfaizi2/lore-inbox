Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWIZFiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWIZFiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWIZFiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:07 -0400
Received: from mail.suse.de ([195.135.220.2]:41185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751278AbWIZFiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:05 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/47] Documentation/ABI: devfs is not obsolete, but removed!
Date: Mon, 25 Sep 2006 22:37:21 -0700
Message-Id: <1159249087369-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <20060926053728.GA8970@kroah.com>
References: <20060926053728.GA8970@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jens m. noedler <noedler@web.de>

Signed-off-by: Jens M. Noedler <noedler@web.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/ABI/{obsolete => removed}/devfs |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/removed/devfs
similarity index 73%
rename from Documentation/ABI/obsolete/devfs
rename to Documentation/ABI/removed/devfs
index b8b8739..8195c4e 100644
--- a/Documentation/ABI/obsolete/devfs
+++ b/Documentation/ABI/removed/devfs
@@ -1,13 +1,12 @@
 What:		devfs
-Date:		July 2005
+Date:		July 2005 (scheduled), finally removed in kernel v2.6.18
 Contact:	Greg Kroah-Hartman <gregkh@suse.de>
 Description:
 	devfs has been unmaintained for a number of years, has unfixable
 	races, contains a naming policy within the kernel that is
 	against the LSB, and can be replaced by using udev.
-	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
+	The files fs/devfs/*, include/linux/devfs_fs*.h were removed,
 	along with the the assorted devfs function calls throughout the
 	kernel tree.
 
 Users:
-
-- 
1.4.2.1

