Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUATC6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbUATAAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:00:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:13996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264961AbUASX74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:56 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567592337@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:20 -0800
Message-Id: <10745567602050@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.6, 2004/01/14 11:13:34-08:00, khali@linux-fr.org

[PATCH] I2C: saa7146.h doesn't need i2c.h


 drivers/media/video/saa7146.h |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/media/video/saa7146.h b/drivers/media/video/saa7146.h
--- a/drivers/media/video/saa7146.h	Mon Jan 19 15:32:24 2004
+++ b/drivers/media/video/saa7146.h	Mon Jan 19 15:32:24 2004
@@ -25,7 +25,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#include <linux/i2c.h>
 #include <linux/videodev.h>
 
 #ifndef O_NONCAP  

