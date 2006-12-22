Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbWLVVRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWLVVRw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLVVRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:17:52 -0500
Received: from nlpi012.sbcis.sbc.com ([207.115.36.41]:17800 "EHLO
	nlpi012.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbWLVVRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:17:51 -0500
X-ORBL: [67.117.73.34]
Date: Fri, 22 Dec 2006 13:17:54 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061222211754.GU2449@atomide.com>
References: <20061222105521.GA23683@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061222105521.GA23683@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [061222 02:55]:
> Hi!
> 
> This is not yet complete set. set_map() is missing in latest kernels.
> 
> Fix DECLARE_WORK()-change-related compilation problems. Please apply,
>
> --- a/drivers/mmc/omap.c
> +++ b/drivers/mmc/omap.c
> @@ -2,7 +2,7 @@
>   *  linux/drivers/media/mmc/omap.c
>   *
>   *  Copyright (C) 2004 Nokia Corporation
> - *  Written by Tuukka Tikkanen and Juha Yrjölä<juha.yrjola@nokia.com>
> + *  Written by Tuukka Tikkanen and Juha Yrjölä <juha.yrjola@nokia.com>
>   *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
>   *  Other hacks (DMA, SD, etc) by David Brownell
>   *

I already applied similar fixes to linux-omap for the workqueue changes,
so I only applied the MMC typo fix above.

Regards,

Tony
