Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262138AbSJAQg3>; Tue, 1 Oct 2002 12:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSJAQg3>; Tue, 1 Oct 2002 12:36:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8876 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262138AbSJAQg1>;
	Tue, 1 Oct 2002 12:36:27 -0400
Date: Tue, 1 Oct 2002 18:41:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001164136.GG5755@suse.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de> <20021001160608.GX3867@suse.de> <20021001163508.GA30457@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001163508.GA30457@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Joe Thornber wrote:
> On Tue, Oct 01, 2002 at 06:06:08PM +0200, Jens Axboe wrote:
> > On Tue, Oct 01 2002, Dave Jones wrote:
> > > Consider it patch 1/2 of the device mapper merge 8-)
> > 
> > Indeed, the patches are also arriving out of order though, LVM remove
> > patch should be 2/2 not 1/2. IMO.
> 
> If LVM remotely worked I would agree with you.

No matter the state of lvm, it's much better to day "1, here's the
replacement - 2, rip the old one out". What if device mapper for 2.5
really sucks? Maybe it's so bad that we'd rather fix up lvm1? Apparently
davej has patches that sort-of makes lvm work.

It's not likely, but still :-)

-- 
Jens Axboe

