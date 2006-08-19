Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWHSKTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWHSKTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWHSKTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:19:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:10210 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751697AbWHSKTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:19:23 -0400
Date: Sat, 19 Aug 2006 12:17:17 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: penberg@cs.Helsinki.FI, akpm@osdl.org, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: [PATCH 5/7] ip1000: Modify coding style of ipg_config_autoneg()
Message-ID: <20060819101717.GA26267@electric-eye.fr.zoreil.com>
References: <1155844061.5006.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155844061.5006.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang <jesse@icplus.com.tw> :
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> This is only coding style modify for ipg_config_autoneg(). Thanks for the
> suggestion form Francois.
> 
> Change Logs:
>     Modify coding style of ipg_config_autoneg()
> 
> ---
> 
>  drivers/net/ipg.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> 737498ca620437d8179e21be4d5220333066cbbd
> diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
> index f859107..be96f93 100644
> --- a/drivers/net/ipg.c
> +++ b/drivers/net/ipg.c
> @@ -491,11 +491,13 @@ static int ipg_config_autoneg(struct net
>  	int fullduplex;
>  	int txflowcontrol;
>  	int rxflowcontrol;
> +	long MacCtrlValue;

Mixed case variables are not exactly welcome.

-- 
Ueimor
