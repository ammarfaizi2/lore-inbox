Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265849AbVBFAbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbVBFAbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbVBFAbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:31:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45328 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265849AbVBFA04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:26:56 -0500
Date: Sun, 6 Feb 2005 01:26:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: fritz@isdn4linux.de
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/act2000/capi.c: #if 0 an unused function
Message-ID: <20050206002653.GH3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's an unused function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

