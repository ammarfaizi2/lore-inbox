Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbRGTUfb>; Fri, 20 Jul 2001 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbRGTUfV>; Fri, 20 Jul 2001 16:35:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267321AbRGTUfJ>;
	Fri, 20 Jul 2001 16:35:09 -0400
Date: Fri, 20 Jul 2001 22:35:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loop broken again (2.4.6-ac4)
Message-ID: <20010720223502.B3969@suse.de>
In-Reply-To: <3B57A811.9030408@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B57A811.9030408@lycosmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19 2001, Adam Schrotenboer wrote:
> Jens,
> 
> Remember several weeks ago when I mentioned a problem w/ ridicyulous 
> mod-use counts w/ loop.o???
> Well, it's back again 2.4.5-ac19 (IIRC) worked fine.
> 
> Basically, the result of attempting sudo losetup -d /dev/loop0 is the 
> following
> 
> ioctl LOOP_CLR_FD Device or resource busy
> 
> strace shows EBUSY
> 
> lsmod shows a use count of 563.

I've had no time to look at this, so feel free to dig in and find out
why the usage count is getting screwed... It's probably just a silly
little bug somewhere, I'm guessing a one-liner fix :-)

-- 
Jens Axboe

