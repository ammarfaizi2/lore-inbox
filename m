Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVCVCsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVCVCsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCVCrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:47:19 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:19603 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262288AbVCVCnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:43:50 -0500
Date: Mon, 21 Mar 2005 21:43:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [DVB patch 22/48] nxt2002: fix max frequency
In-reply-to: <20050322013457.300618000@abc>
To: linux-kernel@vger.kernel.org
Cc: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>
Reply-to: gene.heskett@verizon.net
Message-id: <200503212143.43518.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050322013427.919515000@abc> <20050322013457.300618000@abc>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 20:23, Johannes Stezenbach wrote:
>Patch by Taylor Jacob and Tom Dombrosky: There was a typo in the
> BBTI/B2C2 specs that stated the upper frequency of the
> air2pc/nxt2002 was 806Mhz, not 860Mhz.
>
Thanks, although I hadn't discovered it yet, waiting for market 166 to 
go live sometime this year I hope.

>Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
>
> nxt2002.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c
>===================================================================
>---
> linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt2002.c 200
>5-03-22 00:15:13.000000000 +0100 +++
> linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c	2005-03-
>22 00:17:45.000000000 +0100 @@ -671,7 +671,7 @@ static struct
> dvb_frontend_ops nxt2002_o .name = "Nextwave nxt2002 VSB/QAM
> frontend",
> 		.type = FE_ATSC,
> 		.frequency_min =  54000000,
>-		.frequency_max = 806000000,
>+		.frequency_max = 860000000,
>                 /* stepsize is just a guess */
> 		.frequency_stepsize = 166666,
> 		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
>
>--
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
