Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269791AbUJSQwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269791AbUJSQwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUJSQwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:52:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:53700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269789AbUJSQiq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:46 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038031335@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:45 -0700
Message-Id: <10982038054079@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.9, 2004/09/24 11:49:41-07:00, mochel@digitalimplant.org

[sysfs] Change symbol exports to GPL only in dir.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-10-19 09:21:32 -07:00
+++ b/fs/sysfs/dir.c	2004-10-19 09:21:32 -07:00
@@ -193,7 +193,7 @@
 	return error;
 }
 
-EXPORT_SYMBOL(sysfs_create_dir);
-EXPORT_SYMBOL(sysfs_remove_dir);
-EXPORT_SYMBOL(sysfs_rename_dir);
+EXPORT_SYMBOL_GPL(sysfs_create_dir);
+EXPORT_SYMBOL_GPL(sysfs_remove_dir);
+EXPORT_SYMBOL_GPL(sysfs_rename_dir);
 

