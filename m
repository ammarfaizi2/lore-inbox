Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHAUR1>; Wed, 1 Aug 2001 16:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268077AbRHAURR>; Wed, 1 Aug 2001 16:17:17 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:35993 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S268071AbRHAURB>; Wed, 1 Aug 2001 16:17:01 -0400
Date: Wed, 1 Aug 2001 13:22:00 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
cc: <linux-kernel@vger.kernel.org>, <agmon@techunix.technion.ac.il>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>
Message-ID: <Pine.LNX.4.33.0108011318120.19875-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

before the althon amd k6's would have used pic design called the open pic
to do smp... but since nobody implemented the openpic it's kinda hard to
use it...

the combination of the athlon mp and the amd 761 chipset will do
multiprocessor support without trouble... you will want to use 2.4 becuase
lots of devices on the boards  aren't supported by 2.2...

joelja

On Wed, 1 Aug 2001, Nadav Har'El wrote:

> A Linux user in a local Linux club asked me whether Linux support SMP with
> AMD (rather than Intel Pentium) CPUs. She said that a year ago she was told
> Linux 2.2 couldn't, and that she was wondering whether the new Linux 2.4 can.
> I didn't know the answer, so I started digging.
>
> I tried looking with various search search engines, but found nothing about
> this subject. Looking through the source code, it appears that SMP with AMDs
> *might* be supported, but I couldn't find any comment confirming that. The
> relevant FAQs, READMEs, and so on that I found are all from the 2.2 kernel
> era.
>
> So, does Linux support SMP on AMD CPUs?
>
> By the way, here's a fragment from the outdated (1999) SMP-HOWTO at
> http://www.phy.duke.edu/brahma/smp-faq/smp-howto-3.html explaining why SMP
> wasn't possible in kernel 2.2 and contemporary AMD processors:
>
>      1.  Can I use my Cyrix/AMD/non-Intel CPU in SMP?
>
>          Short answer: no.
>
>          Long answer: Intel claims ownership to the APIC SMP scheme, and
>          unless a company licenses it from Intel they may not use it. There
>          are currently no companies that have done so. (This of course can
>          change in the future) FYI - Both Cyrix and AMD support the non-
>          proprietary OpenPIC SMP standard but currently there are no
>          motherboards that use it.
>
> Thanks.
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


