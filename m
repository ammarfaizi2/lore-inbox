Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUHWTR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUHWTR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUHWTQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:16:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:4292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267259AbUHWSgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:51 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860873192@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <1093286087164@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.27, 2004/08/06 15:30:24-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Changed define for W1_FAMILY_SMEM.

  -#define W1_FAMILY_IBUT 0xff /* ? */
  +#define W1_FAMILY_SMEM 0x01

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_family.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h	2004-08-23 11:04:03 -07:00
+++ b/drivers/w1/w1_family.h	2004-08-23 11:04:03 -07:00
@@ -28,7 +28,7 @@
 
 #define W1_FAMILY_DEFAULT	0
 #define W1_FAMILY_THERM		0x10
-#define W1_FAMILY_IBUT		0xff /* ? */
+#define W1_FAMILY_SMEM		0x01
 
 #define MAXNAMELEN		32
 

