Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbRBBNwy>; Fri, 2 Feb 2001 08:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129217AbRBBNwp>; Fri, 2 Feb 2001 08:52:45 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:3090 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129152AbRBBNwh>;
	Fri, 2 Feb 2001 08:52:37 -0500
Date: Fri, 2 Feb 2001 14:52:16 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: roel@grobbebol.xs4all.nl
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010202145216.C13831@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.1. rebuilt here and with a floodping towards my machine causes a
> hard crash where nothing works anymore.

I'm currently running 2.4.1 with Maciej's patch-2.4.0-io_apic-4. Additionally,
I disabled focus_processor in apic.c to get rid of some network delays. Flood
pings both from and to this system do not cause any problems, other than making
the streaming audio sound a bit choppy...

Box is a dual-celeron (466, non-overclocked) BP-6 with two ne2k (Winbond
W89C940 based) cards sharing an interrupt.  

Maybe that works for you as well?

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
