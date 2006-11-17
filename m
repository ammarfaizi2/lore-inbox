Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162354AbWKQErt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162354AbWKQErt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162352AbWKQErt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:47:49 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:15701 "EHLO
	asav01.insightbb.com") by vger.kernel.org with ESMTP
	id S1162354AbWKQErs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:47:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnoUAFnNXEVKhRUUVWdsb2JhbACBSYRAhjgBKw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: IPv4: ip_options_compile() how can we avoid blowing up on a NULL skb???
Date: Thu, 16 Nov 2006 22:46:18 -0500
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1GkrjY-0004Dt-00@gondolin.me.apana.org.au>
In-Reply-To: <E1GkrjY-0004Dt-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162246.21018.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 19:37, Herbert Xu wrote:
> David Miller <davem@davemloft.net> wrote:
> >
> > I'm very happy to accept a patch which assert's this using BUG()
> > checks :-)
> 
> A BUG() won't be necessary because the NULL pointer dereferences will
> OOPS anyway.
>

BUG()s there would be a mechanism to document invariants so next time
someone is looking at the code there are no questions.

-- 
Dmitry
