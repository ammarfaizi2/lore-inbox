Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbULGTgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbULGTgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbULGTgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:36:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37131 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261903AbULGTfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:19 -0500
Date: Tue, 7 Dec 2004 20:35:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB uhci-debug.c: remove an unused function (fwd)
Message-ID: <20041207193510.GY7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:30:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: stern@rowland.harvard.edu
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB uhci-debug.c: remove an unused function

The patch below removes an unused function from 
drivers/usb/host/uhci-debug.c


diffstat output:
 drivers/usb/host/uhci-debug.c |   11 -----------
 1 files changed, 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c.old	2004-10-28 23:30:40.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c	2004-10-28 23:30:49.000000000 +0200
@@ -34,17 +34,6 @@
 	}
 }
 
-static inline int uhci_is_skeleton_qh(struct uhci_hcd *uhci, struct uhci_qh *qh)
-{
-	int i;
-
-	for (i = 0; i < UHCI_NUM_SKELQH; i++)
-		if (qh == uhci->skelqh[i])
-			return 1;
-
-	return 0;
-}
-
 static int uhci_show_td(struct uhci_td *td, char *buf, int len, int space)
 {
 	char *out = buf;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

