Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269709AbUJVGb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbUJVGb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUJSQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:54:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:50372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269777AbUJSQin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:43 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038054079@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:47 -0700
Message-Id: <10982038072700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.10, 2004/09/24 11:50:39-07:00, mochel@digitalimplant.org

[sysfs] Change symbol exports to GPL only in file.c.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/file.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-10-19 09:21:27 -07:00
+++ b/fs/sysfs/file.c	2004-10-19 09:21:27 -07:00
@@ -436,7 +436,7 @@
 }
 
 
-EXPORT_SYMBOL(sysfs_create_file);
-EXPORT_SYMBOL(sysfs_remove_file);
-EXPORT_SYMBOL(sysfs_update_file);
+EXPORT_SYMBOL_GPL(sysfs_create_file);
+EXPORT_SYMBOL_GPL(sysfs_remove_file);
+EXPORT_SYMBOL_GPL(sysfs_update_file);
 

