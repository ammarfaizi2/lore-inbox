Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbQLVFvw>; Fri, 22 Dec 2000 00:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbQLVFvn>; Fri, 22 Dec 2000 00:51:43 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:25871 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S131228AbQLVFvf>; Fri, 22 Dec 2000 00:51:35 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Configure.help for CONFIG_IRDA_OPTIONS 
Date: Thu, 21 Dec 2000 22:22:16 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00122122221600.19305@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a micropatch to provide a help note for CONFIG_IRDA_OPTIONS.
This applies against 2.4.0-test13-pre4.

Steven

diff -u linux/Documentation/Configure.help.orig 
linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig     Thu Dec 21 21:16:50 2000
+++ linux/Documentation/Configure.help  Thu Dec 21 21:17:12 2000
@@ -16677,6 +16677,10 @@
   want to compile it as a module, say M here and read
   Documentation/modules.txt.
 
+IrDA protocol options
+CONFIG_IRDA_OPTIONS
+  Say Y here if you want to configure any of the following IrDA options.
+
 IrDA Cache last LSAP
 CONFIG_IRDA_CACHE_LAST_LSAP
   Say Y here if you want IrLMP to cache the last LSAP used. This makes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
