Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbQKLGKr>; Sun, 12 Nov 2000 01:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbQKLGKh>; Sun, 12 Nov 2000 01:10:37 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:56836 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130154AbQKLGK3>; Sun, 12 Nov 2000 01:10:29 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Addition to ECN documentation in Configure.help
Date: Sat, 11 Nov 2000 23:10:24 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00111123102400.01425@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a little patchlet which adds to the new documentation
for CONFIG_INET_ECN in Configure.help.  This patch applies to 
2.4.0-test11-pre3.  

         Steven

diff -urN linux/Documentation/Configure.help.orig \
linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig     Sat Nov 11 21:41:55 2000
+++ linux/Documentation/Configure.help  Sat Nov 11 22:50:31 2000
@@ -2067,6 +2067,14 @@
   writing) you will have to disable this option, either by saying N now
   or by using the sysctl.

+  ECN may be disabled with:
+  echo 0 > /proc/sys/net/ipv4/tcp_ecn
+
+  ECN may be re-enabled with:
+  echo 1 > /proc/sys/net/ipv4/tcp_ecn
+
+  Explicit Congestion Notification is more fully documented in RFC2481.
+
   If in doubt, say N.

 SYN flood protection
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
