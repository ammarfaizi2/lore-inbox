Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCTQjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCTQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCTQjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 11:39:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:31934 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261232AbVCTQjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 11:39:21 -0500
Date: Sun, 20 Mar 2005 17:41:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][trivial] matroxfb_maven remove pointless semicolons after
 label
Message-ID: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having a semicolon at the end as in  labelname:;  is pointless, remove.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c
--- linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c	2005-03-20 17:35:48.000000000 +0100
@@ -1263,11 +1263,11 @@ static int maven_detect_client(struct i2
 	if (err)
 		goto ERROR4;
 	return 0;
-ERROR4:;
+ERROR4:
 	i2c_detach_client(new_client);
-ERROR3:;
+ERROR3:
 	kfree(new_client);
-ERROR0:;
+ERROR0:
 	return err;
 }
 


