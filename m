Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbTH2UNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTH2UIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:39 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:23265 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262020AbTH2UHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:07:40 -0400
Message-ID: <3F4FB2DC.50006@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:00 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 2/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_conntrack_standalone
Content-Type: multipart/mixed;
 boundary="------------030207070504020807030206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207070504020807030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------030207070504020807030206
Content-Type: text/plain;
 name="ip_conntrack_standalone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_conntrack_standalone.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_conntrack_standalone.c.orig	Fri Aug 29 16:44:23 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_conntrack_standalone.c	Fri Aug 29 16:44:28 2003
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
-#include <linux/version.h>
 #include <net/checksum.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_conntrack_lock)

--------------030207070504020807030206--

