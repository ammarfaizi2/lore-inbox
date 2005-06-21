Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVFUWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVFUWog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVFUWlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:41:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59561
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262398AbVFUWcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:32:51 -0400
Date: Tue, 21 Jun 2005 15:32:15 -0700 (PDT)
Message-Id: <20050621.153215.74747942.davem@davemloft.net>
To: chrisw@osdl.org
Cc: bdschuym@pandora.be, kaber@trash.net, bdschuym@telenet.be,
       herbert@gondor.apana.org.au, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, rankincj@yahoo.com,
       ebtables-devel@lists.sourceforge.net, netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050621212317.GB9153@shell0.pdx.osdl.net>
References: <42B82F35.3040909@trash.net>
	<1119386772.3379.4.camel@localhost.localdomain>
	<20050621212317.GB9153@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.12: connection tracking broken?
Date: Tue, 21 Jun 2005 14:23:17 -0700

> * Bart De Schuymer (bdschuym@pandora.be) wrote:
> > Op di, 21-06-2005 te 17:16 +0200, schreef Patrick McHardy:
> > > I unfortunately don't see a way to remove it, but we should keep
> > > thinking about it. Can you please check if the attached patch is
> > > correct? It should exclude all packets handled by bridge-netfilter
> > > from having their conntrack reference dropped. I didn't add nf_reset()'s
> > > to the bridging code because with tc actions the packets can end up
> > > anywhere else anyway, and this will hopefully get fixed right sometime.
> > 
> > Looks good.
> 
> Is this one good for -stable?

We will push it to stable@kernel.org if we deem it should.

I do review the stream going into 2.6.x, and decide if it
should be bound for -stable as well, so you never need to
inquire about this specifically.
