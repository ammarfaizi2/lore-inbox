Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278302AbRJ1NHc>; Sun, 28 Oct 2001 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRJ1NHX>; Sun, 28 Oct 2001 08:07:23 -0500
Received: from alfa.nre.vic.gov.au ([203.11.140.30]:52203 "EHLO
	majordomo.nre.vic.gov.au") by vger.kernel.org with ESMTP
	id <S278302AbRJ1NHL>; Sun, 28 Oct 2001 08:07:11 -0500
From: Steve.Batson@nre.vic.gov.au
X-Lotus-FromDomain: NRE
To: linux-kernel@vger.kernel.org
Message-ID: <4A256AF3.004D9CC0.00@ctln06.nre.vic.gov.au>
Date: Mon, 29 Oct 2001 00:08:52 +1000
Subject: Re: Any stable 2.4 kernel?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I've also had some problems finding a stable 2.4 kernel.

I admin' a few machines, one of which is a DELL Poweredge 6300
(4x Xeon 550, 4GB RAM, 5GB swap, aic7xxx) that is mainly used for
heavy statistical analysis of gene sequences.

Some of these jobs run at 1.8GB/process.

I'm running RH7.1 and (was running) 2.4.3-12 kernel.

The strange thing was, no matter how loaded the machine, no swap
was ever used (??). We started to get a severe shortage of resources
during backups with the message:

mm: critical shortage of bounce buffers (from highmem.c)
(I/O exhausting low memory)

The machine would eventually become so unresponsive that a hard reset was
the only option.

I've just upgraded to kernel 2.4.12 and swap is now being used :)
Stability has been good, even under extreme loads (test was: 3x 1.8GB processes
while doing a backup).

I find it strange that RH latest updated kernel is 2.4.9 but the vm problems
were not fixed until 2.4.10.

Any feedback on these issues is very welcome.

------------------------------------------

Steve Batson
System Administrator
Victorian Institute of Animal Science
Victoria, Australia
Email: steve.batson@nre.vic.gov.au

------------------------------------------


> From: Igor Mozetic <igor.mozetic@uni-mb.si>
> Date:   Sat, 27 Oct 2001 11:48:25 +0200
> To: linux-kernel@vger.kernel.org
> Subject: Any stable 2.4 kernel?
>
> I wonder if anybody has found a stable kernel for the following
> hardware: C440GX+, dual Xeon 550, 2GB RAM, 1GB swap, aic7xxx.
> Usage pattern is load > 2, highmem, not much I/O (maybe swap?).
> Some of our jobs take weeks, so stable means months between reboots.
>
> I found anything beyond 2.4.10 useless - lockups after a few days.
> Currently I run 2.4.3 with varying degree of success - initial lifespan
> was 4 months, but last reincarnation survived for 3 weeks only.
>
> Any recommendation for 2.4 or should I consider going back to 2.2 ?
> I don't need any fancy features (apart to SMP and highmem),
> only stability is important.
>
> -Igor Mozetic




