Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVAHHMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVAHHMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVAHHKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:10:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:59525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261892AbVAHFsa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:30 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632574140@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <11051632572250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.45, 2005/01/06 16:38:08-08:00, akpm@osdl.org

[PATCH] debugfs-typo-fix

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/debugfs.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/debugfs.h b/include/linux/debugfs.h
--- a/include/linux/debugfs.h	2005-01-07 15:39:26 -08:00
+++ b/include/linux/debugfs.h	2005-01-07 15:39:26 -08:00
@@ -82,7 +82,7 @@
 						 struct dentry *parent,
 						 u8 *value)
 {
-	return EFF_PTR(-ENODEV);
+	return ERR_PTR(-ENODEV);
 }
 
 #endif

