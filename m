Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135648AbRANWjg>; Sun, 14 Jan 2001 17:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbRANWjZ>; Sun, 14 Jan 2001 17:39:25 -0500
Received: from styx.suse.cz ([195.70.145.226]:16889 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S135648AbRANWjM>;
	Sun, 14 Jan 2001 17:39:12 -0500
Date: Sun, 14 Jan 2001 23:39:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010114233907.C2487@suse.cz>
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu> <20010114203823.A17160@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010114203823.A17160@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sun, Jan 14, 2001 at 08:38:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 08:38:23PM +0100, Jamie Lokier wrote:

> > I think its significant that two reports I have are FIC PA-2013 but not all.
> > What combination of chips is on the 2013 ?
> 
> Reading through my mail logs, I know a board, either FIC PA-2011 or FIC
> PA-2007 (I seem to have changed my mind somewhere in history) with a
> 6.4G Quantum Fireball ST, 64MB RAM and an AMD K6-233.  The chipset
> reports as VIA VP2/97; sorry, I do not have access to get the PCI IDs.

PA-2007 is indeed a VP2/97, a very nice board, with vt82c595+vt82c586b.

> It locks up with DMA enabled, typically after a few hours, and has done
> that since 2.1 kernel days.
> 
> Unfortunately it locks up with Mandrake 7.2 which is not very old (based
> on 2.2.17 kernels -- it's not my PC any more but I installed Mandrake on
> it recently).
> 
> Kernel option "ide=nodma" fixes this -- no lockups.
> 
> After that "hdparm -X34 -d1" enables DMA and the board remains reliable.
> I observed one lockup in several years, while X was starting so it could
> have been X.  -X34 does not change the results of "hdparm -t".
> 
> Note that "hdparm -X34 -d1" enables old DMA, not UDMA.  (The board was
> advertised as UDMA capable but it isn't AFAIK).

It should be able to do UDMA33.

Is the board still available for some testing?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
