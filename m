Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVC2KwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVC2KwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVC2KtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:49:12 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:19470 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262343AbVC2KrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:47:22 -0500
Date: Tue, 29 Mar 2005 20:46:27 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329104627.GD19468@gondor.apana.org.au>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz> <20050329103049.GB19541@gondor.apana.org.au> <1112093428.5243.88.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112093428.5243.88.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 02:50:28PM +0400, Evgeniy Polyakov wrote:
>
> Without ability speed this up in kernel, we completely [ok, almost] 
> loose all RNG advantages.

Well if you can demonstrate that you're getting a higher rate of
throughput from your RNG by doing this in kernel space vs. doing
it in user space please let me know.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
