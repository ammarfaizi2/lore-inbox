Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317379AbSGDI5x>; Thu, 4 Jul 2002 04:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSGDI5w>; Thu, 4 Jul 2002 04:57:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59815 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317379AbSGDI5v>;
	Thu, 4 Jul 2002 04:57:51 -0400
Date: Thu, 4 Jul 2002 11:00:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020704090010.GB6204@suse.de>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de> <3D2409FA.44E88C1D@zip.com.au> <20020704083941.GA6204@suse.de> <20020704085735.GA1175@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704085735.GA1175@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04 2002, Joe Thornber wrote:
> On Thu, Jul 04, 2002 at 10:39:41AM +0200, Jens Axboe wrote:
> > Which just means that device mapper needs to do the stacking properly,
> > EOD.
> 
> You don't think it does it properly ATM ?

Well as I said, it's in the grey zone. If you look at stacking from a
submission and end_io point of view, then yes it works. Anywhere in
between, no it doesn't.

See my previous mails in this thread :-)

-- 
Jens Axboe

