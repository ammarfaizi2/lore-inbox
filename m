Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130489AbRCILwm>; Fri, 9 Mar 2001 06:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130492AbRCILwc>; Fri, 9 Mar 2001 06:52:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63250 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130489AbRCILwX>;
	Fri, 9 Mar 2001 06:52:23 -0500
Date: Fri, 9 Mar 2001 12:51:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Matthias Urlichs <smurf@noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010309125148.E8322@suse.de>
In-Reply-To: <1epyyz1.etswlv1kmicnqM%smurf@noris.de> <20010309075908.Z8922@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010309075908.Z8922@noris.de>; from smurf@noris.de on Fri, Mar 09, 2001 at 07:59:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09 2001, Matthias Urlichs wrote:
> Matthias Urlichs:
> > On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > > SCSI certainly lets us do both of these operations independently.  IDE
> > > has the sync/flush command afaik, but I'm not sure whether the IDE
> > > tagged command stuff has the equivalent of SCSI's ordered tag bits.
> > > Andre?
> > 
> > IDE has no concept of ordered tags...
> > 
> But most disks these days support IDE-SCSI, and SCSI does have ordered
> tags, so...

Any proof to back this up? To my knowledge, only some WDC ATA disks
can be ATAPI driven.

-- 
Jens Axboe

