Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUHML4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUHML4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUHMLzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:55:43 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:3085 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264373AbUHMLzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:55:16 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bunk@fs.tum.de (Adrian Bunk)
Subject: Re: [2.6 patch] CONFIG_MII requires only CONFIG_NET
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040813102202.GT13377@fs.tum.de>
X-Newsgroups: apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1Bvaau-00077D-00@gondolin.me.apana.org.au>
Date: Fri, 13 Aug 2004 21:51:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
> 
> But trying it out CONFIG_MII=y seems to at least compile with 
> CONFIG_NET_ETHERNET=n.
> 
> @Jeff:
> It seems, CONFIG_MII doesn't actually require CONFIG_NET_ETHERNET?
> Could you comment on the following patch?

Are there non-Ethernet drivers that use MII? If not what's the point?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
