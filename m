Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRIRPvx>; Tue, 18 Sep 2001 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272407AbRIRPvo>; Tue, 18 Sep 2001 11:51:44 -0400
Received: from lilly.ping.de ([62.72.90.2]:53774 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S272439AbRIRPvb>;
	Tue, 18 Sep 2001 11:51:31 -0400
Date: 18 Sep 2001 17:51:04 +0200
Message-ID: <20010918175104.D6698@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918174434.I19092@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:44:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:44:34PM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 18, 2001 at 05:35:15PM +0200, jogi@planetzork.ping.de wrote:
> > Since I am not using md there are not that much changes left between
> > -pre10 and -pre11. Or do you think that it is caused by the console
> > locking changes?
> 
> certainly not from the console locking changes. Can you just go back to
> pre10 and verify you don't get those skips to just to be 100% sure the
> userspace config is the same?
> 
> The only scheduler change in pre11 is this one:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre10aa1/00_sched-rt-fix-1
> 
> which should be infact a bugfix for rt threads, also discussed on l-k
> recently, so it's not clear how this odd regression happened.
> 
> You can try to back it out and see if helps just in case.

Ok Andrea,

I will test and let you know about the findings but I am afraid I can not
test this today. But I will let you know. Btw. xmms is skipping like mad
too.

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
