Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUHZIHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUHZIHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUHZIHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:07:52 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:42738 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S266845AbUHZIDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:03:43 -0400
Subject: [PATCH] Or as we say, "cramfs"
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1093507185.29321.2513.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 17:59:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Use Name cramfs in Kconfig Message
Status: Untested
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

A senior kernel hacker couldn't find the cramfs option.  No wonder,
the message doesn't mention cramfs at all.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9580-linux-2.6.9-rc1-bk1/fs/Kconfig .9580-linux-2.6.9-rc1-bk1.updated/fs/Kconfig
--- .9580-linux-2.6.9-rc1-bk1/fs/Kconfig	2004-08-25 09:53:58.000000000 +1000
+++ .9580-linux-2.6.9-rc1-bk1.updated/fs/Kconfig	2004-08-26 17:56:13.000000000 +1000
@@ -1213,7 +1213,7 @@ config JFFS2_CMODE_SIZE
 endchoice
 
 config CRAMFS
-	tristate "Compressed ROM file system support"
+	tristate "Compressed ROM file system support (cramfs)"
 	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for CramFs (Compressed ROM File

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

