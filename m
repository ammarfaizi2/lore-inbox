Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTHaXuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTHaXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:50:54 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:20100 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263057AbTHaXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:50:53 -0400
Message-ID: <002a01c3701a$3cc65f80$0600a8c0@air>
From: "Adrian Levi" <hoarder@optushome.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22 drivers/char/ip2main.c
Date: Mon, 1 Sep 2003 09:47:12 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unused variable rc in function ip2_init_board(int).
I am not subscribed to lkml, please cc comments to hoarder@optushome.com.au.

--- /home/adrian/linux/drivers/char/ip2main.c 2003-09-01 09:43:40.000000000
+1000
+++ /home/adrian/linux-2.4.22/drivers/char/ip2main.c 2002-11-29
09:53:12.000000000 +1000
@@ -988,7 +988,7 @@
 static void __init
 ip2_init_board( int boardnum )
 {
- int i;
+ int i,rc;
  int nports = 0, nboxes = 0;
  i2ChanStrPtr pCh;
  i2eBordStrPtr pB = i2BoardPtrTable[boardnum];


