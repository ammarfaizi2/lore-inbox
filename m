Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155154-7620>; Fri, 7 Aug 1998 18:43:57 -0400
Received: from lorraine.loria.fr ([152.81.1.17]:39660 "EHLO lorraine.loria.fr" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155039-7620>; Fri, 7 Aug 1998 14:51:30 -0400
Message-ID: <19980807211550.A18048@loria.fr>
Date: Fri, 7 Aug 1998 21:15:50 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Idea to make a kickass TCP read!
Mail-Followup-To: linux-kernel@vger.rutgers.edu
References: <199808070639.XAA26865@sun4.apsoft.com> <m0z4m0H-000aNFC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <m0z4m0H-000aNFC@the-village.bc.nu>; from Alan Cox on Fri, Aug 07, 1998 at 01:52:16PM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, Aug 07, 1998 at 01:52:16PM +0100, Alan Cox wrote:
> > Why couldn't we at least mmap the skbuffs?  
> 
> By the time you've done the required TLB flushes on an SMP box at least
> a copy would have been cheaper. You can do ring buffers mapped into user
> space stuff - U-Net does exactly that. Its a recognition that sometimes
> ultralow latencies require specialist interfaces

Virtual Interface Architecture seems  to be a  nice one.  At least the
spec is promising.

  http://www.viarch.org/

I wonder  if such  an interface  can be  implemented with the  current
driver structure.  Probably, but alignment problems will suck.

  OG.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
