Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWIWMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWIWMqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWIWMqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:46:37 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:21252 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751098AbWIWMqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:46:37 -0400
Date: Sat, 23 Sep 2006 22:46:33 +1000
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, herbert@gondor.apana.org
Subject: Re: [PATCH]: Fix ALIGN() macro
Message-ID: <20060923124633.GA2567@gondor.apana.org.au>
References: <20060922.223136.41635862.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922.223136.41635862.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 10:31:36PM -0700, David Miller wrote:
>
> I'm still trying to track down the other regression added by
> the crypto merge.  I have it git bisected down to a single
> changeset, but I haven't determined what's really wrong yet.
> I should be able to kill that over the weekend.  I want to fix
> this before merging my networking tree so I can be absolutely
> sure that IPSEC doesn't break because of something in my tree :)

Thanks for fixing this Dave.  I recall being bitten earlier
by the same thing as well.  I really need to start testing
on 64-bit.

BTW could you describe the other regression?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
