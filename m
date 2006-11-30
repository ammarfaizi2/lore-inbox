Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967987AbWK3Xv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967987AbWK3Xv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967988AbWK3Xv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:51:59 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:11024 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S967987AbWK3Xv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:51:58 -0500
Date: Fri, 1 Dec 2006 10:51:49 +1100
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.19
Message-ID: <20061130235149.GA11266@gondor.apana.org.au>
References: <20061130012600.0dcb1337@laptop.hypervisor.org> <E1GptFQ-0002Yy-00@gondolin.me.apana.org.au> <20061130233259.69e0cfb0@laptop.hypervisor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130233259.69e0cfb0@laptop.hypervisor.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:32:59PM +0100, Udo A. Steinberg wrote:
> 
> I didn't and that turned out to be the culprit. With CONFIG_CRYPTO_CBC enabled
> everything works fine. Thanks, Herbert!
> 
> Shouldn't cryptoloop automatically select CONFIG_CRYPTO_CBC if it depends on it?

Yes I'll make it select CONFIG_CRYPTO_CBC since that's the default
chaining method.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
