Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbRAKUZs>; Thu, 11 Jan 2001 15:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRAKUZk>; Thu, 11 Jan 2001 15:25:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:60635 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130695AbRAKUYc>;
	Thu, 11 Jan 2001 15:24:32 -0500
Date: Thu, 11 Jan 2001 20:38:27 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111203827.D3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, the noapic option seems to help, as I'm currently beating the network to
death but it won't die... As the problem is elusive, it is hard to tell, and it
would not surprise me if the net dropped dead the moment this mail went
through, but current indication is that noapic makes the sudden net-death
disappear.

So.... we're still left with the question 'is this hardware-related, or is it a
software/configuration problem'? Other people seem to have similar problems
with dissimilar hardware (tulip cards instead of Winbond, etc), on 2.2.x as
well as 2.3/4.x. As I do not run Windows (NT or 2K), I can not tell if this
problem also occurs there. And my FreeBSD-box is uniprocessor... So... has
anyone seen anything like this on other 'true' (SMP) OS's? If so, that would
indicate a hardware problem...

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
