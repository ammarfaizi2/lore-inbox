Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBETvb>; Mon, 5 Feb 2001 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbRBETvW>; Mon, 5 Feb 2001 14:51:22 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:3347 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129065AbRBETvL>;
	Mon, 5 Feb 2001 14:51:11 -0500
Date: Mon, 5 Feb 2001 20:49:47 +0100
From: Frank de Lange <frank@unternet.org>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010205204947.J14850@unternet.org>
In-Reply-To: <20010202145216.C13831@unternet.org> <20010205182652.B604@grobbebol.xs4all.nl> <20010205194111.A888@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010205194111.A888@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Mon, Feb 05, 2001 at 07:41:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2001 at 07:41:11PM +0000, Roeland Th. Jansen wrote:
> On Mon, Feb 05, 2001 at 06:26:52PM +0000, Roeland Th. Jansen wrote:
> > 
> > I'll report further. an Maciej -- thanks for your work !
> 
> with the extra patch in arch/i386/kernel/apic.c:
> 
> #else
>         /* Disable focus processor (bit==1) */
>         value |= (1<<9);
> #endif
> 
> used, eth0 (ne2k) doesn't die anymore; no choppy sound either. we're
> currently having over 2.100.000 interrupts without a problem.

Same here (although I just changed #if 1 to #if 0 to disable focus processor
support), the net stays up and the chops are gone. 

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
