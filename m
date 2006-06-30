Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWF3LrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWF3LrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWF3LrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:47:04 -0400
Received: from [64.62.148.172] ([64.62.148.172]:3858 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1750811AbWF3LrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:47:03 -0400
Date: Fri, 30 Jun 2006 21:46:00 +1000
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630114600.GA22537@gondor.apana.org.au>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu> <20060630111734.GA22202@gondor.apana.org.au> <20060630113758.GA18504@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630113758.GA18504@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 01:37:58PM +0200, Ingo Molnar wrote:
> 
> As you can see, the lock validator can easily cover completely new lock 
> types like sk_lock too, as long as the new lock type has some 
> minimalistic "works like a lock" properties. (such as owner-does-unlock)
> 
> later on i'll try the same cleanup for the mutex code too - it should be 
> possible. (that way the implementation of complex lock types can be 
> lock-validator checked too)

Yes, this looks very nice.  Thanks!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
