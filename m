Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272171AbRHWAl2>; Wed, 22 Aug 2001 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272172AbRHWAlT>; Wed, 22 Aug 2001 20:41:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21378 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272171AbRHWAlC>;
	Wed, 22 Aug 2001 20:41:02 -0400
Date: Wed, 22 Aug 2001 17:40:48 -0700 (PDT)
Message-Id: <20010822.174048.116352248.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108230001.f7N01eY19346@aslan.scsiguy.com>
In-Reply-To: <20010822.160944.08322757.davem@redhat.com>
	<200108230001.f7N01eY19346@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 18:01:40 -0600

   It is opaque and should be able to represent all dma (or I would prefer
   bus) addresses in the system.  The examples I've seen where people
   assume it to be 32bits in size are, well, broken.

It is the type to be used for 32-bit SAC based DMA.
DMA-mapping.txt is pretty clear about this.

In fact, because it is well documented, ia64 is in direct violation of
the API.  I've been mentioning things like this since the beginning.

Later,
David S. Miller
davem@redhat.com
