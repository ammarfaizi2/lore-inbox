Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUGaD5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUGaD5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267905AbUGaD5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 23:57:52 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:17165 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267903AbUGaD5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 23:57:31 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: willy@w.ods.org (Willy Tarreau)
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Cc: herbert@gondor.apana.org.au, greearb@candelatech.com, akpm@osdl.org,
       alan@redhat.com, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040730121004.GA21305@alpha.home.local>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BqkzY-0003mK-00@gondolin.me.apana.org.au>
Date: Sat, 31 Jul 2004 13:57:04 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
>
>> Why is this a module parameter at all? Can't you set it using ifconfig?
> 
> no, because the driver has no change_mtu() function, so it uses the generic
> one, eth_change_mtu(), which is bound to 1500.

What is preventing you from implementing a change_mtu() function?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
