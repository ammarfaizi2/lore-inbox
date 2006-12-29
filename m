Return-Path: <linux-kernel-owner+w=401wt.eu-S1754070AbWL2F3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbWL2F3Z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbWL2F3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:29:25 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38169
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754070AbWL2F3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:29:24 -0500
Date: Thu, 28 Dec 2006 21:28:51 -0800 (PST)
Message-Id: <20061228.212851.93211529.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: martin@strongswan.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] xfrm: Algorithm lookup using .compat name
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061222210446.GB22568@gondor.apana.org.au>
References: <1166804803.21634.40.camel@martin>
	<20061222210446.GB22568@gondor.apana.org.au>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 23 Dec 2006 08:04:46 +1100

> On Fri, Dec 22, 2006 at 05:26:43PM +0100, Martin Willi wrote:
> > Installing an IPsec SA using old algorithm names (.compat) does not work
> > if the algorithm is not already loaded. When not using the PF_KEY
> > interface, algorithms are not preloaded in xfrm_probe_algs() and
> > installing a IPsec SA fails.
> 
> Good catch.  Thanks Martin!

Applied.

Martin, please be careful with future patch submissions, your
email client corrupted up the patch by adding newlines and
changing tab characters into spaces, so I had to add the patch
by hand.

Herbert, this fix is only needed for 2.6.20 correct?  I assume
it was added by the 2.6.20 crypto layer merge, right?

Thanks.
