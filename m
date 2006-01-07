Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWAGK6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWAGK6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 05:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWAGK6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 05:58:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030406AbWAGK6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 05:58:08 -0500
Date: Sat, 7 Jan 2006 12:00:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian <sebastian_ml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107110004.GU3389@suse.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107105649.GT3389@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Jens Axboe wrote:
> On Sat, Jan 07 2006, Sebastian wrote:
> > Hi everybody,
> > 
> > On Fr, Jan 06, 2006 at 03:30:47 -0800, Mark Knecht wrote:
> > > On 1/6/06, Sebastian <sebastian_ml@gmx.net> wrote:
> > > > Hi all!
> > > > On Fri, Jan 06, 2006 at 12:06:15AM -0800, Joshua Kwan wrote:
> > > > > Hi Sebastian,
> > > > >
> > > > > On 01/03/2006 02:20 PM, Sebastian wrote:
> > > > > > The second series was ripped with deprecated ide-scsi emulation and yielded the
> > > > > > same results as EAC.
> > > > >
> > > > > What were you using? cdparanoia? cdda2wav? (Are there actually that many
> > > > > other options on Linux?)
> > > > I use cdparanoia.
> > > 
> > > Try  cdparanoia -Bvz
> > > 
> > > This will cause the rip to be extremely careful and make sure
> > > everything is exactly right. It works well for me and was recommended
> > > by someone I trust. I hop it works for you..
> > > 
> > > Cheers,
> > > Mark
> > > 
> > I used cdparanoia -BzX -O48 for every rip.
> > Just to be clear, I'm not writing to this list because I have problems
> > with an application. :) Rather I like to know where to fix this problem, in
> > kernelland or userspace, like, should I start getting into cdparanoia or
> > reading the o'Reilly book about kernel drivers?
> 
> I missed most of this thread, please don't dump people from the cc list!
> 
> Can you put one of the tracks somewhere where I can reach them? Just one
> of the EAC/ide-scsi ripped vs the ide-cd version. You should probably
> just privately mail me, we don't want to encourage music piracy :-)

One more question - when using ide-scsi, does it use the SG_IO ioctl to
rip cdda, or does it use CDROMREADAUDIO like I'm assuming it does with
ide-cd? Is there a way to force SG_IO usage with a given device in
cdparanoia? If so, please try ide-cd with SG_IO usage instead.

-- 
Jens Axboe

