Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTH2Urf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTH2UpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:45:22 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:12181 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262196AbTH2UmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:42:09 -0400
Message-ID: <3F4FBAF1.9090500@terra.com.br>
Date: Fri, 29 Aug 2003 17:43:29 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net, dhowells@redhat.com
Subject: [PATCH 3/3] Remove unneeded linux/version.h include from net/rxrpc
Content-Type: multipart/mixed;
 boundary="------------080405060506070509070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080405060506070509070106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi David,

	This patch is based on Randy's modified checkversion.pl, which 
detected an unneeded inclusion of linux/versio.h

	Please consider applying.

	Cheers,

Felipe

--------------080405060506070509070106
Content-Type: text/plain;
 name="krxtimod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="krxtimod.patch"

--- linux-2.6.0-test4/net/rxrpc/krxtimod.c.orig	Fri Aug 29 17:35:59 2003
+++ linux-2.6.0-test4/net/rxrpc/krxtimod.c	Fri Aug 29 17:36:30 2003
@@ -9,7 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>

--------------080405060506070509070106--

