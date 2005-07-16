Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVGPUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVGPUjM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVGPUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 16:39:12 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:14915 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261877AbVGPUjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 16:39:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Xr1XorI/8cwHDZr8Sm0AVrRMVOwfHxu7/g4f+Yes0bC3XtPOshoeKgZz7CxvMtrJlqKKz3o+XBpyxljfZJJ1fCyqNyD2NWHSx495iBL3HZ+xPkMbmcDnZXYGQ88xezgGXQGIJl/LEA0ccV2cVyxIjcKVmmmNdgmTBSjZNduCDew=
Date: Sun, 17 Jul 2005 00:46:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lib/int_sqrt.c: speedup compilation
Message-ID: <20050716204621.GA17510@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It uses only EXPORT_SYMBOL, so...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/int_sqrt.c |    2 --
 1 files changed, 2 deletions(-)

--- linux-vanilla/lib/int_sqrt.c	2005-07-16 02:05:11.000000000 +0400
+++ linux-int_sqrt/lib/int_sqrt.c	2005-07-16 03:11:38.000000000 +0400
@@ -1,5 +1,3 @@
-
-#include <linux/kernel.h>
 #include <linux/module.h>
 
 /**

