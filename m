Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWDINHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWDINHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 09:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWDINHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 09:07:34 -0400
Received: from ns.suse.de ([195.135.220.2]:49626 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750745AbWDINHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 09:07:33 -0400
Date: Sun, 9 Apr 2006 15:07:30 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/isdn/capi/capiutil.c: unexport capi_message2str
Message-ID: <20060409130730.GA27948@pingi.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
References: <20060407211736.GO7118@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407211736.GO7118@stusta.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 11:17:36PM +0200, Adrian Bunk wrote:
> This patch removes an unused EXPORT_SYMBOL.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c.old	2006-04-07 10:47:30.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c	2006-04-07 10:47:37.000000000 +0200
> @@ -855,5 +855,4 @@
>  EXPORT_SYMBOL(capi_cmsg_header);
>  EXPORT_SYMBOL(capi_cmd2str);
>  EXPORT_SYMBOL(capi_cmsg2str);
> -EXPORT_SYMBOL(capi_message2str);
>  EXPORT_SYMBOL(capi_info2str);
> 

Yes it is currently unused, but part of the CAPI driver SDK for supporting
debug messages in capi drivers, so I would tend to let it exported, if here
are not strong arguments against exporting it.

-- 
Karsten Keil
SuSE Labs
ISDN development
