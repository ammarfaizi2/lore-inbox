Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQKQE7x>; Thu, 16 Nov 2000 23:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbQKQE7q>; Thu, 16 Nov 2000 23:59:46 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:4622 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130111AbQKQE73>; Thu, 16 Nov 2000 23:59:29 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_TOSHIBA Configure.help for 2.4.0
Date: Thu, 16 Nov 2000 21:29:37 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00111621293700.01299@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that for 2.4.0-testXX there was no help
for CONFIG_TOSHIBA, although there is for 2.2.17.

The following patch borrows the words for CONFIG_TOSHIBA
from the 2.2.17 Documentation/Configure.help. 
I checked that the URL referenced below is still valid, and it is.
And CONFIG_TOSHIBA is still used in several places in 
2.4.0-test11-pre6 code.

This patch applies against 2.4.0-test11-pre6. 

Steven

diff -u linux/Documentation/Configure.help.orig \
linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig     Thu Nov 16 20:36:15 2000
+++ linux/Documentation/Configure.help  Thu Nov 16 20:36:38 2000
@@ -13420,6 +13420,17 @@
   module, say M here and read Documentation/modules.txt. Most people
   will say N.
 
+Toshiba Laptop support
+CONFIG_TOSHIBA
+  If you intend to run this the kernel on a Toshiba portable say yes
+  here. This adds a driver to safely access the System Management
+  Mode of the CPU on Toshiba portables. The System Management Mode
+  is used to set the BIOS and power saving options on Toshiba portables.
+
+  For information on utilities to make use of this driver see the
+  Toshiba Linux utilities website at:
+  http://www.buzzard.org.uk/toshiba/
+
 /dev/cpu/microcode - Intel P6 CPU microcode support
 CONFIG_MICROCODE
   If you say Y here and also to "/dev file system support" in the
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
