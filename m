Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSGCQtq>; Wed, 3 Jul 2002 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGCQti>; Wed, 3 Jul 2002 12:49:38 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:52701 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317182AbSGCQrs>; Wed, 3 Jul 2002 12:47:48 -0400
Date: Wed, 3 Jul 2002 05:02:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020703030208.GA474@elf.ucw.cz>
References: <3D18A273.284F8EDD@zip.com.au> <1025025852.1519.54.camel@turbulence.megapathdsl.net> <3D18C5E4.B7423294@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D18C5E4.B7423294@zip.com.au>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ..
> > > If it's because of the disk-spins-up-too-much problem then
> > > that can be addressed by allowing the commit interval to be
> > > set to larger values.
> > 
> > Thanks Andrew,
> > 
> > Yes, the concern is the syncing every few seconds.
> > Would it be possible and make sense to have this
> > setting get adjusted dynamically when a laptop goes
> > onto battery power?
> 
> If the APM/ACPI stuff can report the transition to userspace then yes,
> that's something which their support scripts could do.

ACPI should be able to pass that info.

Please make that patch go to linus, it looks very usefull to me.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
