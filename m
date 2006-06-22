Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWFVI0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWFVI0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWFVI0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:26:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60055
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964884AbWFVI0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:26:10 -0400
Date: Thu, 22 Jun 2006 01:26:09 -0700 (PDT)
Message-Id: <20060622.012609.25474139.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: alan@lxorguk.ukuu.org.uk, snakebyte@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060622023029.GA6156@gondor.apana.org.au>
References: <1150909982.15275.100.camel@localhost.localdomain>
	<E1FtDU0-0005nd-00@gondolin.me.apana.org.au>
	<20060622023029.GA6156@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 22 Jun 2006 12:30:29 +1000

> On Thu, Jun 22, 2006 at 10:55:44AM +1000, Herbert Xu wrote:
> > 
> > I think skb_padto simply shouldn't allocate a new skb.  It only needs
> > to extend the data area.
> 
> OK, here is a patch to make it do that.
> 
> [NET]: Avoid allocating skb in skb_pad

Want me to let this cook in 2.6.18 for a while before sending
it off to -stable?
