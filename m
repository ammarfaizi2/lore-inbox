Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbTHURbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbTHURbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:11718 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262843AbTHURa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:30:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870703538@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870701587@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:10 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285.1.4, 2003/08/20 16:49:58-07:00, greg@kroah.com

Video: fix broken saa7111.c driver due to i2c structure changes.


 drivers/media/video/saa7111.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	Thu Aug 21 10:21:02 2003
+++ b/drivers/media/video/saa7111.c	Thu Aug 21 10:21:02 2003
@@ -55,7 +55,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
-#define I2C_NAME(s) (s)->dev.name
+#define I2C_NAME(s) (s)->name
 
 #include <linux/video_decoder.h>
 

