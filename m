Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157443AbQGaPBD>; Mon, 31 Jul 2000 11:01:03 -0400
Received: by vger.rutgers.edu id <S157625AbQGaPA0>; Mon, 31 Jul 2000 11:00:26 -0400
Received: from pC19EBC8F.dip.t-dialin.net ([193.158.188.143]:62414 "EHLO cerebro") by vger.rutgers.edu with ESMTP id <S157402AbQGaO6y>; Mon, 31 Jul 2000 10:58:54 -0400
Date: Mon, 31 Jul 2000 17:18:59 +0200
From: Marc Lehmann <pcg@goof.com>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731171858.J2243@cerebro.laendle>
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.1i
In-Reply-To: <20000731165300.I2224@lxMA.mediaways.net>; from matthias.andree@gmx.de on Mon, Jul 31, 2000 at 04:53:00PM +0200
X-Operating-System: Linux version 2.2.16 (root@cerebro) (gcc driver version pgcc-2.95.2 19991024 (release) executing gcc version 2.7.2.3) 
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, Jul 31, 2000 at 04:53:00PM +0200, Matthias Andree <matthias.andree@gmx.de> wrote:
> My point is: putting a drive to sleep rather than to standby will not
> help much, it will only delay the spin-up and possibly leave you with a
> slower drive.

Cool logic. How do you define "much"? Drive electronics can still use
a lot of power, and most users (xuan and me excluded ;) want this for
power-save.

In practise, of course, there is a clear trade-off between ugly error (!)
messages from the kernel drawing for your attention and not putting the
drive to sleep.

In general, the kernel support is lacking much with respect to
power-savings (just spin down your scsi-drive to get some nice hang (and
yes, I know the scsi-idle patch)).

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
