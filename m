Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbTH2UoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTH2Uly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:41:54 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:63177 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262196AbTH2Ulg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:41:36 -0400
Message-ID: <3F4FBAD0.2050607@terra.com.br>
Date: Fri, 29 Aug 2003 17:42:56 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: dhowells@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 2/3] Remove unneeded linux/version.h include from net/rxrpc
Content-Type: multipart/mixed;
 boundary="------------000806080205070507090200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000806080205070507090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi David,

	This patch is based on Randy's modified checkversion.pl, which 
detected an unneeded inclusion of linux/versio.h

	Please consider applying.

	Cheers,

Felipe

--------------000806080205070507090200
Content-Type: text/plain;
 name="krxiod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="krxiod.patch"

--- linux-2.6.0-test4/net/rxrpc/krxiod.c.orig	Fri Aug 29 17:36:05 2003
+++ linux-2.6.0-test4/net/rxrpc/krxiod.c	Fri Aug 29 17:36:40 2003
@@ -9,7 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>

--------------000806080205070507090200--

