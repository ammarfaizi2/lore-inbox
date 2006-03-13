Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWCMDcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCMDcB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCMDcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:32:00 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:62885 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751239AbWCMDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:32:00 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd
	(alsa	1.0.10 vs. recent kernels)
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, cc@ccrma.Stanford.EDU,
       Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1142220385.7471.46.camel@cmn3.stanford.edu>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
	 <1141958866.22708.69.camel@cmn3.stanford.edu>
	 <441109BC.9070705@yahoo.com.au>
	 <1142016627.6124.33.camel@cmn3.stanford.edu>
	 <44121351.2050703@yahoo.com.au>
	 <1142210977.7471.27.camel@cmn3.stanford.edu>
	 <4414DBFE.1050400@yahoo.com.au>
	 <1142220385.7471.46.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 22:31:55 -0500
Message-Id: <1142220716.25358.273.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 19:26 -0800, Fernando Lopez-Lezcano wrote:
> On Mon, 2006-03-13 at 13:42 +1100, Nick Piggin wrote:
> > Fernando Lopez-Lezcano wrote:
> > 
> > > Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
> > > with alsa stable 1.0.10 and googled for the obvious two chunks that
> > > stood out :-)
> > > 
> > 
> > Well, good work on tracking it down. I guess you should forward
> > forward your patch to the ALSA guys.
> 
> It fixes 1.0.10 with recent kernels but I guess 1.0.10 is old so maybe
> it will not get patched (just a guess) - what would that be, 1.0.10a?.
> 1.0.11rc3 did not trigger the problem in a quick test but I could swear
> it did before, I'll have to retest again tomorrow (maybe it was
> happening with a different card).

Older ALSA with a newer kernel has never been supported.  Why would you
want to replace the ALSA in the kernel with an old version?

Lee

