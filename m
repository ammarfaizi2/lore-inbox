Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTA0WW3>; Mon, 27 Jan 2003 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTA0WW3>; Mon, 27 Jan 2003 17:22:29 -0500
Received: from [192.58.209.91] ([192.58.209.91]:19684 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S267321AbTA0WW2>;
	Mon, 27 Jan 2003 17:22:28 -0500
From: George France <france@handhelds.org>
To: linux-kernel@vger.kernel.org
Subject: [Patch] Trivial  video/sis/sis_main.c fix for Alpha Arch 2.4.20-pre3
Date: Mon, 27 Jan 2003 17:31:36 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: thomas@winischhofer.net, Richard Henderson <rth@redhat.com>
MIME-Version: 1.0
Message-Id: <03012717313600.20518@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

A trivial little patch, I have been using for the Alpha Architecture since Linux
2.4.0.

Best Regards,


--George

----------  Forwarded Message  ----------
Subject: sis patch
Date: Fri, 24 Jan 2003 18:41:30 -0500
From: "France, George (LKG)" <george.france2@hp.com>
To: <france@handhelds.org>


--- linux/drivers/video/sis/sis_main.c-orig	Fri Jan 24 17:57:30 2003
+++ linux/drivers/video/sis/sis_main.c	Fri Jan 24 17:57:52 2003
@@ -41,7 +41,9 @@
 #include <linux/sisfb.h>

 #include <asm/io.h>
+#ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
+#endif

 #include <video/fbcon.h>
 #include <video/fbcon-cfb8.h>

-------------------------------------------------------
