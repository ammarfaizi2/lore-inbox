Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSG2FgI>; Mon, 29 Jul 2002 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSG2FgI>; Mon, 29 Jul 2002 01:36:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17027 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318028AbSG2FgH>;
	Mon, 29 Jul 2002 01:36:07 -0400
Date: Mon, 29 Jul 2002 07:39:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: martin@dalecki.de, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729073943.A4445@suse.de>
References: <20020728212523.A3460@suse.de> <Pine.LNX.4.44.0207281628360.8208-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207281628360.8208-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28 2002, Linus Torvalds wrote:
> 
> 
> On Sun, 28 Jul 2002, Jens Axboe wrote:
> >
> > But the crap still got merged, sigh... Yet again an excellent point of
> > why stuff like this should go through the maintainer. Apparently Linus
> > blindly applies this stuff.
> 
> Ehh, since there is no proactive maintainer for SCSI, I don't have much
> choice, do I?
> 
> SCSI has been maintainerless for the last few years. Right now three
> people work on it to some degree (Doug Ledford, James Bottomley and you),
> but I don't get timely patches, and neither does apparently anybody else.
> 
> Case in point: I was debugging some USB storage issues with Matthew Dharm
> yesterday, and he sent me patches to the SCSI subsystem that he claims
> were supposedly considered valid on the scsi mailing list back in May.
> 
> Guess what? I've not seen the patches from any of the three people I
> consider closest to being maintainers.

SCSI is always the first to get neglected it seems, and yes I'm guilty
of that as well. Maybe that can change in the future.

> So your "should go through the maintainer" complaint is obviously a bunch
> of bull. Feel free to step up to the plate, but before you do, don't throw
> rocks in glass houses.

I was referring to the block layer, not the SCSI layer. The broken
changes were applied to the block layer after all, I had not even
noticed that the SCSI one was broken.

-- 
Jens Axboe

