Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbTCLPvh>; Wed, 12 Mar 2003 10:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbTCLPvh>; Wed, 12 Mar 2003 10:51:37 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:63498 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261745AbTCLPve>;
	Wed, 12 Mar 2003 10:51:34 -0500
Date: Wed, 12 Mar 2003 17:02:18 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312160218.GB4868@win.tue.nl>
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org> <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl> <20030312155105.GJ834@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312155105.GJ834@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 04:51:05PM +0100, Jens Axboe wrote:
> On Wed, Mar 12 2003, Andries Brouwer wrote:
> > On Wed, Mar 12, 2003 at 11:14:14AM +0100, Jens Axboe wrote:
> > 
> > > So I still think it's much better stick with the safe choice. Why do you
> > > think it's only one drive that has this bug? It basically boils down to
> > > whether That Other OS uses 256 sector commands or not. If it doesn't, I
> > > wouldn't trust the drives one bit.
> > 
> > I am not quite sure I understand your reasoning.
> > We have seen *zero* drives that do not understand 256 sector commands.
> > Maybe such drives exist, but so far there is zero evidence.
> 
> Have you read the thread? You are obviously mistaken.

Usually I am not, but I am happy to be corrected.
Please point out the facts.

What I have seen is Paul Gortmaker, who reported on an old disk
that showed errors with 256 sector transfers. In an early post
he thought that that just was because the drive did not understand
256-sector transfers, in a later post he reported that in fact
256-sector transfers worked but that it was possible to
provoke a problem by having heavy load for an hour with
256-sector transfers.

I have an old drive that works fine but after three crashes
at 4 in the morning I decided that the load of updating
the locate database was more than it could handle.
Heavy load is something that kills many a machine.

Andries

