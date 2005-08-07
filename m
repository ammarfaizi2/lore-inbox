Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752787AbVHGVbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbVHGVbH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbVHGVbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:31:06 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:5344 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1752787AbVHGVbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:31:06 -0400
Date: Mon, 8 Aug 2005 07:30:23 +1000
To: John B?ckstrand <sandos@home.se>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050807213023.GA20342@gondor.apana.org.au>
References: <42F38B67.5040308@home.se> <20050805.093208.74729918.davem@davemloft.net> <20050806022435.GB12862@gondor.apana.org.au> <20050806075717.GA18104@gondor.apana.org.au> <42F60BE3.6040301@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F60BE3.6040301@home.se>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 03:25:55PM +0200, John B?ckstrand wrote:
> 
> [148475.651000] ------------[ cut here ]------------
> [148475.651050] kernel BUG at net/ipv4/tcp_output.c:918!

Yes, as Andrew said, this bug should be fixed in the latest git tree.
So please test with that plus the debugging patch to see if you can
reproduce the assertion again.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
