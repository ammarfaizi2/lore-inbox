Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWGSTyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWGSTyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWGSTyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:54:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63662
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030260AbWGSTyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:54:05 -0400
Date: Wed, 19 Jul 2006 12:54:05 -0700 (PDT)
Message-Id: <20060719.125405.48804152.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: ruben@puettmann.net, sergio@sergiomb.no-ip.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc2 tg3 Dead loop on netdevice eth0 fix it urgently!
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1G3E0V-0006e2-00@gondolin.me.apana.org.au>
References: <20060719110439.GJ23431@puettmann.net>
	<E1G3E0V-0006e2-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 20 Jul 2006 01:30:39 +1000

> [NET]: Fix reversed error test in netif_tx_trylock
> 
> A non-zero return value indicates success from spin_trylock,
> not error.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
