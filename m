Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTGNOmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270062AbTGNOmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:42:52 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:39910 "EHLO
	crl-mail.crl.dec.com") by vger.kernel.org with ESMTP
	id S265870AbTGNOmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:42:12 -0400
Subject: [PATCH] jffs2 super.o for 2.6.0-test1
From: Jamey Hicks <jamey.hicks@hp.com>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org
Content-Type: text/plain
Organization: 
Message-Id: <1058194498.3333.100.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 14 Jul 2003 10:54:58 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-0.1,
	required 5, PATCH_UNIFIED_DIFF, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial patch to reenable jffs2 for 2.6.0-test1.

-Jamey



diff -ur linux-2.6.0-test1/fs/jffs2/Makefile
linux-2.6.0-test1-rmk0-hh0/fs/jffs2/Makefile
--- linux-2.6.0-test1/fs/jffs2/Makefile 2003-06-22 14:32:37.000000000
-0400
+++ linux-2.6.0-test1-rmk0-hh0/fs/jffs2/Makefile        2003-07-14
09:42:27.000000000 -0400
@@ -13,6 +13,7 @@
 
 LINUX_OBJS-24  := super-v24.o crc32.o
 LINUX_OBJS-25  := super.o
+LINUX_OBJS-26  := super.o
 
 NAND_OBJS-$(CONFIG_JFFS2_FS_NAND)      := wbuf.o
 


