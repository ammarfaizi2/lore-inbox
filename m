Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRAWHG1>; Tue, 23 Jan 2001 02:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135522AbRAWHGR>; Tue, 23 Jan 2001 02:06:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36366 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130204AbRAWHGD>;
	Tue, 23 Jan 2001 02:06:03 -0500
Message-ID: <3A6D2D54.619AFA7E@mandrakesoft.com>
Date: Tue, 23 Jan 2001 02:05:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Linus Torvalds wrote:
> 
> > The ChangeLog may not be 100% complete. The physically big things are the
> > PPC and ACPI updates, even if most people won't notice.
> >
> >                 Linus
> >
> > ----
> >
> > pre10:
> >  - got a few too-new R128 #defines in the Radeon merge. Fix.
> >  - tulip driver update from Jeff Garzik
> >  - more cpq and DAC elevator fixes from Jens. Looks good.
> >  - Petr Vandrovec: nicer ncpfs behaviour
> >  - Andy Grover: APCI update
> >  - Cort Dougan: PPC update
> >  - David Miller: sparc updates
> >  - David Miller: networking updates
> >  - Neil Brown: RAID5 fixes
> 
> Do the tulip driver updates address the increasingly common NETDEV timeout
> repots?

In general you can answer this yourself by reading
drivers/net/tulip/ChangeLog.

I don't see increasingly common timeout reports.. with which hardware? 
They are likely on the newer LinkSys 4.1 cards, and there are still
problesm with PNIC.  Outside of that, other cards should be ok.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
