Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbTH2Ulp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTH2Ulo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:41:44 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:64912 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262147AbTH2Ule
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:41:34 -0400
Message-ID: <3F4FBACD.8030901@terra.com.br>
Date: Fri, 29 Aug 2003 17:42:53 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: dhowells@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 1/3] Remove unneeded linux/version.h include from net/rxrpc
Content-Type: multipart/mixed;
 boundary="------------090103050801090108010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103050801090108010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi David,

	This patch is based on Randy's modified checkversion.pl, which 
detected an unneeded inclusion of linux/versio.h

	Please consider applying.

	Cheers,

Felipe

--------------090103050801090108010805
Content-Type: text/plain;
 name="krxsecd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="krxsecd.patch"

--- linux-2.6.0-test4/net/rxrpc/krxsecd.c.orig	Fri Aug 29 17:35:52 2003
+++ linux-2.6.0-test4/net/rxrpc/krxsecd.c	Fri Aug 29 17:36:23 2003
@@ -14,7 +14,6 @@
  * - responding to security challenges on outbound connections
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/completion.h>

--------------090103050801090108010805--

