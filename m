Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTH2URo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbTH2UIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:17 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:32738 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261562AbTH2UHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:07:49 -0400
Message-ID: <3F4FB2E4.5050702@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:08 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 5/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ipt_ULOG
Content-Type: multipart/mixed;
 boundary="------------090405060809040504090307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405060809040504090307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------090405060809040504090307
Content-Type: text/plain;
 name="ipt_ULOG.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipt_ULOG.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ipt_ULOG.c.orig	Fri Aug 29 16:46:04 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ipt_ULOG.c	Fri Aug 29 16:46:11 2003
@@ -36,7 +36,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/socket.h>

--------------090405060809040504090307--

