Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVHEAAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVHEAAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDX56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:57:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbVHDX4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:56:48 -0400
Date: Thu, 4 Aug 2005 16:58:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
Message-Id: <20050804165842.4d673f97.akpm@osdl.org>
In-Reply-To: <42F25352.8050805@winch-hebergement.net>
References: <42EDDE50.6050800@winch-hebergement.net>
	<20050804033329.GA14501@gondor.apana.org.au>
	<20050804103523.GA11381@gondor.apana.org.au>
	<42F25352.8050805@winch-hebergement.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Pelat <guillaume.pelat@winch-hebergement.net> wrote:
>
> Hi,
> 
> Herbert Xu wrote:
> > On Thu, Aug 04, 2005 at 01:33:29PM +1000, herbert wrote:
> > 
> >>So I suppose we should reset cwnd_quota after tcp_transmit_skb?
> > 
> > Please try this patch to see if this is really the problem or not.
> > 
> > Thanks,
> 
> I just applied your patch, and it seems to work :)
> 2 hours uptime, and no crash yet (without the patch, it was crashing a 
> few mins only after booting).
> So i think the bug is crushed :)
> 

Thanks, Guillaume.  Herbert, David is travelling and not able to do a lot
of patchmonkeying.  Could you please prepare and submit a final patch?

Thanks.

