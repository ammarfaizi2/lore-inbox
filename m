Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQKNAhw>; Mon, 13 Nov 2000 19:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbQKNAhn>; Mon, 13 Nov 2000 19:37:43 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:37643 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129566AbQKNAhf>; Mon, 13 Nov 2000 19:37:35 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_EISA note in Documentation/Configure.help
Date: Mon, 13 Nov 2000 17:07:22 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00111317072200.00727@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed there was no help section for CONFIG_EISA in Configure.help.
Here is a micro patch.  Hope this is not "really superfluous" this time.

	Steven

diff -urN linux/Documentation/Configure.help.orig 
linux/DocumentationConfigure.help
--- linux/Documentation/Configure.help.orig     Sat Nov 11 21:41:55 2000
+++ linux/Documentation/Configure.help  Mon Nov 13 16:53:45 2000
@@ -2482,6 +2482,20 @@
   Documentation/mca.txt (and especially the web page given there)
   before attempting to build an MCA bus kernel.

+EISA support
+CONFIG_EISA
+  The Extended Industry Standard Architecture (EISA) bus was
+  developed as an open alternative to the IBM MicroChannel bus.
+
+  The EISA bus provided some of the features of the IBM MicroChannel
+  bus while maintaining backward compatibility with cards made for
+  the older ISA bus. The EISA bus saw limited use between 1988 and 1995
+  when it was made obsolete by the PCI bus.
+
+  Say Y here if you are building a kernel for an EISA-based machine.
+
+  Otherwise, say N.
+
 SGI Visual Workstation support
 CONFIG_VISWS
   The SGI Visual Workstation series is an IA32-based workstation
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
