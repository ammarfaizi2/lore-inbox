Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbRBNRxZ>; Wed, 14 Feb 2001 12:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBNRxQ>; Wed, 14 Feb 2001 12:53:16 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:37466 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130136AbRBNRxH>; Wed, 14 Feb 2001 12:53:07 -0500
Date: Wed, 14 Feb 2001 11:47:26 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
In-Reply-To: <20010214173057.A824@grobbebol.xs4all.nl>
Message-ID: <Pine.LNX.3.96.1010214114709.6565A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Feb 2001, Roeland Th. Jansen wrote:

> On Tue, Feb 13, 2001 at 09:13:10PM +0100, Maciej W. Rozycki wrote:
> >  Please test it extensively, as much as you can, before I submit it for
> > inclusion.  If you ever get "Aieee!!!  Remote IRR still set after unlock!" 
> > message, please report it to me immediately -- it means the code failed. 
> 
> 
> ok, so far so good.
> 
> > There is also an additional debugging/statistics counter provided in
> > /proc/cpuinfo that counts interrupts which got delivered with its trigger
> > mode mismatched.  Check it out to find if you get any misdelivered
> > interrupts at all.
> 
> currently attacking the box with a flood ping. I used a pristine 2.4.1.
> to be sure I didn't leave stuff and applied the patch.

ping -l is a good test also...

	Jeff




