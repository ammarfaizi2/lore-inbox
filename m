Return-Path: <linux-kernel-owner+w=401wt.eu-S1752712AbWLVVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbWLVVEt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWLVVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:04:49 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:2722 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752712AbWLVVEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:04:48 -0500
Date: Sat, 23 Dec 2006 08:04:46 +1100
To: Martin Willi <martin@strongswan.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] xfrm: Algorithm lookup using .compat name
Message-ID: <20061222210446.GB22568@gondor.apana.org.au>
References: <1166804803.21634.40.camel@martin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166804803.21634.40.camel@martin>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 05:26:43PM +0100, Martin Willi wrote:
> Installing an IPsec SA using old algorithm names (.compat) does not work
> if the algorithm is not already loaded. When not using the PF_KEY
> interface, algorithms are not preloaded in xfrm_probe_algs() and
> installing a IPsec SA fails.

Good catch.  Thanks Martin!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
