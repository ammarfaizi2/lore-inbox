Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbTH2UKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTH2UIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:55 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:49314 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262072AbTH2UIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:08:09 -0400
Message-ID: <3F4FB2F6.1070107@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:26 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 7/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_nat_helper
Content-Type: multipart/mixed;
 boundary="------------090807070407030300040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807070407030300040301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------090807070407030300040301
Content-Type: text/plain;
 name="ip_nat_helper.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_nat_helper.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_helper.c.orig	Fri Aug 29 16:45:27 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_helper.c	Fri Aug 29 16:45:31 2003
@@ -12,7 +12,6 @@
  *		- make ip_nat_resize_packet more generic (TCP and UDP)
  *		- add ip_nat_mangle_udp_packet
  */
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kmod.h>

--------------090807070407030300040301--

