Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272180AbRHWBpS>; Wed, 22 Aug 2001 21:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272152AbRHWBpI>; Wed, 22 Aug 2001 21:45:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63618 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272180AbRHWBpB>;
	Wed, 22 Aug 2001 21:45:01 -0400
Date: Wed, 22 Aug 2001 18:45:12 -0700 (PDT)
Message-Id: <20010822.184512.77060492.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: kevin.vanmaren@unisys.com, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108230140.f7N1etY22587@aslan.scsiguy.com>
In-Reply-To: <20010822.183109.34763266.davem@redhat.com>
	<200108230140.f7N1etY22587@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 19:40:55 -0600

   You have to keep track of the significant bits in the dma_addr_t
   regardless of its size, so you put it into your TX descriptor's (or
   what have you) native format that doesn't waste any space.  You don't
   need to keep the full dma_addr_t around.  Perhaps this is just sloppy
   programming?
   
Some devices keep these in registers and advance them as the
dma progresses.  The only reliable way is by keeping track
of it in software.

   If you don't want to take part in technical discussions, you should
   work in closed source. 8-)

It's not open source, it's "dumb source" I have problems with.
A lot of discussions here end up being of that variety.

Later,
David S. Miller
davem@redhat.com
   
