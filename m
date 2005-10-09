Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVJISTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVJISTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJISTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:19:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:1422 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932180AbVJISTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:19:34 -0400
Date: Sun, 9 Oct 2005 18:19:33 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/13] ppc64 boot: remove include from lib/zlib_inflate/inflate.c
Message-ID: <20051009181933.1.VzVQu29099.29065.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20051009181931.0.IoWCk29070.29065.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no need to include module.h in inflate.c

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
