Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423751AbWJ0EAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423751AbWJ0EAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423753AbWJ0EAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:00:21 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:13575 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1423751AbWJ0EAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:00:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: lkml@newipnet.com (Carlos Velasco)
Subject: Re: Networking messed up, bad checksum, incorrect length
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <454181D1.1040904@newipnet.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GdItF-0002uT-00@gondolin.me.apana.org.au>
Date: Fri, 27 Oct 2006 14:00:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Velasco <lkml@newipnet.com> wrote:
> 
> And a question... how this TSO affects netfilter?

netfilter will see the jumbo frames rather than the individual packets.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
