Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSLOAxq>; Sat, 14 Dec 2002 19:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSLOAxq>; Sat, 14 Dec 2002 19:53:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50687 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266115AbSLOAxq>; Sat, 14 Dec 2002 19:53:46 -0500
Date: Sun, 15 Dec 2002 02:01:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nicolas Pitre <nico@cam.org>
Cc: "George G. Davis" <davis_g@attbi.com>, Jim Van Zandt <jrv@vanzandt.mv.com>,
       device@lanana.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why does the _DoubleTalk card_ not have a major assigned?
Message-ID: <20021215010137.GF27658@fs.tum.de>
References: <20021204213325.GG2544@fs.tum.de> <Pine.LNX.4.44.0212041646190.775-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212041646190.775-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 04:50:50PM -0500, Nicolas Pitre wrote:
> On Wed, 4 Dec 2002, Adrian Bunk wrote:
> 
> > This is indeed true for the Comtrol Rocketport card but there's no
> > major for the DoubleTalk card (and this is the card I wanted to write
> > about).
> 
> Maybe because it doesn't need a static major?  For funky hardware like the
> Doubletalk for which the number of Linux users worldwide can probably be
> counted on your fingers you can just grep /proc/devices for its allocated
> major and create the /dev node on the fly.

Thanks for your answer, I knew that this might have been a silly
question (and my confusing first mail didn't make it better...).

> Nicolas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

