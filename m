Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTH2UKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTH2UIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:46 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:56288 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262013AbTH2UHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:07:37 -0400
Message-ID: <3F4FB2D3.1040709@terra.com.br>
Date: Fri, 29 Aug 2003 17:08:51 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Cc: netfilter-devel@lists.netfilter.org
Subject: [PATCH 1/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_conntrack_core.c
Content-Type: multipart/mixed;
 boundary="------------000806080403040002080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000806080403040002080607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------000806080403040002080607
Content-Type: text/plain;
 name="ip_conntrack_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_conntrack_core.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_conntrack_core.c.orig	Fri Aug 29 16:42:56 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_conntrack_core.c	Fri Aug 29 16:43:04 2003
@@ -13,7 +13,6 @@
  *	- export ip_conntrack[_expect]_{find_get,put} functions
  * */
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/icmp.h>

--------------000806080403040002080607--

