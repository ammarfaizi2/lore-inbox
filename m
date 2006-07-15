Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945951AbWGOBVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945951AbWGOBVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWGOBVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 21:21:54 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:46855 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1945951AbWGOBVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 21:21:54 -0400
Date: Sat, 15 Jul 2006 11:21:41 +1000
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Crypto Bug Fix for 2.6.18
Message-ID: <20060715012141.GA13069@gondor.apana.org.au>
References: <20060620101719.GA13625@gondor.apana.org.au> <20060623235551.GA6647@gondor.apana.org.au> <20060626073942.GA2811@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626073942.GA2811@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git

or

master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git


It contains an important bug fix for padlock that's a new regression
since 2.6.17.

Michal Ludvig:
      [CRYPTO] padlock: Fix alignment after aes_ctx rearrange

 padlock-aes.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
