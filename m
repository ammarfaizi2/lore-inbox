Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966223AbWK2MH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966223AbWK2MH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935540AbWK2MH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:07:26 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:55818 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S935467AbWK2MHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:07:25 -0500
Date: Wed, 29 Nov 2006 23:07:09 +1100
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, gandalf@wlug.westbo.se
Subject: Re: [PATCH] lockdep: fix sk->sk_callback_lock locking
Message-ID: <20061129120709.GB22749@gondor.apana.org.au>
References: <E1GpKC4-0005Vc-00@gondolin.me.apana.org.au> <1164800544.6588.118.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164800544.6588.118.camel@twins>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 12:42:24PM +0100, Peter Zijlstra wrote:
> 
> However I'm not quite sure yet how to teach lockdep about this. The
> proposed patch will shut it up though.

As a rule I think we should never make semantic changes to shut up
lockdep.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
