Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRBKKrN>; Sun, 11 Feb 2001 05:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbRBKKrD>; Sun, 11 Feb 2001 05:47:03 -0500
Received: from [194.213.32.137] ([194.213.32.137]:10756 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132152AbRBKKqW>;
	Sun, 11 Feb 2001 05:46:22 -0500
Message-ID: <20010210224620.C7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:46:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Cc: Rogerio Brito <rbrito@iname.com>
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144803.B5285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010205144803.B5285@suse.de>; from Jens Axboe on Mon, Feb 05, 2001 at 02:48:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	Well, this has nothing to do with the above, but is there any
> > 	utility or /proc entry that lets me say to my CD drive that it
> > 	should not work at full speed?
> > 
> > 	Basically, some drives make way too much noise when they're
> > 	operating at full speed. When I'd like to listen to some MP3s
> > 	from a burned CD-R, what I'm currently doing is copying the
> > 	files that I want to /tmp and listening from there, but this
> > 	is obviously a dirty solution. :-(
> 
> 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);

Does this actually work? I helped my friend with partly broken cdrom
(worked only at low speeds) and it did not have much effect. It did
not make my cdrom quiet, either, AFAI can remember.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
