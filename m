Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbTLKRSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbTLKRSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:18:40 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:30339 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S265193AbTLKRSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:18:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: Thu, 11 Dec 2003 12:18:35 -0500
User-Agent: KMail/1.5.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1071122742.5149.12.camel@idefix.homelinux.org> <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]>
In-Reply-To: <1293500000.1071127099@[10.10.2.4]>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111218.35254.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 11:18:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 02:18, Martin J. Bligh wrote:
>>> Why would you want to *increase* HZ? I'd say 1000 is already too
>>> high personally, but I'm curious what you'd want to do with it?
>>> Embedded real-time stuff?
>>
>> Actually, my reasons may sound a little strange, but basically I'd
>> be fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound
>> when the CPU is idle (probably bad capacitors). By increasing HZ
>> to 10 kHz, the sound is at a frequency where the ear is much less
>> sensitive. Anyway, I thought some people might be interested in
>> high HZ for other (more fundamental) reasons, so I posted the
>> patch.
>
>Ha! ;-)
>A hardware fix might be in order ;-)

Indeed...  I may have the only un-repaired Biostar M7VIB in the area 
out of several dozen.  All the rest have had those 4 caps right above 
the AGP slot replaced already.  And this one may also be the only one 
that doesn't get shut off at night.  However it is also very unstable 
when starting from cold, needing 3-5 resets to even get through post 
without trashing the video after I had it apart to clean the cpu 
fan/sink and psu the other night.  Its stable once thats been done, 
so I'm as usual, procrastinating.  Been doing it for 69 years now. :)

Hardware indeed.  I'm a Certified Electronics Technician.  Have 
someone check all those electrolyric caps in the on-board psu in 
particular, using a device similar to a "Capacitor Wizard" which 
measures not the capacity of the cap, but the caps Equivalent Series 
Resistance (ESR) at 100 kilohertz or more.  Anything over half an ohm 
should be replaced forthwith.  This assumes of course that your tech 
in charge of hot solder has the tools to do it correctly.  If not, 
find one who does have the tools.

Many mobos in a period ranging from about 2.5 to 1.5 years ago were 
built with caps that go defective prematurely due to a bad batch of 
them from several far eastern cap makers who were fed a bad recipe 
for the electrolyte in the caps, eg the Ethylene Glycol wasn't near 
pure enough.

>M.
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

