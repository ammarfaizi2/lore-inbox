Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263181AbVHFNai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbVHFNai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVHFNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:30:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57552
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262196AbVHFNaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:30:35 -0400
Date: Sat, 06 Aug 2005 06:30:56 -0700 (PDT)
Message-Id: <20050806.063056.104043149.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: sandos@home.se, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050806075717.GA18104@gondor.apana.org.au>
References: <20050805.093208.74729918.davem@davemloft.net>
	<20050806022435.GB12862@gondor.apana.org.au>
	<20050806075717.GA18104@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 6 Aug 2005 17:57:17 +1000

> Hang on a second, the original poster mentioned rc5.  Is this really
> pristine rc5 with the one netpoll patch? If so then it can't be the
> patches we're talking about because they only went in days later.

This seems to be confirmed now... so I'll hold off on the revert
for now.
