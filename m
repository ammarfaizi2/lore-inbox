Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCYFta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCYFta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVCYFta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:49:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:16909 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261335AbVCYFtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:49:20 -0500
Date: Fri, 25 Mar 2005 16:46:34 +1100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325054634.GA22878@gondor.apana.org.au>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda> <42432596.2090709@pobox.com> <1111724759.23532.121.camel@uganda> <42439781.4080007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42439781.4080007@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 11:45:53PM -0500, Jeff Garzik wrote:
> 
> I agree with this sentiment; this is mainly a policy decision that 
> kernel programmers should not make.

Exactly.  Policy decisions like this as well as entropy checking
should be done in user-space.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
