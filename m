Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCVNL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCVNL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVCVNL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:11:26 -0500
Received: from king.bitgnome.net ([70.84.111.244]:3756 "EHLO king.bitgnome.net")
	by vger.kernel.org with ESMTP id S261192AbVCVNLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:11:20 -0500
Date: Tue, 22 Mar 2005 07:11:16 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sean Russell <ser@ser1.net>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[01] freeze on x86_64
Message-ID: <20050322131116.GA15512@king.bitgnome.net>
References: <423F5152.2010303@ser1.net> <m13buo3vew.fsf@muc.de> <423FC2ED.1090704@ser1.net> <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2005, Jan Engelhardt wrote:
> >> >    acpi_thermal-0400 [23] acpi_thermal_get_trip_: Invalid active
> >> > threshold [0]
> >> 
> >> You mean you got this in /var/log/messages?
> >
> > Yes, in /var/log/messages.  The lock up occurs without warning, so the only
> > opportunity I have to look for error messages is in the syslogs.
> >
> >> Can you connect a serial console or netconsole and see if that 
> >> 
> > Er... by serial console, I assume you mean via a serial cable and some other
> > device.  If so, then no, I don't have that capability.  I didn't know about
> > netconsole before you mentioned it; I'll do some research and set it up.  I do
> > have a second computer (well, my wife's laptop is also running Linux) that I
> > could use to monitor UDP traffic, if I can figure out what to use as a client
> > to capture the messages.  This may take me a couple of days.
> 
> Serial console -- only requires a serial cable, available in the next computer 
> store -- also works with non-Linux, non-x86 and (mostly) systems-w/o-compiler.
> 
> 
> Jan Engelhardt

	I've actually got old dumb terminals sitting around.
I'll hook one up and set the oops=panic option also.  Maybe we
can nail this down as I've pretty much avoided using my x86-64
desktop ever since.  I'd been torn trying to decide whether or
not to migrate to a different file system.

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
He hoped and prayed that there wasn't an afterlife. Then he
realized there was a contradiction involved here and merely
hoped that there wasn't an afterlife.
 -- Douglas Adams
----end random quote of the moment----
