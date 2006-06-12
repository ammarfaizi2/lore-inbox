Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWFLHSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWFLHSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWFLHSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:18:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20955
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751025AbWFLHSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:18:22 -0400
Date: Mon, 12 Jun 2006 00:18:29 -0700 (PDT)
Message-Id: <20060612.001829.49243997.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: mingo@elte.hu, stefanr@s5r6.in-berlin.de, Valdis.Kletnieks@vt.edu,
       jirislaby@gmail.com, akpm@osdl.org, arjan@infradead.org,
       mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [patch] undo AF_UNIX _bh locking changes and split lock-type
 instead
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060612070356.GA1273@gondor.apana.org.au>
References: <20060612064122.GA1101@gondor.apana.org.au>
	<20060612065701.GA24213@elte.hu>
	<20060612070356.GA1273@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 12 Jun 2006 17:03:56 +1000

> On Mon, Jun 12, 2006 at 08:57:01AM +0200, Ingo Molnar wrote:
> >
> > regarding your point wrt. path of integration - it is pretty much the 
> > only practical way to do this centrally as part of the lock validator 
> > patches, but to collect ACKs from subsystem maintainers in the process. 
> > So if you like it i'd like to have your ACK but this patch depends on 
> > the other lock validator patches (and only makes sense together with 
> > them), so they should temporarily stay in the lock validator queue. 
> > Hopefully this wont be a state that lasts too long and once the 
> > validator is upstream, all patches of course go via the subsystem 
> > submission rules.
> 
> Obviously as long as Dave is happy with it then it's fine.  However,
> it's probably a good idea to cc netdev for relevant patches so that
> they get a wider review.  If you've already sent this one there then
> I apologise for missing it :)

Yes, this is fine with me.
