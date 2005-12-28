Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVL1JGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVL1JGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVL1JGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:06:15 -0500
Received: from zoe.ndcservers.net ([204.10.38.178]:32191 "EHLO
	zoe.ndcservers.net") by vger.kernel.org with ESMTP id S932504AbVL1JGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:06:14 -0500
Message-ID: <026801c60b8d$ef128360$6501a8c0@ndciwkst01>
From: "Shaun" <mailinglists@unix-scripts.com>
To: "DervishD" <lkml@dervishd.net>
Cc: <linux-kernel@vger.kernel.org>
References: <dotjb6$j8$1@sea.gmane.org> <20051228085328.GA25380@DervishD>
Subject: Re: Memory, where's it going?
Date: Wed, 28 Dec 2005 01:06:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zoe.ndcservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unix-scripts.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand the concept and why things are cached, i've just never seen it 
cache this much before.. usually on a machine with bearly anything running 
on it (like this one) it uses bearly any memory at all.  My concern is that 
with bearly anything running on it i already have dug into swap.

Thanks for the responce, i just wanted to make sure their wasnt some type of 
a memory bug.

~Shaun
----- Original Message ----- 
From: "DervishD" <lkml@dervishd.net>
To: "Shaun" <mailinglists@unix-scripts.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 28, 2005 12:53 AM
Subject: Re: Memory, where's it going?


>    Hi Shaun :)
>
> * Shaun <mailinglists@unix-scripts.com> dixit:
>> I see that free shows that 7.7GB is cached and i'm not sure why so
>> much is cached.
>
>    Because free memory is a *waste* of memory. Why leaving unused
> memory when it can be used for caching? The kernel will (up to some
> extent, I suppose) try to use all free memory for caching if no app
> needs it.
>
>    If you have 8GB of memory, it's a bit difficult to fill it just
> with the running apps, so the kernel cleverly uses the rest for
> caching things so the system runs faster.
>
>    For example, I have 1GB of RAM, and even when I use X (seldom...)
> I never eat up more than, let's say, 500MB. So, I have another 500MB
> of memory unused: the kernel uses it as cache, and that makes my
> system run much faster (I noticed a speed increase when I switch from
> 512 to 1G).
>
>    Raúl Núñez de Arenas Coronado
>
> -- 
> Linux Registered User 88736 | http://www.dervishd.net
> http://www.pleyades.net & http://www.gotesdelluna.net
> It's my PC and I'll cry if I want to...
> 

