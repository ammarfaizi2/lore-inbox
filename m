Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVCXVYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVCXVYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVCXVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:24:32 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:27923 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261678AbVCXVW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:22:57 -0500
Date: Fri, 25 Mar 2005 08:20:57 +1100
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, johnpol@2ka.mipt.ru,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324212057.GB9396@gondor.apana.org.au>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324142540.GI24697@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324142540.GI24697@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:25:40AM -0500, Jean-Luc Cooke wrote:
> 
> If your RNG were properly written, it shouldn't matter if the data you're
> pumping into /dev/random passed muster or not.  If you're tracking entropy
> count, then that's a different story of course.

We're talking about hardware RNGs here so we need to take hardware faults
into account.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
