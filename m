Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRI3Czt>; Sat, 29 Sep 2001 22:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272369AbRI3Czj>; Sat, 29 Sep 2001 22:55:39 -0400
Received: from sushi.toad.net ([162.33.130.105]:41427 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S272345AbRI3CzY>;
	Sat, 29 Sep 2001 22:55:24 -0400
Subject: [PATCH] Mwave MODULE_LICENSE etc.
To: linux-kernel@vger.kernel.org
Date: Sat, 29 Sep 2001 22:55:17 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010930025517.CA0696E2@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry if this is a repeat mail.  MTA probs.)
Here's a patch to add the MODULE_ stuff to the 
Mwave driver.                 // Thomas


--- linux-2.4.9-ac16/drivers/char/mwave/mwavedd.c	Fri Sep 28 22:24:14 2001
+++ linux-2.4.9-ac16-fix/drivers/char/mwave/mwavedd.c	Sat Sep 29 21:49:28 2001
@@ -71,6 +71,10 @@
 #define __exit
 #endif
 
+MODULE_DESCRIPTION("3780i Advanced Communications Processor (Mwave) driver");
+MODULE_AUTHOR("Mike Sullivan and Paul Schroeder");
+MODULE_LICENSE("GPL");
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static int mwave_get_info(char *buf, char **start, off_t offset, int len);
 #else
