Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRIRPbn>; Tue, 18 Sep 2001 11:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272196AbRIRPbd>; Tue, 18 Sep 2001 11:31:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47462 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272181AbRIRPbR>; Tue, 18 Sep 2001 11:31:17 -0400
Date: Tue, 18 Sep 2001 17:31:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: jogi@planetzork.ping.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Message-ID: <20010918173142.G19092@athlon.random>
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172529.A6698@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918172529.A6698@planetzork.spacenet>; from jogi@planetzork.ping.de on Tue, Sep 18, 2001 at 05:25:29PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:25:29PM +0200, jogi@planetzork.ping.de wrote:
> On Tue, Sep 18, 2001 at 05:14:16PM +0200, jogi@planetzork.ping.de wrote:
> > Hello Andrea,
> > 
> > I gave your new vm a try and I have to report a problem. System is an
> > Athlon 1200 with 256MB memory. Workload:
> 
> Sorry to follow up on my own. But the problem seems to be worse than I
> first thought. Kernel build is the first thing I test when I try a new
> kernel :-)
> 
> So now I logged into X and even during starting of Mozilla or normal
> web browsing alsaplayer is skiping *lots*. The system is not into swap
> and has about 150MB cached. Just to let you know ...
> 
> I guess I will go back to -pre10 now. If you want to let me test some
> things just let me know.

just make sure not to renice top at -10. Are you sure you reniced top at
-10 also with pre10? Those issues shouldn't really vm related. I also
profiled the new vm well and it never showed up in the toplist so I
suspect you changed something in userspace. and of course I run xmms all
the time too and it didn't skept one sample yet.


Andrea
