Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbTLFPdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbTLFPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:33:43 -0500
Received: from legolas.restena.lu ([158.64.1.34]:48570 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265196AbTLFPdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:33:41 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070721735.1991.20.camel@big.pomac.com>
References: <1070676480.1989.15.camel@big.pomac.com>
	 <1070717770.13004.11.camel@athlonxp.bradney.info>
	 <1070721735.1991.20.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1070724815.13016.16.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 16:33:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 15:42, Ian Kumlien wrote:
> On Sat, 2003-12-06 at 14:36, Craig Bradney wrote:
> > On Sat, 2003-12-06 at 03:08, Ian Kumlien wrote: 
> > > You could always move eth0 to a different slot. Other than that, you can
> > > do manual config for the irq's in the bios, but it shouldn't be
> > > needed...
> > 
> > eth0 is the 3com onboard on the a7n8x deluxe... 
> 
> I find that so odd... My on board network controller is a realtec phys
> controlled by a nvidia mac. Same goes for audio.

Yes.. maybe if I was using the onboard nvidia nic it would not share..
Not sure.
> 
> > Having finally woken up (me not the pc), uptime here is now 12 hours..
> > (without the CPU Disconnect athcool run, just the kernel patch). I did
> > run the athcool program to check the result though:
> > 
> > nVIDIA nForce2 (10de 01e0) found
> > 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.
> 
> nVIDIA nForce2 (10de 01e0) found
> 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

Its a pity that as Bart said, those numbers dont reflect any sort of
revision as that might lead to a conclusion about why it happens on some
and not others.


> > Perhaps my motherboard and cpu doesnt have a problem with disconnect and
> > just the IRQ issue, perhaps because its only a few weeks old. It would
> > make sense in some ways given that my system has only one of the
> > problems given the uptime I have been able to reach.
> 
> Mine is 2 weeks old or so.. 

> > My hangs have always been when I have used the PC.. and often completed
> > a task and then a few seconds later it goes.
> 
> Mine always seems to hang after a certain amount of time... When id
> didn't do a grep in the kernel lib.

I've just come hom to find my grep -R a /usr/* and my 4gb dvd grep have
completed correctly... 14 hours uptime now.

> Btw, i have UDMA100 disks.. 2 disks on primary and 2 cdroms on
> secondary... I dunno if this could make any difference..

1 ata133 primary master and dvdrw and cdrom on secondary here.

> > Will see in time I guess
> 
> Good luck =)

You too :)

Craig

