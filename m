Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272783AbTHKQtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTHKQtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:31 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:63576 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272783AbTHKQt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:28 -0400
To: gregkh@kroah.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add Minolta Dimage F300 to unusual_devs
Message-Id: <E19mFqq-00067w-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/unusual_devs.h linux-2.5/drivers/usb/storage/unusual_devs.h
--- bk-linus/drivers/usb/storage/unusual_devs.h	2003-08-04 01:00:30.000000000 +0100
+++ linux-2.5/drivers/usb/storage/unusual_devs.h	2003-08-06 18:59:43.000000000 +0100
@@ -388,6 +388,12 @@ UNUSUAL_DEV(  0x066b, 0x0105, 0x0100, 0x
 		US_FL_SINGLE_LUN ),
 #endif
 
+/* Submitted by Benny Sjostrand <benny@hostmobility.com> */
+UNUSUAL_DEV( 0x0686, 0x4011, 0x0001, 0x0001,
+		"Minolta",
+		"Dimage F300",
+		US_SC_SCSI, US_PR_BULK, NULL, 0 ),
+
 UNUSUAL_DEV(  0x0693, 0x0002, 0x0100, 0x0100, 
 		"Hagiwara",
 		"FlashGate SmartMedia",
