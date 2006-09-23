Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWIWT5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWIWT5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIWT5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:57:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14806
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751511AbWIWT5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:57:08 -0400
Date: Sat, 23 Sep 2006 12:57:10 -0700 (PDT)
Message-Id: <20060923.125710.71089726.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, herbert@gondor.apana.org
Subject: Re: [PATCH]: Fix ALIGN() macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060923125458.GA2682@gondor.apana.org.au>
References: <20060922.223136.41635862.davem@davemloft.net>
	<20060923124633.GA2567@gondor.apana.org.au>
	<20060923125458.GA2682@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 23 Sep 2006 22:54:59 +1000

> On Sat, Sep 23, 2006 at 10:46:33PM +1000, herbert wrote:
> >
> > Thanks for fixing this Dave.  I recall being bitten earlier
> > by the same thing as well.  I really need to start testing
> > on 64-bit.
> > 
> > BTW could you describe the other regression?
> 
> Nevermind, I saw your note on IRC.  If you haven't found the
> problem yet, could you pleas try modprobe tcrypt mode=100?
> 
> That should better pin-point the problem.

I'll do that, but currently I believe that the error has something to
do with the "tail" skb handling in the ESP conversions within that
changeset.

I should have a good handle on this bug by the end of today.

Thanks.
