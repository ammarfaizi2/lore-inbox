Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130232AbRAKTTQ>; Thu, 11 Jan 2001 14:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131805AbRAKTTJ>; Thu, 11 Jan 2001 14:19:09 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:27652 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S130232AbRAKTSy>;
	Thu, 11 Jan 2001 14:18:54 -0500
Date: Thu, 11 Jan 2001 20:18:19 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111201819.B3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another posting to the list which mentions problems with NE2K and BP6:

http://web.gnu.walfield.org/mail-archive/linux-kernel/2000-August/0132.html

"...In another machine, a dual celeron abit-bp6, recent 2.3.x kernels seem to 
dislike my realtek 8029 NIC. (I know, it's garbage plugged in to 
garbage...) The network card will die randomly, usually when I'm sending 
large amounts of data. When it dies, there are no kernel messages, and 
the interrupt count in /proc/interrupts for the card stop changing. Minor 
(painful) experimentation has shown that if the card is sharing the 
interrupt with anything else (say, ide2), it takes that with it. This 
only happens in "newer" kernels, it's fine in 2.2.16, and in some earlier 
2.3.x kernels. It goes away if I boot with the noapic=1 kernel parameter, 
and seems to be replaced with harmless "spurious 8259A interrupt: IRQ7." 
messages. (I haven't configured any hardware at all to be on IRQ7 - 
though I'm lead to believe IRQ7 has some sort of special purpose) ..."

So I'm not the only one...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
