Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157620AbQGaStr>; Mon, 31 Jul 2000 14:49:47 -0400
Received: by vger.rutgers.edu id <S157675AbQGaSjE>; Mon, 31 Jul 2000 14:39:04 -0400
Received: from p3EE0A3D8.dip.t-dialin.net ([62.224.163.216]:62534 "EHLO cerebro") by vger.rutgers.edu with ESMTP id <S159984AbQGaSiW>; Mon, 31 Jul 2000 14:38:22 -0400
Date: Mon, 31 Jul 2000 20:58:19 +0200
From: Marc Lehmann <pcg@goof.com>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731205819.A28267@cerebro.laendle>
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net> <20000731171858.J2243@cerebro.laendle> <20000731184048.L2224@lxMA.mediaways.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.1i
In-Reply-To: <20000731184048.L2224@lxMA.mediaways.net>; from matthias.andree@gmx.de on Mon, Jul 31, 2000 at 06:40:48PM +0200
X-Operating-System: Linux version 2.2.16 (root@cerebro) (gcc driver version pgcc-2.95.2 19991024 (release) executing gcc version 2.7.2.3) 
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, Jul 31, 2000 at 06:40:48PM +0200, Matthias Andree <matthias.andree@gmx.de> wrote:
> > messages from the kernel drawing for your attention and not putting the
> > drive to sleep.
> 
> The error message is natural, a drive put to sleep is put there
> permanently, since the drive is supposed to power down its interface

It still isn't an error, though, and linux could, if it were
better-than-neccessary, take this into account.

Linux doesn't bitch on spinned-down scsi disks at boot either, but
properly starts them.

> Since SCSI drives are only manually powered down, the Kernel is fine in
> this respect

"Fine" = "lacks any support". So just for me, that isn't fine. But it's
bearable ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
