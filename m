Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRBKQsG>; Sun, 11 Feb 2001 11:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRBKQrq>; Sun, 11 Feb 2001 11:47:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4878 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129723AbRBKQrd>;
	Sun, 11 Feb 2001 11:47:33 -0500
Date: Sun, 11 Feb 2001 17:47:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Rogerio Brito <rbrito@iname.com>
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010211174707.I16362@suse.de>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144803.B5285@suse.de> <20010210224620.C7877@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010210224620.C7877@bug.ucw.cz>; from pavel@suse.cz on Sat, Feb 10, 2001 at 10:46:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10 2001, Pavel Machek wrote:
> > 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);
> 
> Does this actually work? I helped my friend with partly broken cdrom
> (worked only at low speeds) and it did not have much effect. It did
> not make my cdrom quiet, either, AFAI can remember.

It's no news that vendors only implement what they want to. New
cd-r/w and dvd drives are not required to implement this command,
so it may not work there either.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
