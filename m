Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVCOPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVCOPkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVCOPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:40:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:22763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVCOPkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:40:10 -0500
Message-ID: <423701D4.3000607@osdl.org>
Date: Tue, 15 Mar 2005 07:40:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] w6692 eliminate bad section references
References: <20050313230639.GA24301@sputnik.stro.at> <42360DE5.3000600@osdl.org> <20050315133930.GC6680@sputnik.stro.at>
In-Reply-To: <20050315133930.GC6680@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> 
> thanks a lot for your review!
> you are right much better, added __init to W6692Version().
> 
> #Signed-off-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c
> linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c	2005-03-02 08:38:25.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c	2005-03-15 14:01:14.000000000 +0100
> @@ -49,7 +49,7 @@ static char *W6692Ver[] __initdata =
>  {"W6692 V00", "W6692 V01", "W6692 V10",
>   "W6692 V11"};
>  
> -static void
> +static void __init
>  W6692Version(struct IsdnCardState *cs, char *s)
>  {
>  	int val;


-- 
~Randy
