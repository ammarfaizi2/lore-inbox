Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291390AbSBMF63>; Wed, 13 Feb 2002 00:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291392AbSBMF6P>; Wed, 13 Feb 2002 00:58:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56585
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291390AbSBMF5x>; Wed, 13 Feb 2002 00:57:53 -0500
Date: Tue, 12 Feb 2002 21:46:54 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020212175718.P1907@suse.de>
Message-ID: <Pine.LNX.4.10.10202122143380.32729-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Jens Axboe wrote:

> On Tue, Feb 12 2002, Vojtech Pavlik wrote:
> > On Tue, Feb 12, 2002 at 02:17:48PM +0100, Martin Dalecki wrote:
> > 
> > > So the conclusions is that not just the read_ahead array is bogous now.
> > > The max_readahead array can be killed entierly from the kernel as well ;-).
> > > 
> > > The answer is: I'm now confident that you can just remove all the
> > > max_readahead initialization from the ide code.
> > 
> > Since I've come to the same conclusion, here is the patch. It removes
> > read_ahead, max_readahead, BLKRAGET, BLKRASET, BLKFRAGET and BLKFRASET
> > completely.
> > 
> > Comments, Jens?
> 
> Could you battle it out, and I'll take a good look at the patch
> tomorrow :-). I'm all for a bit of spring cleaning here, it's needed it
> badly for quite a while.

Basically the LOT of all of you are WRONG and quit submitting patches to
try and dork up the works.  Since we already have added back one ratehole
from 2.4 that Linus strictly forbid, I am glad to see everyone here is an
expert!

I just love how the copy of a request has worked its way back into to the
code-base. :-/  I recall Linus stating it was/is a horrid mess.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

