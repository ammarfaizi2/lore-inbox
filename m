Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWKUBkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWKUBkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbWKUBkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:40:46 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35241
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030645AbWKUBko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:40:44 -0500
Date: Mon, 20 Nov 2006 17:40:48 -0800 (PST)
Message-Id: <20061120.174048.105428563.davem@davemloft.net>
To: akpm@osdl.org
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] make net/core/skbuff.c:skb_over_panic() static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061120173716.10357a90.akpm@osdl.org>
References: <20061117170205.GE31879@stusta.de>
	<20061120.195556.23029046.davem@davemloft.net>
	<20061120173716.10357a90.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 20 Nov 2006 17:37:16 -0800

> Adrian's patch is only applicable if my net-uninline-skb_put.patch is also
> applied.

I just realized that, see the email I just sent out.

> I'm not sure what to do with net-uninline-skb_put.patch.  It's a
> good patch if all that deudgging stuff is present in skb_put(), but
> it's a bad patch if it isn't present.  But it _is_ present.

Keep it in your tree if you want, it's never going into mine :)
