Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbRAKTuT>; Thu, 11 Jan 2001 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131067AbRAKTuI>; Thu, 11 Jan 2001 14:50:08 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:48389 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S130392AbRAKTtx>;
	Thu, 11 Jan 2001 14:49:53 -0500
Date: Thu, 11 Jan 2001 20:49:22 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111204922.E3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another observation wrt. behaviour with 'noapic'...

When streaming time-critical data over the network (running esound to another
server, etc), sometimes there are hiccups in the stream. These hiccups seem to
be much less frequent, if at all present, when running with 'noapic'. I'm
currently running sound over a heavily loaded ethernet, no hiccups at all...
Weird, since the apic ought to spread the load of handling the interrupts over
all available CPU's.

Whatever is causing this, there seems to be something fishy in the way
interrupts are handled when the apic(s) is/are enabled...

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
