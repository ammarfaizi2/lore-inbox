Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHUD1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHUD1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWHUD1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:27:47 -0400
Received: from msr48.hinet.net ([168.95.4.148]:3539 "EHLO msr48.hinet.net")
	by vger.kernel.org with ESMTP id S932096AbWHUD1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:27:47 -0400
Message-ID: <005301c6c4d1$ad9e9ce0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <penberg@cs.Helsinki.FI>, <akpm@osdl.org>, <dvrabel@cantab.net>,
       <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <david@pleyades.net>
References: <1155844061.5006.13.camel@localhost.localdomain> <20060819101717.GA26267@electric-eye.fr.zoreil.com>
Subject: Re: [PATCH 5/7] ip1000: Modify coding style of ipg_config_autoneg()
Date: Mon, 21 Aug 2006 11:27:06 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :

Ok, I will remove the Mixed case variables. Thanks.

Jesse
----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <penberg@cs.Helsinki.FI>; <akpm@osdl.org>; <dvrabel@cantab.net>;
<linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<david@pleyades.net>
Sent: Saturday, August 19, 2006 6:17 PM
Subject: Re: [PATCH 5/7] ip1000: Modify coding style of ipg_config_autoneg()


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
>  int fullduplex;
>  int txflowcontrol;
>  int rxflowcontrol;
> + long MacCtrlValue;

Mixed case variables are not exactly welcome.

-- 
Ueimor


