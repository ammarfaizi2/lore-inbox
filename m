Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVC2MqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVC2MqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVC2MqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:46:05 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:51472 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262285AbVC2Mpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:45:55 -0500
Date: Tue, 29 Mar 2005 22:43:22 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329124322.GA20543@gondor.apana.org.au>
References: <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz> <20050329103049.GB19541@gondor.apana.org.au> <1112093428.5243.88.camel@uganda> <20050329104627.GD19468@gondor.apana.org.au> <1112096525.5243.98.camel@uganda> <20050329113921.GA20174@gondor.apana.org.au> <1112098517.5243.102.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112098517.5243.102.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 04:15:17PM +0400, Evgeniy Polyakov wrote:
> > > On Tue, 2005-03-29 at 20:46 +1000, Herbert Xu wrote:
> > 
> > > > Well if you can demonstrate that you're getting a higher rate of
> > > > throughput from your RNG by doing this in kernel space vs. doing
> > > > it in user space please let me know.
>
> > Well when you get 55mb/s from /dev/random please get back to me.
> 
> I cant, noone writes 55mbit into it, but HW RNG drivers could. :)

Are you intending to feed that into /dev/random at 55mb/s?

If not then how is this an argument against doing it in userspace
through rngd?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
