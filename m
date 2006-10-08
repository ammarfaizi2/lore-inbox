Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWJHRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWJHRFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJHRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:05:45 -0400
Received: from brick.kernel.dk ([62.242.22.158]:44840 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751282AbWJHRFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:05:45 -0400
Date: Sun, 8 Oct 2006 19:05:38 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20061008170538.GZ8814@kernel.dk>
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608131815.12873.mlkernel@mortal-soul.de> <20061006175833.4ef08f06@localhost> <200610081628.55012.christiand59@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610081628.55012.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08 2006, Christian wrote:
> Am Freitag, 6. Oktober 2006 17:58 schrieb Paolo Ornati:
> > On Sun, 13 Aug 2006 18:15:12 +0200
> >
> > Matthias Dahl <mlkernel@mortal-soul.de> wrote:
> > > Just let me know once you got them, so I can safely delete them again.
> > >
> > > At the moment, I am trying without preemption but for example doing a
> > > untar kernel sources still results in sluggish system responsiveness. :-(
> >
> > I used to have this type of problem and 2.6.19-rc1 looks much better
> > than 2.6.18.
> >
> > I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> > and /proc/sys/vm/swappiness = 20.
> 
> 
> Which change in the new kernel has made it better? I was following the lkml 
> very close and didn't see any change that could have fixed that problem.

There is a substantial CFQ update, so it could be that. Or it could be
something unrelated of course, I didn't check if eg the cpu scheduler
changed much. Or vm :-)

-- 
Jens Axboe

