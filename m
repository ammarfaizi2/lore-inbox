Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131267AbRCHFKz>; Thu, 8 Mar 2001 00:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131272AbRCHFKo>; Thu, 8 Mar 2001 00:10:44 -0500
Received: from turtle.carumba.com ([64.2.57.96]:13831 "EHLO turtle.carumba.com")
	by vger.kernel.org with ESMTP id <S131267AbRCHFKf>;
	Thu, 8 Mar 2001 00:10:35 -0500
Date: Wed, 7 Mar 2001 21:09:23 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
Message-ID: <Pine.LNX.4.33.0103071908030.31550-100000@turtle.carumba.com>
X-Mailer: UW Pine 4.29.99999 + a bunch of schtuff
X-BOFH-Msg: Use vi not Emacs.
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Mar 2001, Tom Sightler wrote:

> The questions that have been asked are as follows (assume 2.4.x kernels):
>
> 1.  What is the largest block device that linux currently supports?  i.e.
> Can I create a single 1TB volume on my storage device and expect linux to
> see it and be able to format it?

http://www.suse.de/~aj/linux_lfs.html should clear up

> 2.  Does linux have any problems with large (500GB+) NFS exports, how about
> large files over NFS?

See above

> 3.  What filesystem would be best for such large volumes?  We currently use
> reirserfs on our internal system, but they generally have filesystems in the
> 18-30GB ranges and we're talking about potentially 10-20x that.  Should we
> look at JFS/XFS or others?

I am not sure what you intend this application for. If it is mission
critical in any way shape or form, I would still recommend using something
like Veritas (which unfortunately is not ported to Linux yet). I have
heard good things about XFS although I have not had the chance to use it
yet.

> 4.  We're seriously considering using LVM for volume management.  Does it
> have size limits per volume or other limitations that we should be aware of?
>
> I'm sure these answers are out there, but I haven't been able to find
> definitive answers (it seems everyone has a different answer to each
> question).  Any assistance in pointing me to the correct information would
> be greatly appreciated.

Have fun and do post your findings back to l-k. I would be interested in
hearing what you end up with.

--Jauder

