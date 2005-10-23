Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVJWL05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVJWL05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 07:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVJWL05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 07:26:57 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:1543 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750700AbVJWL04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 07:26:56 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki / ????)
Subject: Re: [BUG]NULL pointer dereference in ipv6_get_saddr()
Cc: yanzheng@21cn.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Organization: Core
In-Reply-To: <20051019.012157.11460212.yoshfuji@linux-ipv6.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1ETdyn-0005tM-00@gondolin.me.apana.org.au>
Date: Sun, 23 Oct 2005 21:25:33 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ???? <yoshfuji@linux-ipv6.org> wrote:
>
> I think this is already fixed in head.
> I don't remember if we pushed this to stable...

Yep it was fixed by c62dba9011b93fd88fde929848582b2a98309878.

I agree that we should've pushed it to stable.  Unfortunately it
might be too late now.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
