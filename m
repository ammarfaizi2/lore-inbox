Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTGCS3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTGCS3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:29:43 -0400
Received: from pop.gmx.net ([213.165.64.20]:48074 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265248AbTGCS3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:29:41 -0400
Date: Thu, 3 Jul 2003 20:43:47 +0200
From: Serge Eric Thiam <serge-eric.thiam@web.de>
To: linux-kernel@vger.kernel.org
Cc: Wiktor Wodecki <wodecki@gmx.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030703184347.GA4381@lion.freenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Wiktor Wodecki <wodecki@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk> <20030703151529.B20336@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703151529.B20336@flint.arm.linux.org.uk>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.5.73 (i686)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King [Thu, Jul 03, 2003 at 03:15:29PM +0100]
> On Thu, Jul 03, 2003 at 12:06:26PM +0100, Russell King wrote:
> > On Thu, Jul 03, 2003 at 12:37:03PM +0200, Wiktor Wodecki wrote:
> > > On my thinkpad T20 it boots up fine, however when I insert my ne2000
> > > pcmcia card it instantly freezes. No Ooops or log message at all.
> > > 2.5.73-mm1 did fine.
> > 
> > Grr.
> > 
> > Can you try taking off each patch in reverse order at:
> > 
> > 	http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-*
> > 
> > and seeing which one caused your problem?
> 
> Ok, Wiktor has tried removing these 6 patches, and his problem persists.
> According to bk revtool, these 6 patches are the only changes which
> went in for to pcmcia from .73 to .74.
> 
> If anyone else is having similar problems, they need to report them so
> we can obtain more data points - I suspect some other change in some other
> subsystem broke PCMCIA for Wiktor.
> 
> Wiktor - short of anyone else responding, you could try reversing each
> of the nightly -bk patches from .74 to .73 and work out which set of
> changes broke it.
I've been having this same problem with my 3c574 NIC since 2.5.73-mm1.
vanilla-2.5.73 and 2.5.72-mm2 was ok. Never tried 2.5.72-mm3. works
fine. I haven tried vanilla-2.5.74 nor 2.5.74-mm1 yet.

Hope this helps, 

regards

-Eric-
-- 
#!/usr/bin/perl
my @email = qw(serge-eric thiam gmx net);
printf("%s.%s@%s.%s\n", $email[0], $email[1], $email[2], $email[3]);
