Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWHLRBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWHLRBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWHLRBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:01:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964860AbWHLRA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:00:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=geZACpUU2Uir/vP1/E1RuhNibpA6Yp3yHagycep/g6GxWczC0IgnDOacDi6Our2capNJS+JCX0ipVJLnUFrJtkOeVYL0Df9lzUIzuylpcxO3X/Hd2yOu8HSbKozWWQ4v1Oj/m7lqmJnqaX7wgPWS5avKluFw2kr8Z8APuWlIm9U=
Message-ID: <44DE096E.2050107@gmail.com>
Date: Sat, 12 Aug 2006 19:01:34 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 3/10] drivers/video/sis/init.h Removal of old code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/init.h linux-work/drivers/video/sis/init.h
--- linux-work-clean/drivers/video/sis/init.h	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/init.h	2006-08-12 18:22:33.000000000 +0200
@@ -77,16 +77,9 @@
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/fb.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <video/fbcon.h>
-#endif
 #include "sis.h"
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <linux/sisfb.h>
-#else
 #include <video/sisfb.h>
 #endif
-#endif

 /* Mode numbers */
 static const unsigned short ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};

