Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUHNUv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUHNUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUHNUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:51:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14335 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265668AbUHNUvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:51:53 -0400
Date: Sat, 14 Aug 2004 22:51:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] CONFIG_MII requires only CONFIG_NET
Message-ID: <20040814205144.GE1387@fs.tum.de>
References: <20040813102202.GT13377@fs.tum.de> <E1Bvaau-00077D-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Bvaau-00077D-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 09:51:36PM +1000, Herbert Xu wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> > 
> > But trying it out CONFIG_MII=y seems to at least compile with 
> > CONFIG_NET_ETHERNET=n.
> > 
> > @Jeff:
> > It seems, CONFIG_MII doesn't actually require CONFIG_NET_ETHERNET?
> > Could you comment on the following patch?
> 
> Are there non-Ethernet drivers that use MII? If not what's the point?

The discussion some time ago started around the question whether 
USB_PEGASUS would have to depend on NET_ETHERNET since it selects MII.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

