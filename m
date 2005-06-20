Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFTAG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFTAG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVFTAG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:06:27 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6673 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261346AbVFTAGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:06:24 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: 2.6.12: connection tracking broken?
Cc: netfilter-devel@manty.net, rankincj@yahoo.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net
Organization: Core
In-Reply-To: <42B56D9B.9070401@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
Date: Mon, 20 Jun 2005 10:05:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
>
> The bridge-netfilter code defers calling of some NF_IP_* hooks to the
> bridge layer, when the conntrack reference is already gone, so the entry

Why does it defer them at all? Shouldn't the fact that the device is
bridged be transparent to the IP layer?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
