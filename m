Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWHLRBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWHLRBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHLRBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:01:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964901AbWHLRBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:01:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=N70jVNAxh7258o6Ri8uFRlKPYc9FvkieR+6S0zSJ5cWozourqPmvhVDqQ2QTTob29ZV8MAGK9Co1s2APP/TORKnPmdnEsD6RkiAHf73zqYnUvYuZMSEKvbdViDgx/zvULpnowe1QH6ybL3+xBjGO96e6sYbObguH/+2aCdmqhdA=
Message-ID: <44DE0977.1080705@gmail.com>
Date: Sat, 12 Aug 2006 19:01:43 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 4/10] drivers/video/sis/osdef.h Removal of old code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/osdef.h linux-work/drivers/video/sis/osdef.h
--- linux-work-clean/drivers/video/sis/osdef.h	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/osdef.h	2006-08-12 18:19:47.000000000 +0200
@@ -100,11 +100,7 @@
 #define SIS315H
 #endif

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 #define SIS_LINUX_KERNEL_26
-#else
-#define SIS_LINUX_KERNEL_24
-#endif

 #if !defined(SIS300) && !defined(SIS315H)
 #warning Neither CONFIG_FB_SIS_300 nor CONFIG_FB_SIS_315 is set


