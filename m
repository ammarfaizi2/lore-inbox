Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRALVGK>; Fri, 12 Jan 2001 16:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRALVGA>; Fri, 12 Jan 2001 16:06:00 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:40973 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132559AbRALVFw>;
	Fri, 12 Jan 2001 16:05:52 -0500
Date: Fri, 12 Jan 2001 22:05:23 +0100
From: Frank de Lange <frank@unternet.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112220523.C27809@unternet.org>
In-Reply-To: <20010112214642.A27809@unternet.org> <Pine.LNX.4.30.0101122150260.3128-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122150260.3128-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:51:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:51:36PM +0100, Ingo Molnar wrote:
> great. Back when i had the same problem, flood pinging another host (on
> the local network) was the quickest way to reproduce the hang:
> 
> 	ping -f -s 10 otherhost
> 
> this produced an IOAPIC-hang within seconds.

Apart from killing streaming audio and interactive network use, nothing hangs.
As soon as the ping flood is stopped, audio streams on and ssh sessions are
useable again. So, it seems to fix it...

Frank
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
