Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbRAIK0v>; Tue, 9 Jan 2001 05:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRAIK0l>; Tue, 9 Jan 2001 05:26:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45066 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130689AbRAIK03>; Tue, 9 Jan 2001 05:26:29 -0500
Subject: Re: Failure building 2.4 while running 2.4.  Success in building 2.4 while running 2.2.
To: silviu@delrom.ro (Silviu Marin-Caea)
Date: Tue, 9 Jan 2001 10:28:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, rlug@lug.ro
In-Reply-To: <20010109111247.397581ea.silviu@delrom.ro> from "Silviu Marin-Caea" at Jan 09, 2001 11:12:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fw0x-0006N5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have RedHat7, glibc-2.2-9, gcc-2.96-69.

Ditto

> If I try to rebuild 2.4.0 while running the new kernel, I get random
> compiler errors.

Now I don't. What hardware are you using ?

> It happens on two machines.  One of them runs 2.4.0-test12, the other
> 2.4.0.  Both of them with the updates above mentioned.

What hardware what errors ?

> I know this is a RedHat issue, but it may be useful to know for some.

It may well be compiler optimisation where the new gcc is optimising out 
something someone forgot in a driver or miscompiling a specific driver. 
One good way to test if its compiler or kernel triggered would be to rebuild
2.4.0 with egcs (aka kgcc).

I'd like to know what drivers you are running so I can try and duplicate it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
