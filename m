Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbQLHSnx>; Fri, 8 Dec 2000 13:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbQLHSnn>; Fri, 8 Dec 2000 13:43:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131778AbQLHSnd>;
	Fri, 8 Dec 2000 13:43:33 -0500
Date: Fri, 8 Dec 2000 18:12:43 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Willy Tarreau <wtarreau@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Miquel van Smoorenburg <miquels@cistron.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre25
Message-ID: <20001208181243.A7797@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <E144AfG-0003B2-00@the-village.bc.nu> <976268866.3a30ae4296b71@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <976268866.3a30ae4296b71@imp.free.fr>; from wtarreau@free.fr on Fri, Dec 08, 2000 at 10:47:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 10:47:46AM +0100, Willy Tarreau wrote:
> |Bus  0, device   2, function  1:
> |  Unknown class: Intel OEM MegaRAID Controller (rev 5).
> |    Medium devsel.  Fast back-to-back capable.  BIST capable.  IRQ 10.  Master
> Capable.  Latency=64.  
> |    Prefetchable 32 bit memory at 0xf0000000 [0xf0000008].
> 
> as you see, the board is found at 0xf0000008, but used aligned to 0xf0000000.

No.  It's found at 0xf0000000, and has 8 bytes of MMIO space.

> my server currently works with that patch, but I'm sure it won't boot anymore
> if I apply this 2.2.18pre25 alone. 

"I'm sure" meaning "I didn't test it" ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
