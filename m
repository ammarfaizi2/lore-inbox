Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVDHIA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVDHIA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVDHH7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:59:36 -0400
Received: from coderock.org ([193.77.147.115]:11488 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262733AbVDHHvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:19 -0400
Subject: [patch 5/8] printk : drivers/char/applicom.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, clucas@rotomalug.org
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:04 +0200
Message-Id: <20050408075104.8FDE11F39A@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/applicom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/applicom.c~printk-drivers_char_applicom drivers/char/applicom.c
--- kj/drivers/char/applicom.c~printk-drivers_char_applicom	2005-04-05 12:58:02.000000000 +0200
+++ kj-domen/drivers/char/applicom.c	2005-04-05 12:58:02.000000000 +0200
@@ -599,7 +599,7 @@ static ssize_t ac_read (struct file *fil
 
 #ifdef DEBUG
 		if (loopcount++ > 2) {
-			printk("Looping in ac_read. loopcount %d\n", loopcount);
+			printk(KERN_DEBUG "Looping in ac_read. loopcount %d\n", loopcount);
 		}
 #endif
 	} 
_
