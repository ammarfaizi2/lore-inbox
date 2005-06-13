Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFMVBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFMVBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFMVAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:00:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57492
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261384AbVFMVAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:00:00 -0400
Date: Mon, 13 Jun 2005 13:59:50 -0700 (PDT)
Message-Id: <20050613.135950.48528369.davem@davemloft.net>
To: juhl-lkml@dif.dk
Cc: linux-kernel@vger.kernel.org, ross.biro@gmail.com, netdev@oss.sgi.com
Subject: Re: [PATCH] net: fix sparse warning (plain int as NULL)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506122358570.16521@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506122358570.16521@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Mon, 13 Jun 2005 00:05:33 +0200 (CEST)

> Here's a patch to fix a small sparse warning in net/ipv4/tcp_input.c :
> net/ipv4/tcp_input.c:4179:29: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Please patch against Linus's tree, -mm has a ton of TCP changes
in it so this patch wouldn't apply to the current GIT tree
without rejects.

Thanks.
