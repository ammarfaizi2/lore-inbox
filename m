Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBCFOm>; Sat, 3 Feb 2001 00:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBCFOX>; Sat, 3 Feb 2001 00:14:23 -0500
Received: from h0000f8512160.ne.mediaone.net ([24.128.252.23]:48120 "EHLO
	dragon.universe") by vger.kernel.org with ESMTP id <S129098AbRBCFON>;
	Sat, 3 Feb 2001 00:14:13 -0500
Date: Sat, 3 Feb 2001 00:14:09 -0500
From: newsreader@mediaone.net
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: did 2.4 messed up lilo?
Message-ID: <20010203001409.A19031@dragon.universe>
In-Reply-To: <786060000.981147343@tiny> <3A7B63D1.2588963B@megapathdsl.net> <3A7B65BD.1E5E33A8@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A7B65BD.1E5E33A8@megapathdsl.net>; from miles@megapathdsl.net on Fri, Feb 02, 2001 at 05:58:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've now installed 21.6 downloaded from metlab
and all seems to be ok now... well at
least the dell box.. compaq boot sector may
have been blown off for some reason..it won't
boot at all athough this time it's a different
way of being stuck like LI instead of LILO.
I will try ibm box in the morning when the traffic
is light.


On Fri, Feb 02, 2001 at 05:58:21PM -0800, Miles Lane wrote:
> Hmm.  I just downloaded the lilo 21.6 source and the patch appears to
> have
> already been applied.  I got 21.6 from:
> 
> 	http://ftp.cnr.it/Linux/system/boot/lilo/lilo-21.6.1.tar.gz
> 
> Miles Lane wrote:
> > 
> > Chris Mason wrote:
> > >
> > > On Friday, February 02, 2001 03:36:18 PM -0500 newsreader@mediaone.net
> > > wrote:
> > >
> > > > I'm not sure whether this problem is related
> > > > to 2.4 kernel.
> > > >
> > >
> > > I suspect it is a reiserfs problem, and that you are using lilo older than
> > > 21.6.  Are you mounting /boot with -o notail?
> > >
> > > Regardless, I'm willing to bet upgrading to lilo 21.6 will solve this.  It
> > > calls an ioctl reiserfs provides to unpack small files, and I've seen it
> > > fix this exact problem on one of my devel boxes (no lilo prompt, append
> > > lines in lilo.conf ignored).
> > 
> > I also found this patch for lilo 21.6:
> > 
> > http://industrial-linux.org/distro/download/lilo-21.6-glibc-2.2-reiserfs.patch
> > 
> > Perhaps someone familiar with the lilo and reiserfs code could explain
> > whether or not this patch is really needed.
> > 
> >         Miles
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
