Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVDHETH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVDHETH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDHETH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:19:07 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:17939 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262686AbVDHESK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:18:10 -0400
Date: Fri, 8 Apr 2005 14:17:24 +1000
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050408041724.GA32243@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au> <1112931238.28858.180.camel@uganda> <20050408033246.GA31344@gondor.apana.org.au> <1112932354.28858.192.camel@uganda> <20050408035052.GA31451@gondor.apana.org.au> <1112932969.28858.194.camel@uganda> <20050408040237.GA31761@gondor.apana.org.au> <1112934088.28858.199.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112934088.28858.199.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 08:21:28AM +0400, Evgeniy Polyakov wrote:
>
> > > On UP do not.
> > 
> > Shouldn't we should be fixing the MIPS implementation of
> > atomic_sub_return to not do the sync on UP then?
> 
> Unfortunately not, that sync is required exactly for return value store.

On UP?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
