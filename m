Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKHRuU>; Wed, 8 Nov 2000 12:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129113AbQKHRuB>; Wed, 8 Nov 2000 12:50:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129307AbQKHRtx>; Wed, 8 Nov 2000 12:49:53 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 8 Nov 2000 17:50:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8uc2ch$g3u$1@penguin.transmeta.com> from "Linus Torvalds" at Nov 08, 2000 09:26:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tZMe-0000F8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> unless that CPU is also SMP-capable).  It's documented by intel these
> days, and it works on all CPU's I've ever heard of, and it even makes
> sense to me (*).

Do the intel docs guarantee it works on i486 and higher, if so SMP athlon
will be the only check needed for the SMP users. You work for an x86 chip
cloning company so if you say it works I trust you 8)

> Also, at least part of the reason Intel removed the TSC check was that
> Linux actually seems to get the extended CPU capability flags wrong,
> overwriting the _real_ capability flags which in turn caused the TSC
> check on Linux to simply not work.  Peter Anvin is working on fixing
> this. I suspect that Linux-2.2 has the same problem.

I've not seen incorrect TSC detection in 2.2, do you know the precise
circumstances this occurs and I'll check over them. I've also got no
bug reports of this failing.

check_config would also panic with the 'Kernel compiled for ..' message 
if it occurred.

> There's a few other minor details that need to be fixed for Pentium 4
> features (aka " not very well documented errata"), and I think I have
> them all except for waiting for Peter to get the capabilities flag
> handling right.
> 
> So I suspect that we'll have good support for Pentium IV soon enough.. 

Excellent

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
