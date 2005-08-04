Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVHDRpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVHDRpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVHDRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:45:30 -0400
Received: from mx.winch-hebergement.net ([82.196.5.104]:28066 "EHLO
	mx.ifrance.com") by vger.kernel.org with ESMTP id S262486AbVHDRoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:44:09 -0400
Message-ID: <42F25352.8050805@winch-hebergement.net>
Date: Thu, 04 Aug 2005 19:41:38 +0200
From: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
References: <42EDDE50.6050800@winch-hebergement.net> <20050804033329.GA14501@gondor.apana.org.au> <20050804103523.GA11381@gondor.apana.org.au>
In-Reply-To: <20050804103523.GA11381@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Herbert Xu wrote:
> On Thu, Aug 04, 2005 at 01:33:29PM +1000, herbert wrote:
> 
>>So I suppose we should reset cwnd_quota after tcp_transmit_skb?
> 
> Please try this patch to see if this is really the problem or not.
> 
> Thanks,

I just applied your patch, and it seems to work :)
2 hours uptime, and no crash yet (without the patch, it was crashing a 
few mins only after booting).
So i think the bug is crushed :)

Thanks a lot !

-- 
Guillaume Pelat
