Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281522AbRKHLie>; Thu, 8 Nov 2001 06:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKHLi0>; Thu, 8 Nov 2001 06:38:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59402 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281520AbRKHLiT>;
	Thu, 8 Nov 2001 06:38:19 -0500
Date: Thu, 8 Nov 2001 12:38:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: J Sloan <jjs@pobox.com>, J Sloan <jjs@lexus.com>,
        Robert Love <rml@tech9.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: preempt-patch cleared of blame
Message-ID: <20011108123808.I27652@suse.de>
In-Reply-To: <20011108113615.F27652@suse.de> <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08 2001, Ingo Molnar wrote:
> 
> On Thu, 8 Nov 2001, Jens Axboe wrote:
> 
> > On Wed, Nov 07 2001, J Sloan wrote:
> > > I think there may be a problem with the
> > > compaq smart/2p raid drivers, since
> > > the "do_ida_intr" code keeps showing
> > > up in the oops, and I have not seen a
> > > problem with 2.4.14 on any other system.
> >
> > Does this fix it?
> 
> it did the trick on my system, which used to oops in/around do_ida_intr as
> well.

Good, so it was a dequeue race. Thanks Ingo.

-- 
Jens Axboe

