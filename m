Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWC1Q5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWC1Q5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC1Q5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:57:03 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:33808 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750967AbWC1Q5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:57:01 -0500
Date: Tue, 28 Mar 2006 18:56:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rlove@rlove.org>
Subject: Re: patch : hdaps on Thinkpad R52
Message-Id: <20060328185659.5272b631.khali@linux-fr.org>
In-Reply-To: <200603260035.59316.arekm@maven.pl>
References: <20060314205758.GA9229@gevaerts.be>
	<20060325210946.GZ4053@stusta.de>
	<200603260035.59316.arekm@maven.pl>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arkadiusz,

> Here is a patch for Z60m. hdaps seems working fine - pivot utility reports values
> that match description by R. Love sent to this ml few months ago.
> 
> Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
> 
> --- linux-2.6.16/drivers/hwmon/hdaps.c.org	2006-03-26 00:30:53.000000000 +0100
> +++ linux-2.6.16/drivers/hwmon/hdaps.c	2006-03-26 00:31:30.000000000 +0100
> @@ -528,6 +528,7 @@
>  		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
>  		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41 Tablet"),
>  		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
> +		HDAPS_DMI_MATCH_NORMAL("ThinkPad Z60m"),
>  		{ .ident = NULL }
>  	};

OK, I grabbed this, and will merge it into another patch altering the
same device list.

Thanks,
-- 
Jean Delvare
