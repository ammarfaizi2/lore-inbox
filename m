Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129313AbRBENsc>; Mon, 5 Feb 2001 08:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131266AbRBENsX>; Mon, 5 Feb 2001 08:48:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7688 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129313AbRBENsK>;
	Mon, 5 Feb 2001 08:48:10 -0500
Date: Mon, 5 Feb 2001 14:48:03 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Rogerio Brito <rbrito@iname.com>
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010205144803.B5285@suse.de>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010205013424.A15384@iname.com>; from rbrito@iname.com on Mon, Feb 05, 2001 at 01:34:24AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05 2001, Rogerio Brito wrote:
> 	Well, this has nothing to do with the above, but is there any
> 	utility or /proc entry that lets me say to my CD drive that it
> 	should not work at full speed?
> 
> 	Basically, some drives make way too much noise when they're
> 	operating at full speed. When I'd like to listen to some MP3s
> 	from a burned CD-R, what I'm currently doing is copying the
> 	files that I want to /tmp and listening from there, but this
> 	is obviously a dirty solution. :-(

	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
