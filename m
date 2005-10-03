Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVJCKhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJCKhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVJCKhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:37:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:52644 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932220AbVJCKhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:37:22 -0400
Date: Mon, 3 Oct 2005 12:37:21 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove module.h include from zlib_inflate
Message-ID: <20051003103721.GA23664@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no need to include module.h in inflate.c
compile-tested with 2.6.13

Signed-off-by: Olaf Hering <olh@suse.de>

 lib/zlib_inflate/inflate.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.14-rc3/lib/zlib_inflate/inflate.c
===================================================================
--- linux-2.6.14-rc3.orig/lib/zlib_inflate/inflate.c
+++ linux-2.6.14-rc3/lib/zlib_inflate/inflate.c
@@ -3,7 +3,6 @@
  * For conditions of distribution and use, see copyright notice in zlib.h 
  */
 
-#include <linux/module.h>
 #include <linux/zutil.h>
 #include "infblock.h"
 #include "infutil.h"
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
