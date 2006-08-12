Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWHLRC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWHLRC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWHLRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:02:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964910AbWHLRCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:02:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WQOfvoKFRyTYvTmo4BnZdaIiNWYPnBNEKs3O9XJPL0EtxzpCBUoFDM9c5Z4n16/gfVEkaw3mZLs9qJlHG0183YA76a8sqecTDW6lN65jRkLxEk8gFaNRyd4KWk91i8bs5vSCJ33jbSQrlmLYnc/1AfZeNoeyxC96wPoEhKQuar8=
Message-ID: <44DE09C3.8070102@gmail.com>
Date: Sat, 12 Aug 2006 19:02:59 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 9/10] drivers/video/sis/vgatypes.h Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/vgatypes.h linux-work/drivers/video/sis/vgatypes.h
--- linux-work-clean/drivers/video/sis/vgatypes.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-work/drivers/video/sis/vgatypes.h	2006-08-12 17:53:39.000000000 +0200
@@ -73,12 +73,10 @@ typedef unsigned int BOOLEAN;

 #ifdef SIS_LINUX_KERNEL
 typedef unsigned long SISIOADDRESS;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
 #include <linux/types.h>  /* Need __iomem */
 #undef SISIOMEMTYPE
 #define SISIOMEMTYPE __iomem
 #endif
-#endif

 #ifdef SIS_XORG_XF86
 #if XF86_VERSION_CURRENT < XF86_VERSION_NUMERIC(4,2,0,0,0)



