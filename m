Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbTH2USS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTH2USI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:18:08 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:63902 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262012AbTH2UIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:08:15 -0400
Message-ID: <3F4FB2FB.1050900@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:31 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 9/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_nat_standalone
Content-Type: multipart/mixed;
 boundary="------------070201010204040400000500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201010204040400000500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------070201010204040400000500
Content-Type: text/plain;
 name="ip_nat_standalone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_nat_standalone.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_standalone.c.orig	Fri Aug 29 16:44:54 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_standalone.c	Fri Aug 29 16:45:01 2003
@@ -23,7 +23,6 @@
 #include <linux/proc_fs.h>
 #include <net/checksum.h>
 #include <linux/spinlock.h>
-#include <linux/version.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_nat_lock)
 #define ASSERT_WRITE_LOCK(x) MUST_BE_WRITE_LOCKED(&ip_nat_lock)

--------------070201010204040400000500--

