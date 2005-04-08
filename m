Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVDHEDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVDHEDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDHEDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:03:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:2067 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262665AbVDHEDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:03:23 -0400
Date: Fri, 8 Apr 2005 14:02:37 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050408040237.GA31761@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au> <1112931238.28858.180.camel@uganda> <20050408033246.GA31344@gondor.apana.org.au> <1112932354.28858.192.camel@uganda> <20050408035052.GA31451@gondor.apana.org.au> <1112932969.28858.194.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112932969.28858.194.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 08:02:49AM +0400, Evgeniy Polyakov wrote:
>
> > > mips has additional sync.
> > 
> > But atomic_dec + 2 barries is going to do the sync as well, no?
> 
> On UP do not.

Shouldn't we should be fixing the MIPS implementation of
atomic_sub_return to not do the sync on UP then?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
