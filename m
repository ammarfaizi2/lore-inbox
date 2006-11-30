Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031511AbWK3VP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031511AbWK3VP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031516AbWK3VP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:15:59 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:11788 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1031511AbWK3VP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:15:57 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: us15@os.inf.tu-dresden.de (Udo A. Steinberg)
Subject: Re: Linux 2.6.19
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061130012600.0dcb1337@laptop.hypervisor.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GptFQ-0002Yy-00@gondolin.me.apana.org.au>
Date: Fri, 01 Dec 2006 08:15:12 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg <us15@os.inf.tu-dresden.de> wrote:
> 
> Ok, so 2.6.18 used to get along fine with cryptoloop and 2.6.19 refuses to
> cooperate. An strace of "losetup -e aes /dev/loop0 /dev/hda7" without all the
> terminal interaction shows:

Did you enable CONFIG_CRYPTO_CBC?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
