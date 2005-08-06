Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVHFIBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVHFIBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 04:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVHFH6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:58:35 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:51411 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S262003AbVHFH5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:57:24 -0400
Date: Sat, 6 Aug 2005 17:57:17 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: sandos@home.se, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050806075717.GA18104@gondor.apana.org.au>
References: <42F38B67.5040308@home.se> <20050805.093208.74729918.davem@davemloft.net> <20050806022435.GB12862@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806022435.GB12862@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 12:24:35PM +1000, herbert wrote:
> On Fri, Aug 05, 2005 at 09:32:08AM -0700, David S. Miller wrote:
> > 
> > It therefore may be desirable to keep Herbert's fix in there, but
> > back out my changes until they can be reimplemented correctly.
> > 
> > Herbert?
> 
> Sure.  Let's back it out until a better solution is found.

Hang on a second, the original poster mentioned rc5.  Is this really
pristine rc5 with the one netpoll patch? If so then it can't be the
patches we're talking about because they only went in days later.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
