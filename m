Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRBKSVJ>; Sun, 11 Feb 2001 13:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRBKSU7>; Sun, 11 Feb 2001 13:20:59 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:3844 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129160AbRBKSUw>;
	Sun, 11 Feb 2001 13:20:52 -0500
Date: Sun, 11 Feb 2001 16:20:47 -0200
From: Rogerio Brito <rbrito@iname.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010211162047.A1003@iname.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144803.B5285@suse.de> <20010210224620.C7877@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010210224620.C7877@bug.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10 2001, Pavel Machek wrote:
> Hi!
> 
> > 	ioctl(cd_fd, CDROM_SELECT_SPEED, speed);
> 
> Does this actually work? I helped my friend with partly broken cdrom
> (worked only at low speeds) and it did not have much effect. It did
> not make my cdrom quiet, either, AFAI can remember.

	Well, I wrote a little program that just makes this call that
	Jens told me about and it worked perfectly with my hardware --
	using my CD-ROM drive at speed 1, 2 or 4, it works quietly and
	I can listen to MP3s at volumes that I couldn't earlier.

	OTOH, it seems that a paradox is happening: this very same
	drive has some problems (not always reproducible) reading some
	CD-RW discs when it operates at very slow speeds. In this
	case, the best that I can do is to let the drive accelerate as
	much as it wants and then it works ok.

	BTW, Jens, what is the way to set the drive back to its
	maximum speed, without limits? Where could I read more about
	the subject (that is, this and other ioctl's) without annoying
	you? I'm a moderately competent C programmer (only
	moderately), but I know *nothing* about the kernel.


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
