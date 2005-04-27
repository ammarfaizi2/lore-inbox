Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVD0KbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVD0KbS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVD0KbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:31:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53776 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261369AbVD0KbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:31:15 -0400
Date: Wed, 27 Apr 2005 20:30:56 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050427103056.GB22099@gondor.apana.org.au>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net> <20050427010730.GA18919@gondor.apana.org.au> <426F68C5.4010109@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426F68C5.4010109@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 12:26:13PM +0200, Patrick McHardy wrote:
> 
> Forwarded packets can't have any NAT manips in LOCAL_OUT, so it
> should work. I'm not sure about it though because it would be
> the only place where packets just appear in FORWARD, usually
> all packets enters through PRE_ROUTING or LOCAL_OUT.

It's also the only place where we generate a packet with a non-local
source address :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
