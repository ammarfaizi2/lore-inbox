Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272764AbTHENDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272780AbTHENDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:03:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39908 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272764AbTHENDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:03:32 -0400
Date: Tue, 5 Aug 2003 15:03:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>, heine@instmath.rwth-aachen.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Message-ID: <20030805130324.GC16091@fs.tum.de>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308051242.h75CgSj6028203@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 02:42:28PM +0200, Mikael Pettersson wrote:
> On 27 Jul 2003 21:56:11 +0100, Alan Cox wrote:
> > On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> > > That's no problem for me.
> > > 
> > > The only question is how to call the option that allows building only on
> > > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> > > would you suggest OBSOLETE_ON_SMP?
> > 
> > Interesting question - whatever I guess. We don't have an existing convention.
> > How many drivers have we got nowdays that failing on just SMP ?
> 
> ftape fails on SMP due to sti/save_flags/restore_flags removal.
>...
> I have the HW so I can test patches if someone feels like fixing this.

There seems to be an upgrade f the ftape code available at [1], but I 
haven't investigated on the status or plans to integrate it into 2.6.

@Claus-Justus:
Could you comment on this?

> /Mikael

cu
Adrian

[1] http://www.instmath.rwth-aachen.de/~heine/ftape/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

