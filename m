Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbRFYTGi>; Mon, 25 Jun 2001 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFYTG1>; Mon, 25 Jun 2001 15:06:27 -0400
Received: from 24.157.217.96.on.wave.home.com ([24.157.217.96]:11537 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S264256AbRFYTGM>;
	Mon, 25 Jun 2001 15:06:12 -0400
Date: Mon, 25 Jun 2001 09:40:24 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jeff Mahoney <jeffm@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: <15150.58266.85737.742044@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.30.0106250938540.9975-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not /dev/hda42, thats odd. From 2.4.5 -> 2.4.6 ReiserFS would refuse to
mount the drive on startup.

I noticed in pre5 there was a reiserfs fix to something but im not sure if
its related or not.

My domain is also back so I'm going to resubscribe.

Shawn.

On Tue, 19 Jun 2001, Neil Brown wrote:

> On Tuesday June 19, jeffm@suse.com wrote:
> > On Mon, Jun 18, 2001 at 11:57:16PM -0400, Shawn Starr wrote:
> > >
> > > read_super_block: can't find a reiserfs filesystem on dev 03:42
> > > read_old_super_block: try to find super block in old location
> > > read_old_super_block: can't find a reiserfs filesystem on dev 03:42
> > > Kernel Panic: VFS: Unable to mount root fs on 03:42
> > >
> > > my super block broke somewhere?
> >
> >     Out of curiousity, what device are you trying to boot from? 03:42, at least
> >     according to linux/Documentation/devices.txt, corresponds to /dev/hda42.
>
> or, noting that kdevname used hexadecimal,
>   /dev/hdb2
>
> NeilBrown
>
> >
> >     Is that really the disk you're trying to mount? I'm not familiar with how
> >     some IDE RAID controllers present disks, but it was the first thing I
> >     noticed.
> >
> >     -Jeff
> >
> > --
> > Jeff Mahoney
> > jeffm@suse.com
> > jeffm@csh.rit.edu
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>

