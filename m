Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbWKUBkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWKUBkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWKUBkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:40:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030644AbWKUBkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:40:31 -0500
Date: Mon, 20 Nov 2006 17:37:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] make net/core/skbuff.c:skb_over_panic() static
Message-Id: <20061120173716.10357a90.akpm@osdl.org>
In-Reply-To: <20061120.195556.23029046.davem@davemloft.net>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061117170205.GE31879@stusta.de>
	<20061120.195556.23029046.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 19:55:56 -0500 (EST)
David Miller <davem@davemloft.net> wrote:

> From: Adrian Bunk <bunk@stusta.de>
> Date: Fri, 17 Nov 2006 18:02:05 +0100
> 
> > skb_over_panic() can now become static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Applied to net-2.6.20, thanks Adrian.

Adrian's patch is only applicable if my net-uninline-skb_put.patch is also
applied.

I'm not sure what to do with net-uninline-skb_put.patch.  It's a good patch
if all that deudgging stuff is present in skb_put(), but it's a bad patch
if it isn't present.  But it _is_ present.
