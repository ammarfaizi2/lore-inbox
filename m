Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUCULHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbUCULHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:07:04 -0500
Received: from relay-2m.club-internet.fr ([194.158.104.41]:61320 "EHLO
	relay-2m.club-internet.fr") by vger.kernel.org with ESMTP
	id S263631AbUCULHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:07:02 -0500
From: pinotj@club-internet.fr
To: webcam@smcc.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.x] Compilation warning in pwc-if.c
Date: Sun, 21 Mar 2004 12:07:01 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1079867221.17273.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to fix a compilation warning in pwc-if.c

Regards,

Jerome Pinot

diff -Nru a/drivers/usb/media/pwc-if.c b/drivers/usb/media/pwc-if.c
--- a/drivers/usb/media/pwc-if.c	2004-03-11 11:55:37.000000000 +0900
+++ b/drivers/usb/media/pwc-if.c	2004-03-17 14:14:58.000000000 +0900
@@ -1121,6 +1121,7 @@
 static int pwc_video_release(struct video_device *vfd)
 {
 	Trace(TRACE_OPEN, "pwc_video_release() called. Now what?\n");
+	return 0;
 }
 		
 

