Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbTH2UiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTH2Uci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:32:38 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:3464 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261767AbTH2UcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:14 -0400
Message-ID: <3F4FB89F.9090902@terra.com.br>
Date: Fri, 29 Aug 2003 17:33:35 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 3/5] remove unneeded linux/version.h from net/sunrpc
Content-Type: multipart/mixed;
 boundary="------------020106030502080701080200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106030502080701080200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch was based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------020106030502080701080200
Content-Type: text/plain;
 name="sysctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysctl.patch"

--- linux-2.6.0-test4/net/sunrpc/sysctl.c.orig	Fri Aug 29 17:17:07 2003
+++ linux-2.6.0-test4/net/sunrpc/sysctl.c	Fri Aug 29 17:17:49 2003
@@ -8,7 +8,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/linkage.h>
 #include <linux/ctype.h>

--------------020106030502080701080200--

