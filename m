Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155159AbPGLJ0Y>; Mon, 12 Jul 1999 05:26:24 -0400
Received: by vger.rutgers.edu id <S154382AbPGKXOT>; Sun, 11 Jul 1999 19:14:19 -0400
Received: from paranoia.gravity-cs.com ([194.90.181.101]:60764 "EHLO gravity-cs.com") by vger.rutgers.edu with ESMTP id <S154380AbPGKXMU>; Sun, 11 Jul 1999 19:12:20 -0400
From: Alan Arolovitch <alan@gravity-cs.com>
Message-Id: <199907112307.CAA18191@gravity-cs.com>
Subject: DMA bus-master writes & CPU cache question
To: linux-kernel@vger.rutgers.edu
Date: Mon, 12 Jul 1999 02:07:52 +0300 (IDT)
Cc: alan@gravity-cs.com (Alan Arolovitch)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


Hi,

we're developing broadband NIC driver and I have the following
question: the hardware performs PCI bus-master DMA writes into 
the RAM and the driver is either throgh polling or interrupt
handling routine reads the DMA area.
Should CPU cache affect reading data from the DMA area, i.e.
may some buffering effect or data inconherence appear? If so, 
what are the options?
I've seen some mention to allocation of non-cacheable memory
in NDIS documentation, is it something I have to do in Linux
as well?

i'd appreciate responses via email, i don't regularly monitor
the list. and of course i'll summarize to the list..


rgds,
						--alan.

-- 
Alan Arolovitch, CTO		       Gravity Computing Solutions Ltd.	
email: alan@gravity-cs.com + tel.: +972-3-5474450 + fax: +972-3-5474451

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
