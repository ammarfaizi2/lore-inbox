Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbRHAUKg>; Wed, 1 Aug 2001 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHAUK0>; Wed, 1 Aug 2001 16:10:26 -0400
Received: from quattro.sventech.com ([205.252.248.110]:16658 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S268067AbRHAUKM>; Wed, 1 Aug 2001 16:10:12 -0400
Date: Wed, 1 Aug 2001 16:10:06 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: linux-kernel@vger.kernel.org, agmon@techunix.technion.ac.il
Subject: Re: SMP possible with AMD CPUs?
Message-ID: <20010801161005.B784@sventech.com>
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>; from nyh@math.technion.ac.il on Wed, Aug 01, 2001 at 11:04:41PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001, Nadav Har'El <nyh@math.technion.ac.il> wrote:
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

Yes. In fact, recent 2.2 kernels (2.2.20 pre patches I believe) and all
2.4 kernels support SMP AMD systems.

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

I don't know if this was true to begin with, but I know that SMP AMD
systems use the APIC SMP scheme Intel defined and uses.

JE

