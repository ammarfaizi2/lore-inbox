Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbQKFRRO>; Mon, 6 Nov 2000 12:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129467AbQKFRQ5>; Mon, 6 Nov 2000 12:16:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129703AbQKFRQe>; Mon, 6 Nov 2000 12:16:34 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of
To: andrewm@uow.edu.au (Andrew Morton)
Date: Mon, 6 Nov 2000 17:17:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3A06C007.99EE3746@uow.edu.au> from "Andrew Morton" at Nov 07, 2000 01:28:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sptK-0006PP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a 16-liner!  I'll cheerfully admit that this patch
> may be completely broken, but hey, it's free.  I suggest
> that _something_ has to be done for 2.2 now, because
> Apache has switched to unserialised accept().

Interesting

> The fact that the throughput is 3-4 time worse for 2, 3, 4 and 5
> server processes is completely wierd.  Perhaps some strange miss
> pattern, but it doesn't do it on 2.4.  I'll dump this problem
> onto the netdev list, see if anyone has any bright ideas.

That would be consistent with the fact that thttpd is single threaded and
kicks apache for performance in 2.2 (less so 2.4!)

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
