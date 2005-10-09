Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVJIST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVJIST4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJISTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:19:55 -0400
Received: from ns.suse.de ([195.135.220.2]:1934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932194AbVJISTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:19:35 -0400
Date: Sun, 9 Oct 2005 18:19:34 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/13] ppc64 boot: remove include from include/linux/zutil.h
Message-ID: <20051009181934.2.pxElh29123.29065.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20051009181931.0.IoWCk29070.29065.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zutil.h does not need errno.h

Signed-off-by: Olaf Hering <olh@suse.de>

 include/linux/zutil.h |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.14-rc3/include/linux/zutil.h
===================================================================
--- linux-2.6.14-rc3.orig/include/linux/zutil.h
+++ linux-2.6.14-rc3/include/linux/zutil.h
@@ -15,7 +15,6 @@
 
 #include <linux/zlib.h>
 #include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/kernel.h>
 
 typedef unsigned char  uch;
