Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWJPXE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWJPXE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWJPXE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:04:59 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22744 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161157AbWJPXE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:04:58 -0400
Date: Tue, 17 Oct 2006 01:00:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Matt LaPlante <kernel1@cyberdogtech.com>,
       Linus Torvalds <torvalds@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typos in doc and comments (2)
In-Reply-To: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0610170058250.30479@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Changes persistant -> persistent. www.dictionary.com does not know 
>persistant (with an A), but should it be one of those things you can 
>spell in more than one correct way, let me know.

Changes persistant -> persistent in actual C code. (part 1 changed 
docs/comments).

Compile-tested.


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.19-rc2/drivers/isdn/hisax/isdnl2.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/isdnl2.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/isdnl2.c
@@ -1442,7 +1442,7 @@ l2_tei_remove(struct FsmInst *fi, int ev
 }
 
 static void
-l2_st14_persistant_da(struct FsmInst *fi, int event, void *arg)
+l2_st14_persistent_da(struct FsmInst *fi, int event, void *arg)
 {
 	struct PStack *st = fi->userdata;
 	
@@ -1453,7 +1453,7 @@ l2_st14_persistant_da(struct FsmInst *fi
 }
 
 static void
-l2_st5_persistant_da(struct FsmInst *fi, int event, void *arg)
+l2_st5_persistent_da(struct FsmInst *fi, int event, void *arg)
 {
 	struct PStack *st = fi->userdata;
 
@@ -1466,7 +1466,7 @@ l2_st5_persistant_da(struct FsmInst *fi,
 }
 
 static void
-l2_st6_persistant_da(struct FsmInst *fi, int event, void *arg)
+l2_st6_persistent_da(struct FsmInst *fi, int event, void *arg)
 {
 	struct PStack *st = fi->userdata;
 
@@ -1477,7 +1477,7 @@ l2_st6_persistant_da(struct FsmInst *fi,
 }
 
 static void
-l2_persistant_da(struct FsmInst *fi, int event, void *arg)
+l2_persistent_da(struct FsmInst *fi, int event, void *arg)
 {
 	struct PStack *st = fi->userdata;
 
@@ -1612,14 +1612,14 @@ static struct FsmNode L2FnList[] __initd
 	{ST_L2_6, EV_L2_FRAME_ERROR, l2_frame_error},
 	{ST_L2_7, EV_L2_FRAME_ERROR, l2_frame_error_reest},
 	{ST_L2_8, EV_L2_FRAME_ERROR, l2_frame_error_reest},
-	{ST_L2_1, EV_L1_DEACTIVATE, l2_st14_persistant_da},
+	{ST_L2_1, EV_L1_DEACTIVATE, l2_st14_persistent_da},
 	{ST_L2_2, EV_L1_DEACTIVATE, l2_st24_tei_remove},
 	{ST_L2_3, EV_L1_DEACTIVATE, l2_st3_tei_remove},
-	{ST_L2_4, EV_L1_DEACTIVATE, l2_st14_persistant_da},
-	{ST_L2_5, EV_L1_DEACTIVATE, l2_st5_persistant_da},
-	{ST_L2_6, EV_L1_DEACTIVATE, l2_st6_persistant_da},
-	{ST_L2_7, EV_L1_DEACTIVATE, l2_persistant_da},
-	{ST_L2_8, EV_L1_DEACTIVATE, l2_persistant_da},
+	{ST_L2_4, EV_L1_DEACTIVATE, l2_st14_persistent_da},
+	{ST_L2_5, EV_L1_DEACTIVATE, l2_st5_persistent_da},
+	{ST_L2_6, EV_L1_DEACTIVATE, l2_st6_persistent_da},
+	{ST_L2_7, EV_L1_DEACTIVATE, l2_persistent_da},
+	{ST_L2_8, EV_L1_DEACTIVATE, l2_persistent_da},
 };
 
 #define L2_FN_COUNT (sizeof(L2FnList)/sizeof(struct FsmNode))
#<EOF>


	-`J'
-- 
