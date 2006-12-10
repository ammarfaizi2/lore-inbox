Return-Path: <linux-kernel-owner+w=401wt.eu-S1757734AbWLJBL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbWLJBL3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 20:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLJBL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 20:11:29 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:3070 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757734AbWLJBL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 20:11:28 -0500
Date: Sun, 10 Dec 2006 12:10:57 +1100
To: Andrew Donofrio <linuxbugzilla@kriptik.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] crypto: add sha384 hmac and sha512 hmac tests to tcrypt in 2.6.19 kernel
Message-ID: <20061210011057.GA14580@gondor.apana.org.au>
References: <457902EE.5000203@kriptik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457902EE.5000203@kriptik.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 01:15:10AM -0500, Andrew Donofrio wrote:
> This patch adds tests for SHA384 HMAC and SHA512 HMAC to the tcrypt module. Test data was taken from
> RFC4231. This patch is a follow-up to the discovery (bug 7646) that the kernel SHA384 HMAC
> implementation was not generating proper SHA384 HMACs.
> 
> Signed-off-by: Andrew Donofrio <linuxbugzilla@kriptik.org>

I've applied the patch to cryptodev-2.6 with some editorial changes.

Thanks!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
