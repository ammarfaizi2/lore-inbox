Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbTLFLqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbTLFLqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:46:00 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:26336 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S265139AbTLFLp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:45:56 -0500
Date: Sun, 07 Dec 2003 00:46:00 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: High-pitch noise with 2.6.0-test11
Message-ID: <49413492.1070757960@[192.168.1.249]>
In-Reply-To: <1070605910.4867.9.camel@idefix.homelinux.org>
References: <1070605910.4867.9.camel@idefix.homelinux.org>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nearly all Dell laptops do this, it's the power supply making that noise. 
The supply won't fail, but it's bad for the batteries.  The solution in 2.4 
was to turn off 'APM calls when CPU idle'.  I suspect unloading thermal.o 
has the same effect.

As for X, do you have the Synaptics touchpad X driver in Fedora core?  You 
probably need the kernel driver as well, and to check out the documentation 
(sorry, no pointer handy).  It's a bit different, in that the driver 
suppresses taps and clicks that are too close in time (by a configurable 
amount) to typing.  This avoids the common false mouse clicks caused by 
case flexure setting off the touchpad.  It also implements X events for 
corner taps, edge scroll regions, and pressure sense.  All in all, much 
better once understood, but it is different.

Andrew

--On Friday, 5 December 2003 1:31 a.m. -0500 Jean-Marc Valin 
<Jean-Marc.Valin@USherbrooke.ca> wrote:

> Hi,
>
> I just installed 2.6.0-test11 on my Dell Latitude D600 (Pentium-M)
> laptop and I noticed a strange high-pitch noise comming from the laptop
> itself (that wasn't there with 2.4). The noise happens only when the CPU
> is idle. Also, I have noticed that removing thermal.o makes the noise
> stop, which is very odd. Is there anything that can be done about that?
>
> Another (unrelated) problem I noticed is the fact that since I upgraded
> to 2.6, X started behaving strangely wrt left-click copy and
> middle-click paste. Any idea what the cause can be? I'm using Fedora
> Core 1.
>
> Thanks,
>
> 	Jean-Marc
>
> P.S. Please CC to me, since I'm not subscribed
>
> --
> Jean-Marc Valin, M.Sc.A., ing. jr.
> LABORIUS (http://www.gel.usherb.ca/laborius)
> Université de Sherbrooke, Québec, Canada



---------
Andrew McGregor
Director, Scientific Advisor
IndraNet Technologies Ltd
http://www.indranet-technologies.com/
