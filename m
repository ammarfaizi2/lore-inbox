Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWKUBjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWKUBjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbWKUBjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:39:13 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33705
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030633AbWKUBjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:39:12 -0500
Date: Mon, 20 Nov 2006 17:39:16 -0800 (PST)
Message-Id: <20061120.173916.21925337.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] make net/core/skbuff.c:skb_over_panic() static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061120.195556.23029046.davem@davemloft.net>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061117170205.GE31879@stusta.de>
	<20061120.195556.23029046.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 20 Nov 2006 19:55:56 -0500 (EST)

> From: Adrian Bunk <bunk@stusta.de>
> Date: Fri, 17 Nov 2006 18:02:05 +0100
> 
> > skb_over_panic() can now become static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Applied to net-2.6.20, thanks Adrian.

I just realized this requires a patch already in -mm which
isn't in my tree.

Sorry about that.

I really doubt I'll put that skb_put() patch into my tree,
ever, we can just remove the debugging checks or make them
conditional to keep the inline.
