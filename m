Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTIIRDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTIIRDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:03:00 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:24713 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S264239AbTIIRCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:02:41 -0400
Message-ID: <3F5E012C.1090100@terra.com.br>
Date: Tue, 09 Sep 2003 13:34:52 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kill unneeded include in net/wanrouter
Content-Type: multipart/mixed;
 boundary="------------080409090608070109000601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080409090608070109000601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

	(This is a resend, since it wasn't applied against -test4).

	Patch against 2.6-test5.

	Based on Randy's checkversion.pl script.

Felipe

--------------080409090608070109000601
Content-Type: text/plain;
 name="wanrouter-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wanrouter-checkversion.patch"

diff -u -rN linux-2.6.0-test5/net/wanrouter/af_wanpipe.c linux-2.6.0-test5-fwd/net/wanrouter/af_wanpipe.c
--- linux-2.6.0-test5/net/wanrouter/af_wanpipe.c	Mon Sep  8 16:50:38 2003
+++ linux-2.6.0-test5-fwd/net/wanrouter/af_wanpipe.c	Tue Sep  9 11:57:40 2003
@@ -32,7 +32,6 @@
 *
 ******************************************************************************/
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff -u -rN linux-2.6.0-test5/net/wanrouter/wanmain.c linux-2.6.0-test5-fwd/net/wanrouter/wanmain.c
--- linux-2.6.0-test5/net/wanrouter/wanmain.c	Mon Sep  8 16:50:16 2003
+++ linux-2.6.0-test5-fwd/net/wanrouter/wanmain.c	Tue Sep  9 11:57:35 2003
@@ -42,7 +42,6 @@
 * Jun 02, 1999  Gideon Hack	Updates for Linux 2.0.X and 2.2.X kernels.
 *****************************************************************************/
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */

--------------080409090608070109000601--

