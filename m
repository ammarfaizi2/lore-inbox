Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTICOZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTICOZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:25:32 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:5010 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262344AbTICOZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:25:19 -0400
Message-ID: <3F55FA27.9030008@terra.com.br>
Date: Wed, 03 Sep 2003 11:26:47 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kill unneeded version.h in net/wanrouter
Content-Type: multipart/mixed;
 boundary="------------030308070608040103060703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308070608040103060703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Patch against linux-2.6.0-test4.

	Please apply.

	Thanks,

Felipe

--------------030308070608040103060703
Content-Type: text/plain;
 name="wanrouter-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wanrouter-checkversion.patch"

diff -u -X ./dontdiff linux-2.6.0-test4/net/wanrouter/af_wanpipe.c linux-2.6.0-test4-fwd/net/wanrouter/af_wanpipe.c
--- linux-2.6.0-test4/net/wanrouter/af_wanpipe.c	Fri Aug 22 21:01:48 2003
+++ linux-2.6.0-test4-fwd/net/wanrouter/af_wanpipe.c	Wed Sep  3 11:05:45 2003
@@ -32,7 +32,6 @@
 *
 ******************************************************************************/
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff -u -X ./dontdiff linux-2.6.0-test4/net/wanrouter/wanmain.c linux-2.6.0-test4-fwd/net/wanrouter/wanmain.c
--- linux-2.6.0-test4/net/wanrouter/wanmain.c	Fri Aug 22 20:57:53 2003
+++ linux-2.6.0-test4-fwd/net/wanrouter/wanmain.c	Wed Sep  3 11:05:33 2003
@@ -42,7 +42,6 @@
 * Jun 02, 1999  Gideon Hack	Updates for Linux 2.0.X and 2.2.X kernels.
 *****************************************************************************/
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */

--------------030308070608040103060703--

