Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVK0Vi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVK0Vi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0Vi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:38:58 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:62858 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751160AbVK0Vi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:38:58 -0500
Date: Sun, 27 Nov 2005 22:38:54 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Willy Tarreau <willy@w.ods.org>
cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
In-Reply-To: <20051127183313.GQ11266@alpha.home.local>
Message-ID: <Pine.LNX.4.60.0511272203060.25793@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
 <200511270111.29831.gene.heskett@verizon.net> <Pine.LNX.4.60.0511271839480.24919@kepler.fjfi.cvut.cz>
 <20051127183313.GQ11266@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Willy Tarreau wrote:
> On Sun, Nov 27, 2005 at 06:56:23PM +0100, Martin Drab wrote:
> > No, it isn't a problem of dust or grease. It is a problem of a case full 
> > of devices and bad airflow within it. (There's 6 HDDs, 8 PCI cards, an 
> > AthlonXP 3200+ with massive Zalman CNPS6000-Cu on top of it and 10 fans 
> > that are doing all they can running at maximum (with the noise of a 
> > medium vacuum cleaner ;), trying to cool it all, but it just isn't 
> > enough.) So I'll try to solve it by a water cooling.
> 
> Should be cheaper to buy a bigger case with a *real airflow path, and
> remove some of those fans.

This is a big-tower (Chieftec DA-01BL-D 
<http://www.chieftec.de/?page=products_show&item=201&k_id=1&language=de>), 
the only bigger would be a very expensive server casing.

> It's non-sense to put 10 fans in a mono-proc system ! even with 6 disks 
> (probably even IDE disks).

Yes I agree, though I counted all fans in the system (1 Northbridge, 1 
Power, 1 dual-power add-on board, 1 graphics, 1 CPU, 2 for the RAID array 
[generally only 7200RPM, but still quite hot] ;), 1 more in front for 
incomming cool air, 2 additional on the back for the outgoing hot air, 1 
orthogonal case fan above the CPU, and 1 big 120mm orthogonal above CPU, 
NB, and memory placed approximatelly in the center of the case. So it's 
actually even 12 total. Unfortunatelly it turns out, that the big one in 
the center is the most important one, as it's diverting the airflow, that 
otherwise goes front to back along the casing wall, to the CPU, as 
otherwise the CPU is burried and surrounded with the RAID array and some 
cables from the front side of the case, by a rather big graphics card from 
below (where the frontal additional fan is inserting the cool air), and by 
the casing stiffner from above. So pretty much the two orthogonal fans are 
the only ones reaching the CPU.

This really is an insane configuration, I agree. However though the alarm 
is beeping sometimes during a big load. The system is perfectly stable.

> BTW, if you have the case FAN orthogonal to the CPU's and close to it,
> you'd better stop it as ot will prevent part of the airflow from entering
> the CPU's fan.

This is definitelly not the case here. I have most of the fans attached to 
a regulator, and if I turn the orthogonals off, the temperature of the CPU 
begins to rise very quickly.

> It's amazing to see the number of boxes with a case FAN
> which increases the CPU temperature by 5 degrees once it spins up ! I
> too had one which made my dual athlon regularly crash, and it's OK now
> that I have unplugged it. I noticed it first because the rear CPU was
> 5 degrees hotter than the front one.

Hmm, that may be the case for the dual system, as if the orthogonal fan is 
blowing at one of the CPUs the hot air from it may diverted horizontally 
along the MB to the other CPU and in fact heating it up again, or 
something. It shouldn't be the case for a UP.

Martin
