Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTH2UfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTH2UdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:33:09 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:41088 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261850AbTH2UcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:22 -0400
Message-ID: <3F4FB8A7.60305@terra.com.br>
Date: Fri, 29 Aug 2003 17:33:43 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 5/5] remove unneeded linux/version.h from net/sunrpc
Content-Type: multipart/mixed;
 boundary="------------050403020601090901010906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403020601090901010906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch was based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------050403020601090901010906
Content-Type: text/plain;
 name="xprt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xprt.patch"

--- linux-2.6.0-test4/net/sunrpc/xprt.c.orig	Fri Aug 29 17:17:16 2003
+++ linux-2.6.0-test4/net/sunrpc/xprt.c	Fri Aug 29 17:18:05 2003
@@ -45,7 +45,6 @@
 
 #define __KERNEL_SYSCALLS__
 
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/capability.h>

--------------050403020601090901010906--

