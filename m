Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVDDUAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDDUAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDDUAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:00:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261360AbVDDT6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:58:32 -0400
Date: Mon, 4 Apr 2005 21:58:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404195830.GF4087@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Sven Luther <sven.luther@wanadoo.fr>, Greg KH <greg@kroah.com>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404192945.GB1829@pegasos>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:29:45PM +0200, Sven Luther wrote:
> On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> > On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > > 
> > >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > > 
> > > Can you summarize the conclusion of the thread, or what you did get from it,
> > > please ? 
> > 
> > That people didn't like the inclusion of firmware, I posted how you can
> > fix it by moving it outside of the kernel, and asked for patches.
> 
> Yeah, that is a solution to it, and i also deplore that none has done the job
> to make it loadable from userland. For now, debian is satisfied by moving the
> whole modules involved to non-free, and this has already happened in part.


Does this imply your installer will use these non-free modules?

If the driver for the controller your harddisk is behind is not used by 
the installer you could simply remove these modules instead of moving 
them to non-free.


> > None have come.
> > 
> > So I refuse to listen to talk about this, as obviously, no one cares
> > enough about this to actually fix the issue.
> 
> Well, i disagree with the above analysis. The problem is not so much that the
> firmware violate the GPL, as it constitutes mere agregation, but that the
> actual copyright statement of the files containing the firmware blobs place
> them de-facto under the GPL, which i doubt is what was intented originally,
> don't you think.
> 
> And *I* do care about this issue, and will follow up this issue with mails to
> the individual copyright holders of the file, to clarify the situation.
> 
> > People drag this up about once a year, so you are just following the
> > trend...
> 
> Nope, i am aiming to clarify this issue with regard to the debian kernel, so
> that we may be clear with ourselves, and actually ship something which is not
> of dubious legal standing, and that we could get sued over for GPL violation.
>...


If it was a GPL violation, it wasn't enough to contact only the small 
subset of copyright holders that worked on this specific file since 
this file might be compiled statically into the GPL'ed kernel.


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

