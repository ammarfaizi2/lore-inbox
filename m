Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbRBFB2B>; Mon, 5 Feb 2001 20:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbRBFB1w>; Mon, 5 Feb 2001 20:27:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34572 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129483AbRBFB1d>;
	Mon, 5 Feb 2001 20:27:33 -0500
Date: Tue, 6 Feb 2001 02:27:22 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Gregory T. Norris" <haphazard@socket.net>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010206022722.D9025@suse.de>
In-Reply-To: <20010205192235.A1567@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010205192235.A1567@glitch.snoozer.net>; from haphazard@socket.net on Mon, Feb 05, 2001 at 07:22:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05 2001, Gregory T. Norris wrote:
> On Mon, Jan 15 2001, Jens Axboe wrote:                 
> > Could you try with this patch, so maybe we can get some hints as to  
> > what is going on?
> 
> Here's what I got after applying your patch to 2.4.1:
> 
> ----- SNIP -----
> Feb  5 17:25:26 glitch kernel: VFS: Disk change detected on device sr(11,0)
> Feb  5 17:25:26 glitch kernel: VFS: Disk change detected on device sr(11,0)
> Feb  5 17:25:26 glitch kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> Feb  5 17:25:26 glitch kernel: Mode Sense (10) 00 0e 00 00 00 00 00 18 00 
> Feb  5 17:25:26 glitch kernel: [valid=0] Info fld=0x0, Current sr00:00: sense key Illegal Request
> Feb  5 17:25:26 glitch kernel: Additional sense indicates Invalid command operation code
> ----- SNIP -----

Interesting, does audio volume control work if you play an audio cd?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
