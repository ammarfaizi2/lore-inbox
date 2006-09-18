Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWIRHXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWIRHXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIRHXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:23:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7359
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751278AbWIRHXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:23:08 -0400
Date: Mon, 18 Sep 2006 00:22:56 -0700 (PDT)
Message-Id: <20060918.002256.31639200.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kuznet@ms2.inr.ac.ru, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060903111507.GA12580@gondor.apana.org.au>
References: <m3odty57gf.fsf@defiant.localdomain>
	<20060903111507.GA12580@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 3 Sep 2006 21:15:07 +1000

> So here is a simple patch to remove the tx lock from dev_watchdog_up.
> In 2.6.19 we can eliminate the unnecessary __dev_watchdog_up and
> replace it with dev_watchdog_up.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
