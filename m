Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUIRA70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUIRA70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUIRA70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:59:26 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:52206 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269079AbUIRA7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:59:25 -0400
Message-ID: <9e4733910409171759242349f0@mail.gmail.com>
Date: Fri, 17 Sep 2004 20:59:24 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Cc: davem@davemloft.net, david@gibson.dropbear.id.au, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091717215e9be08b@mail.gmail.com>
	 <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have verified that compiling the drivers in avoids the problem. 

I'll boot again and get more of the error message. It's not making it
to the logs so I am copying it by hand from the screen.


On Sat, 18 Sep 2004 10:27:47 +1000, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > I'm still OOPsing at boot in fib_disable_ip+21 from
> > fib_netdev_event+63. Both e1000 and tg3 are effected. I have current
> > linus bk as of time of this message.
> 
> Please post the complete error message.
> --
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 



-- 
Jon Smirl
jonsmirl@gmail.com
