Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWIWMzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWIWMzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWIWMzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:55:04 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:38148 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751018AbWIWMzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:55:02 -0400
Date: Sat, 23 Sep 2006 22:54:59 +1000
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, herbert@gondor.apana.org
Subject: Re: [PATCH]: Fix ALIGN() macro
Message-ID: <20060923125458.GA2682@gondor.apana.org.au>
References: <20060922.223136.41635862.davem@davemloft.net> <20060923124633.GA2567@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923124633.GA2567@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 10:46:33PM +1000, herbert wrote:
>
> Thanks for fixing this Dave.  I recall being bitten earlier
> by the same thing as well.  I really need to start testing
> on 64-bit.
> 
> BTW could you describe the other regression?

Nevermind, I saw your note on IRC.  If you haven't found the
problem yet, could you pleas try modprobe tcrypt mode=100?

That should better pin-point the problem.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
