Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269698AbUJVGb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbUJVGb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUJSQyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:54:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:51908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269781AbUJSQio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:44 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038103805@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:52 -0700
Message-Id: <1098203812166@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.12, 2004/09/24 11:52:50-07:00, mochel@digitalimplant.org

[sysfs] Change symbol exports to GPL only in symlink.c.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/symlink.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	2004-10-19 09:21:17 -07:00
+++ b/fs/sysfs/symlink.c	2004-10-19 09:21:17 -07:00
@@ -159,6 +159,6 @@
 		free_page((unsigned long)page);
 }
 
-EXPORT_SYMBOL(sysfs_create_link);
-EXPORT_SYMBOL(sysfs_remove_link);
+EXPORT_SYMBOL_GPL(sysfs_create_link);
+EXPORT_SYMBOL_GPL(sysfs_remove_link);
 

