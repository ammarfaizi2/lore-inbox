Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKHWo1>; Wed, 8 Nov 2000 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbQKHWoH>; Wed, 8 Nov 2000 17:44:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29448 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129295AbQKHWn7>;
	Wed, 8 Nov 2000 17:43:59 -0500
Message-ID: <3A09D72A.C2730D0@mandrakesoft.com>
Date: Wed, 08 Nov 2000 17:43:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net> <20001109010336.A1367@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> But actually I'm concerned that all this code doesn't work at all -
> see reports from Michal Jaegermann (the bridge acts as if it drops
> config space transactions randomly). I have a lot of suggestions, but
> it's a pain to debug something without access to real hardware - just
> a waste of the precious time of everyone who is involved...
> So I would probably wait a week or two until I'll have something with
> bridges :-(

FWIW, I just tested rth's update of your path on my x86 SMP box, and a
laptop with two CardBus bridges (two CardBus slots).  Both worked
fine...

I am still worried that the conditions which generate the following
message indicate a problem still exists.  (this message exists w/out
your patch..)
Unknown bridge resource 0: assuming transparent

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
