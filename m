Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVH1G53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVH1G53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 02:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVH1G53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 02:57:29 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:10115 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751118AbVH1G53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 02:57:29 -0400
Message-ID: <43115DE5.2070806@kromtek.com>
Date: Sun, 28 Aug 2005 10:47:01 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH] missing include in tda80xx
References: <20050828024750.GF9322@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050828024750.GF9322@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
>----
>diff -urN RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c current/drivers/media/dvb/frontends/tda80xx.c
>--- RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c	2005-08-24 01:56:38.000000000 -0400
>+++ current/drivers/media/dvb/frontends/tda80xx.c	2005-08-27 22:36:10.000000000 -0400
>@@ -30,6 +30,7 @@
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/slab.h>
>+#include <asm/irq.h>
> #include <asm/div64.h>
> 
> #include "dvb_frontend.h"
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

A suggestion, to avoid a regression, it would've been better if you had 
a CC to the DVB maintainer also, in case it got missed out during 
backporting mainline changes back to the DVB CVS tree.


Thanks,
Manu


