Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTH2USS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbTH2UR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:17:59 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:14499 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262073AbTH2UIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:08:12 -0400
Message-ID: <3F4FB2F8.1000109@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:28 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 8/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_nat_rule
Content-Type: multipart/mixed;
 boundary="------------060708000805010105090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060708000805010105090102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------060708000805010105090102
Content-Type: text/plain;
 name="ip_nat_rule.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_nat_rule.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_rule.c.orig	Fri Aug 29 16:45:09 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_rule.c	Fri Aug 29 16:45:14 2003
@@ -9,7 +9,6 @@
 #include <linux/proc_fs.h>
 #include <net/checksum.h>
 #include <linux/bitops.h>
-#include <linux/version.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_nat_lock)
 #define ASSERT_WRITE_LOCK(x) MUST_BE_WRITE_LOCKED(&ip_nat_lock)

--------------060708000805010105090102--

