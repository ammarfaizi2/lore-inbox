Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKUCOH>; Mon, 20 Nov 2000 21:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbQKUCN5>; Mon, 20 Nov 2000 21:13:57 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:269 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129231AbQKUCNv>; Mon, 20 Nov 2000 21:13:51 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_TOSHIBA Configure.help for 2.4.0-test11
Date: Mon, 20 Nov 2000 18:44:06 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00112018440600.00911@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that for 2.4.0-test11 there is no help
for CONFIG_TOSHIBA, although there is for 2.2.17.

The following patch borrows the words for CONFIG_TOSHIBA
from the 2.2.17 Documentation/Configure.help, dropping
an extraneous "the" from the first line.

This patch applies to 2.4.0-test11.

Steven

diff -u linux/Documentation/Configure.help.orig \
linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig     Mon Nov 20 18:26:27 2000
+++ linux/Documentation/Configure.help  Mon Nov 20 18:26:46 2000
@@ -13420,6 +13420,17 @@
   module, say M here and read Documentation/modules.txt. Most people
   will say N.

+Toshiba Laptop support
+CONFIG_TOSHIBA
+  If you intend to run this kernel on a Toshiba portable say yes
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
