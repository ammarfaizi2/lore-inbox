Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWCMD1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWCMD1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWCMD1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:27:12 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:5855 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751300AbWCMD1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:27:12 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd
	(alsa	1.0.10 vs. recent kernels)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: nando@ccrma.Stanford.EDU, cc@ccrma.Stanford.EDU,
       Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4414DBFE.1050400@yahoo.com.au>
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
Content-Type: text/plain
Date: Sun, 12 Mar 2006 19:26:25 -0800
Message-Id: <1142220385.7471.46.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 13:42 +1100, Nick Piggin wrote:
> Fernando Lopez-Lezcano wrote:
> 
> > Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
> > with alsa stable 1.0.10 and googled for the obvious two chunks that
> > stood out :-)
> > 
> 
> Well, good work on tracking it down. I guess you should forward
> forward your patch to the ALSA guys.

It fixes 1.0.10 with recent kernels but I guess 1.0.10 is old so maybe
it will not get patched (just a guess) - what would that be, 1.0.10a?.
1.0.11rc3 did not trigger the problem in a quick test but I could swear
it did before, I'll have to retest again tomorrow (maybe it was
happening with a different card).

-- Fernando


