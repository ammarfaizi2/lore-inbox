Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVDDVKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDDVKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDDVHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:07:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49926 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261398AbVDDVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:05:04 -0400
Date: Mon, 4 Apr 2005 23:05:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404210503.GG4087@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Sven Luther <sven.luther@wanadoo.fr>, Greg KH <greg@kroah.com>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404195830.GF4087@stusta.de> <20050404202308.GA3140@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404202308.GA3140@pegasos>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:23:08PM +0200, Sven Luther wrote:
> On Mon, Apr 04, 2005 at 09:58:30PM +0200, Adrian Bunk wrote:
> > On Mon, Apr 04, 2005 at 09:29:45PM +0200, Sven Luther wrote:
> > > On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> > > > On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > > > > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > > > > 
> > > > >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > > > > 
> > > > > Can you summarize the conclusion of the thread, or what you did get from it,
> > > > > please ? 
> > > > 
> > > > That people didn't like the inclusion of firmware, I posted how you can
> > > > fix it by moving it outside of the kernel, and asked for patches.
> > > 
> > > Yeah, that is a solution to it, and i also deplore that none has done the job
> > > to make it loadable from userland. For now, debian is satisfied by moving the
> > > whole modules involved to non-free, and this has already happened in part.
> > 
> > 
> > Does this imply your installer will use these non-free modules?
> 
> The installer already has provision for loading additional .udebs from floppy
> or net, not sure about other media, and we don't build yet non-free d-i images
> with those non-free modules builtin, but it could be arranged. This is
> post-sarge issues though, and we still have some time to solve them.
> 
> > If the driver for the controller your harddisk is behind is not used by 
> > the installer you could simply remove these modules instead of moving 
> > them to non-free.
> 
> yeah, the problem is a whole bunch of people have tg3 network cards it seem :)


I was more thinking about SCSI controllers, but tg3 is also interesting.

Additional non-free d-i images will for sure be required, or several 
hardware setups might make installation of Debian impossible without 
bootstrapping through a different OS or distribution.


> > > Nope, i am aiming to clarify this issue with regard to the debian kernel, so
> > > that we may be clear with ourselves, and actually ship something which is not
> > > of dubious legal standing, and that we could get sued over for GPL violation.
> > >...
> > 
> > 
> > If it was a GPL violation, it wasn't enough to contact only the small 
> > subset of copyright holders that worked on this specific file since 
> > this file might be compiled statically into the GPL'ed kernel.
> 
> That is not a problem, since even if the firmware is built into the same
> executable as the rest of the kernel code, it still constitutes only mere
> agregation, where the kernel is the distribution media, in the GPL sense.
> Please read the mail i linked too in the original mail for detailed
> argumentation of this.
> 
> The only problem to it constituting mere agregation is that the firmware blob
> is not clearly identified as such in the tg3.c file (for example), and that
> there is no licencing condition allowing their distribution apart the GPL,
> which these firmware blobs where evidently not meant to be put under.


This is one possible legal interpretation of "mere aggregation".

Whether judges in all jurisdictions of the world follow this 
interpretation or an interpretation of the GPL in one direction or 
another is the more interesting question.


> Friendly,
> 
> Sven Luther

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

