Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVHKMdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVHKMdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVHKMdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:33:19 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:57287 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1030282AbVHKMdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:33:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: master@sectorb.msk.ru (Vladimir B. Savkin)
Subject: Re: 2.6.13-rc5 panic with tg3, e1000, vlan, tso
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20050811114835.GB3543@tentacle.sectorb.msk.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1E3CFD-0005ZN-00@gondolin.me.apana.org.au>
Date: Thu, 11 Aug 2005 22:33:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin <master@sectorb.msk.ru> wrote:
> 
> Today my gateway crashed.
> I wrote down crash info on a paper.
> It's not complete since only last 25 lines were shown,
> but complete stackdump is here (I omitted hexadecimal values).
> 
> Call Trace: <IRQ>
>    tcp_write_xmit+318

This should be fixed in rc6.  Please give that a go.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
