Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVCMEKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVCMEKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVCMEIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:08:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19718 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262725AbVCMDys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:54:48 -0500
Date: Sun, 13 Mar 2005 04:54:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: fritz@isdn4linux.de, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/act2000/capi.c: #if 0 an unused function
Message-ID: <20050313035446.GZ3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's an unused function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Feb 2005

 drivers/isdn/act2000/capi.c |    2 ++
 drivers/isdn/act2000/capi.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/act2000/capi.h.old	2005-02-05 15:07:29.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/act2000/capi.h	2005-02-05 15:07:35.000000000 +0100
@@ -350,7 +350,6 @@
 extern int actcapi_chkhdr(act2000_card *, actcapi_msghdr *);
 extern int actcapi_listen_req(act2000_card *);
 extern int actcapi_manufacturer_req_net(act2000_card *);
-extern int actcapi_manufacturer_req_v42(act2000_card *, ulong);
 extern int actcapi_manufacturer_req_errh(act2000_card *);
 extern int actcapi_manufacturer_req_msn(act2000_card *);
 extern int actcapi_connect_req(act2000_card *, act2000_chan *, char *, char, int, int);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/act2000/capi.c.old	2005-02-05 15:07:42.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/act2000/capi.c	2005-02-05 15:08:02.000000000 +0100
@@ -224,6 +224,7 @@
 /*
  * Switch V.42 on or off
  */
+#if 0
 int
 actcapi_manufacturer_req_v42(act2000_card *card, ulong arg)
 {
@@ -242,6 +243,7 @@
 	ACTCAPI_QUEUE_TX;
         return 0;
 }
+#endif  /*  0  */
 
 /*
  * Set error-handler

