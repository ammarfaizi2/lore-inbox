Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUE1V2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUE1V2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUE1V1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:27:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:19629 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261981AbUE1V0o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:44 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <10857795543986@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:54 -0700
Message-Id: <10857795544179@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.2, 2004/05/17 17:28:58-07:00, rene.herman@keyaccess.nl

[PATCH] missing closing \n in printk


 drivers/firmware/smbios.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/firmware/smbios.c b/drivers/firmware/smbios.c
--- a/drivers/firmware/smbios.c	Fri May 28 14:18:27 2004
+++ b/drivers/firmware/smbios.c	Fri May 28 14:18:27 2004
@@ -126,7 +126,7 @@
 	if(keep_going != 0)
 		printk(KERN_INFO "Warning: SMBIOS table does not end with a"
 				" structure type 127. This may indicate a"
-				" truncated table.");
+				" truncated table.\n");
 
 	if(sdev->smbios_table_real_length != max_length)
 		printk(KERN_INFO "Warning: BIOS specified SMBIOS table length"

