Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFMWDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFMWDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFMWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:00:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7652
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261436AbVFMV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:57:55 -0400
Date: Mon, 13 Jun 2005 14:57:16 -0700 (PDT)
Message-Id: <20050613.145716.88477054.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: jesper.juhl@gmail.com, mru@inprovide.com, rommer@active.by,
       bernd@firmix.at, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: udp.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1Dhwho-0001mn-00@gondolin.me.apana.org.au>
References: <20050613.124515.104034144.davem@davemloft.net>
	<E1Dhwho-0001mn-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 14 Jun 2005 07:42:52 +1000

> It'll dump the stack anyway if we just make it a NULL pointer.

Some platforms don't handle that very cleanly, for example
it may be necessary to have something mapped at page zero
for one reason or another.
