Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTH2UcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTH2UcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:32:15 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:55686 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261712AbTH2UcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:06 -0400
Message-ID: <3F4FB894.30701@terra.com.br>
Date: Fri, 29 Aug 2003 17:33:24 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 1/5] remove unneeded linux/version.h from net/sunrpc
Content-Type: multipart/mixed;
 boundary="------------040100050801060500070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040100050801060500070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch was based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------040100050801060500070902
Content-Type: text/plain;
 name="rpc_pipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rpc_pipe.patch"

--- linux-2.6.0-test4/net/sunrpc/rpc_pipe.c.orig	Fri Aug 29 17:26:05 2003
+++ linux-2.6.0-test4/net/sunrpc/rpc_pipe.c	Fri Aug 29 17:17:32 2003
@@ -10,7 +10,6 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pagemap.h>

--------------040100050801060500070902--

