Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUAFBGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUAFBGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:06:40 -0500
Received: from [193.138.115.2] ([193.138.115.2]:36365 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265940AbUAFBGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:06:36 -0500
Date: Tue, 6 Jan 2004 02:03:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH] correct kgdb.txt Documentation link (against
 2.6.1-rc1-mm2)
Message-ID: <Pine.LNX.4.56.0401060156570.7407@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The help text for "config KGDB" in arch/i386/Kconfig refers to
Documentation/i386/kgdb.txt - the actual location is
Documentation/i386/kgdb/kgdb.txt - patch below to fix that.


--- linux-2.6.1-rc1-mm2-orig/arch/i386/Kconfig  2004-01-06 01:33:04.000000000 +0100
+++ linux-2.6.1-rc1-mm2/arch/i386/Kconfig       2004-01-06 02:03:31.000000000 +0100
@@ -1334,7 +1334,7 @@
 	  will then break as soon as it looks at the boot options.  This
 	  option also installs a breakpoint in panic and sends any
 	  kernel faults to the debugger. For more information see the
-	  Documentation/i386/kgdb.txt file.
+	  Documentation/i386/kgdb/kgdb.txt file.

 choice
 	depends on KGDB




Kind regards,

Jesper Juhl

