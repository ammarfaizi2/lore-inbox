Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSLDV0G>; Wed, 4 Dec 2002 16:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSLDV0G>; Wed, 4 Dec 2002 16:26:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9708 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267097AbSLDV0F>; Wed, 4 Dec 2002 16:26:05 -0500
Date: Wed, 4 Dec 2002 22:33:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "George G. Davis" <davis_g@attbi.com>
Cc: Jim Van Zandt <jrv@vanzandt.mv.com>, device@lanana.org,
       linux-kernel@vger.kernel.org
Subject: Why does the _DoubleTalk card_ not have a major assigned?
Message-ID: <20021204213325.GG2544@fs.tum.de>
References: <20021204205525.GE2544@fs.tum.de> <3DEE70C4.5D74A8B3@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEE70C4.5D74A8B3@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 04:16:52PM -0500, George G. Davis wrote:
> Adrian Bunk wrote:
> > Perhaps it's a silly question but I'd like to know why it is the way it
> > is:
> > 
> > The 2.2, 2.4 and 2.5 kernels include a driver for the Comtrol Rocketport
> > card (drivers/char/dtlk.c) which uses a local major (it does a
> >   "register_chrdev(0, "dtlk", &dtlk_fops);
> > ). Is there a reason why it doesn't have a fixed major assigned?
> 
> Huh?:
> 
> 	dtlk.c - DoubleTalk PC driver for Linux
> 
> That doesn't look like the Comtrol Rocketport (drivers/char/rocket.c)
> driver to me. : )

I was thinking about something else related to the Comtrol Rocketport 
when writing my mail, and I mixed the two things...  :-(

Please do a s/Comtrol Rocketport/DoubleTalk/g in my initial mail.

> Meanwhile 2.4.19 Documentation/devices.txt shows:
> 
>  46 char        Comtrol Rocketport serial card
>                   0 = /dev/ttyR0        First Rocketport port
>                   1 = /dev/ttyR1        Second Rocketport port
>                     ...

This is indeed true for the Comtrol Rocketport card but there's no
major for the DoubleTalk card (and this is the card I wanted to write
about).

> Regards,
> George

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

