Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVFUVZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVFUVZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVFUVYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:24:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262531AbVFUVYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:24:01 -0400
Date: Tue, 21 Jun 2005 14:23:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Patrick McHardy <kaber@trash.net>, Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       rankincj@yahoo.com, ebtables-devel@lists.sourceforge.net,
       netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050621212317.GB9153@shell0.pdx.osdl.net>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net> <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net> <1119386772.3379.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119386772.3379.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bart De Schuymer (bdschuym@pandora.be) wrote:
> Op di, 21-06-2005 te 17:16 +0200, schreef Patrick McHardy:
> > I unfortunately don't see a way to remove it, but we should keep
> > thinking about it. Can you please check if the attached patch is
> > correct? It should exclude all packets handled by bridge-netfilter
> > from having their conntrack reference dropped. I didn't add nf_reset()'s
> > to the bridging code because with tc actions the packets can end up
> > anywhere else anyway, and this will hopefully get fixed right sometime.
> 
> Looks good.

Is this one good for -stable?

thanks,
-chris
