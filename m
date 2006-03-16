Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752245AbWCPIUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbWCPIUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbWCPIUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:20:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43674
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752245AbWCPIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:20:30 -0500
Date: Thu, 16 Mar 2006 00:20:04 -0800 (PST)
Message-Id: <20060316.002004.97779505.davem@davemloft.net>
To: ioe-lkml@rameria.de
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] IPv6: Cleanups for net/ipv6/addrconf.c (kzalloc, early
 exit) v2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603102334.27590.ioe-lkml@rameria.de>
References: <20060212.021103.76157181.yoshfuji@linux-ipv6.org>
	<20060310.030258.55767431.davem@davemloft.net>
	<200603102334.27590.ioe-lkml@rameria.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>
Date: Fri, 10 Mar 2006 23:34:26 +0100

> Here are some possible (and trivial) cleanups.
> - use kzalloc() where possible
> - invert allocation failure test like
>   if (object) {
>         /* Rest of function here */
>   }
>   to
> 
>   if (object == NULL)
>         return NULL;
> 
>   /* Rest of function here */
> 
> Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied, thanks a lot Ingo.
