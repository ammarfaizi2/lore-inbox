Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131661AbRCXNDe>; Sat, 24 Mar 2001 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRCXNDZ>; Sat, 24 Mar 2001 08:03:25 -0500
Received: from fenrus.demon.co.uk ([158.152.228.152]:55689 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131660AbRCXNDI>;
	Sat, 24 Mar 2001 08:03:08 -0500
Message-Id: <m14gne7-000OcAC@amadeus.home.nl>
Date: Sat, 24 Mar 2001 12:59:55 +0000 (GMT)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: shadow@dementia.org (Derrick J Brashear)
Subject: Re: athlon+2.2+pdc20267=hang?
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <18520000.985334866@skittlebrau.trafford.dementia.org>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <18520000.985334866@skittlebrau.trafford.dementia.org> you wrote:
> Earlier today I swapped an Athlon (tbird) 850 and an Epox 8KTA3 in for the 
> dual Celeron I had, moving all the cards into the new system. One of these 
> was a Promise PDC20267 with 4 40gb disks attached. The machine would not 
> boot; I assumed it was the i686-smp kernel and installed a Redhat 
> 7.0-provided i386 kernel. Several hours and a dozen or so boots later, it 
> looks like when the bios on the PDC20267 is installed, the system hangs 
> while booting at the point where it would probe C/H/S from the devices 
> attached to the PDC20267 (they've already been identified by that point)

Your motherboard probably has a VIA chipset. I've been chasing several of
such problems in the last weeks, and fixed most of them for the 2.4 kernel.
Unfortionatly, some PCI cards (TV capture and 3C905C) somehow don't like the
fix.

You can achieve the same effect by setting the PCI tuning in the bios to
conservative settings instead of "optimal"....

Greetings,
   Arjan van de Ven
