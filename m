Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWHLRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWHLRAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHLRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:00:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964889AbWHLRAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dHfWRDTOWU/vufheLDPjS/Vmg0sFuFDtFCWdEYjYVlt1rW9g1LDgmAgQkWfHpvS25YPaHc2JgPSnrMivrE9WgSO/Rh6dC0TerJ9JD3CLHVXtjSKaS2egDkxRlXmWHFfdCDCudvxZw9AzHYYr9NSVCKBZRMtrUm/IbooI6kRIgp8=
Message-ID: <44DE0962.9040603@gmail.com>
Date: Sat, 12 Aug 2006 19:01:22 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 1/10] drivers/video/sis/init301.h Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/init301.h linux-work/drivers/video/sis/init301.h
--- linux-work-clean/drivers/video/sis/init301.h	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/init301.h	2006-08-12 18:22:02.000000000 +0200
@@ -71,16 +71,9 @@
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

 static const unsigned char SiS_YPbPrTable[3][64] = {
   {


