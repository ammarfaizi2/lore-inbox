Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTH2UcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTH2UcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:32:24 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:49133 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261757AbTH2UcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:10 -0400
Message-ID: <3F4FB89B.5060508@terra.com.br>
Date: Fri, 29 Aug 2003 17:33:31 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 2/5] remove unneeded linux/version.h from net/sunrpc
Content-Type: multipart/mixed;
 boundary="------------090909010305070405050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090909010305070405050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch was based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------090909010305070405050609
Content-Type: text/plain;
 name="svcsock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="svcsock.patch"

--- linux-2.6.0-test4/net/sunrpc/svcsock.c.orig	Fri Aug 29 17:16:38 2003
+++ linux-2.6.0-test4/net/sunrpc/svcsock.c	Fri Aug 29 17:17:44 2003
@@ -27,7 +27,6 @@
 #include <linux/inet.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
-#include <linux/version.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>

--------------090909010305070405050609--

