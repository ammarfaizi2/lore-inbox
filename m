Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRDCQHW>; Tue, 3 Apr 2001 12:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDCQHN>; Tue, 3 Apr 2001 12:07:13 -0400
Received: from [209.125.249.77] ([209.125.249.77]:62982 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S132167AbRDCQHD>; Tue, 3 Apr 2001 12:07:03 -0400
Date: Tue, 3 Apr 2001 09:05:13 -0700
Message-Id: <200104031605.f33G5D604937@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14kQJI-00081v-00@the-village.bc.nu>
In-Reply-To: <3AC9BEEF.A2EC0CA@evision-ventures.com>
	<E14kQJI-00081v-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > One thing I certainly miss: DevFS is not mandatory (yet).
> > 
> > That's "only" due to the fact that DevFS is an insanely racy and
> > instable
> > piece of CRAP. I'm unhappy it's there anyway...
> 
> It certainly seems to have some race conditions but other than that
> and the slight problem it puts policy in the kernel it seems ok. I'd
> prefer it was userspace and implemented via /sbin/hotplug - but that
> isnt possible yet and opens a whole other set of interesting races
> to ponder

Yes, devfs has some races. They are in the process of getting
fixed. Yes, it's taken a long time (moving house twice in 6 months and
several travel trips take their toll on productivity).

However, a large number of people run devfs on small to large systems,
and these "races" aren't causing problems. People tell me it's quite
stable. I run devfs on my systems, and not once have I had a problem
due to devfs "races". So I feel it's quite unfair to paint such a dire
picture (I'm referring to Martin's comments here, not Alan's).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
