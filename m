Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSKGWuZ>; Thu, 7 Nov 2002 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266646AbSKGWuZ>; Thu, 7 Nov 2002 17:50:25 -0500
Received: from intra.cyclades.com ([64.186.161.6]:39948 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S266645AbSKGWuP>; Thu, 7 Nov 2002 17:50:15 -0500
Message-ID: <018301c286b0$d66451a0$61a1ba40@Henrique>
From: "Henrique Gobbi" <henrique.gobbi@cyclades.com>
To: <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20021027013619.A5918@baldur.yggdrasil.com>
Subject: [Trivial Driver patch] - PC300 driver
Date: Thu, 7 Nov 2002 14:55:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please include this patch to the linux-2.5.46/drivers/net/wan/pc300_drv.c
file. It includes the MODULE_xxx macros.

thanks in advance
Henrique


--- linux-2.5.46/drivers/net/wan/pc300_drv.c.old     Thu Nov  7 22:42:12
2002
+++ linux-2.5.46/drivers/net/wan/pc300_drv.c   Thu Nov  7 22:42:19 2002
@@ -3687,3 +3687,9 @@

 module_init(cpc_init);
 module_exit(cpc_cleanup_module);
+
+MODULE_DESCRIPTION("Cyclades-PC300 cards driver");
+MODULE_AUTHOR(  "Author: Ivan Passos <ivan@cyclades.com>\r\n"
+                "Maintainer: Henrique Gobbi <henrique.gobbi@cyclades.com");
+MODULE_LICENSE("GPL");
+


