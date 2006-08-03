Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWHCKAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWHCKAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWHCKAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 06:00:45 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:35078 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932454AbWHCKAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 06:00:44 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: tytso@mit.edu (Theodore Tso)
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
       mchan@broadcom.com
Organization: Core
In-Reply-To: <20060803075704.GC27835@thunk.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
Date: Thu, 03 Aug 2006 20:00:35 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> wrote:
> 
> I'm sending this on mostly because it was a bit of a pain to track down,
> and hopefully it will save time if anyone else hits this while playing
> with the -rt kernel.  It is NOT the right way to fix things, so please
> don't even think of applying this patch (unless you need it, in your own
> local tree :-).
> 
> One of these days when we have time to breath we'll look into fixing
> this the right way, if someone doesn't beat us to it first.  :-)

You probably should resend the patch to netdev and Michael Chan
<mchan@broadcom.com>.  He might have ideas on how this could be
avoided.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
