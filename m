Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268087AbRHAUE4>; Wed, 1 Aug 2001 16:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268067AbRHAUEq>; Wed, 1 Aug 2001 16:04:46 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:50431 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S268060AbRHAUEf>; Wed, 1 Aug 2001 16:04:35 -0400
Date: Wed, 1 Aug 2001 23:04:41 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: linux-kernel@vger.kernel.org
Cc: agmon@techunix.technion.ac.il
Subject: SMP possible with AMD CPUs?
Message-ID: <20010801230441.A19396@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Hebrew-Date: 13 Av 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Linux user in a local Linux club asked me whether Linux support SMP with
AMD (rather than Intel Pentium) CPUs. She said that a year ago she was told
Linux 2.2 couldn't, and that she was wondering whether the new Linux 2.4 can.
I didn't know the answer, so I started digging.

I tried looking with various search search engines, but found nothing about
this subject. Looking through the source code, it appears that SMP with AMDs
*might* be supported, but I couldn't find any comment confirming that. The
relevant FAQs, READMEs, and so on that I found are all from the 2.2 kernel
era.

So, does Linux support SMP on AMD CPUs?

By the way, here's a fragment from the outdated (1999) SMP-HOWTO at
http://www.phy.duke.edu/brahma/smp-faq/smp-howto-3.html explaining why SMP
wasn't possible in kernel 2.2 and contemporary AMD processors:

     1.  Can I use my Cyrix/AMD/non-Intel CPU in SMP?

         Short answer: no.

         Long answer: Intel claims ownership to the APIC SMP scheme, and
         unless a company licenses it from Intel they may not use it. There
         are currently no companies that have done so. (This of course can
         change in the future) FYI - Both Cyrix and AMD support the non-
         proprietary OpenPIC SMP standard but currently there are no
         motherboards that use it.

Thanks.

-- 
Nadav Har'El                        |       Wednesday, Aug  1 2001, 13 Av 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |The socks in my drawer are like
http://nadav.harel.org.il           |snowflakes: No two are alike.
