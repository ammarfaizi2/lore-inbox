Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269973AbRHEQCI>; Sun, 5 Aug 2001 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269972AbRHEQB6>; Sun, 5 Aug 2001 12:01:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64779 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269766AbRHEQBt>; Sun, 5 Aug 2001 12:01:49 -0400
Subject: Re: alloc_skb cannot be called with GFP_DMA
To: andrea@suse.de (Andrea Arcangeli)
Date: Sun, 5 Aug 2001 17:03:12 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010805175334.E21840@athlon.random> from "Andrea Arcangeli" at Aug 05, 2001 05:53:34 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TQMy-00081S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In order to fix those bugs correctly and avoid memory corruption a new
> skbuff_head_cache_isadma skb cache will be needed.
> 
> A fast grep revealed a few buggy network drivers already (of course the
> bug is going to affect only ISA drivers so it's not a showstopper).

"It doesnt affect my computer so its not a problem" - humm 

If somoe can add the needed isa dma handling to alloc_skb (or alloc_isa_skb)
I'll go and fix all the drivers up. 
