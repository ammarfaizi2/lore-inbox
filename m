Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291429AbSBMHGC>; Wed, 13 Feb 2002 02:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291430AbSBMHFx>; Wed, 13 Feb 2002 02:05:53 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:36879 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291429AbSBMHFm>; Wed, 13 Feb 2002 02:05:42 -0500
Date: Wed, 13 Feb 2002 08:05:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213080539.A30500@suse.cz>
In-Reply-To: <20020212175718.P1907@suse.de> <Pine.LNX.4.10.10202122143380.32729-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202122143380.32729-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Tue, Feb 12, 2002 at 09:46:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 09:46:54PM -0800, Andre Hedrick wrote:
> 
> > On Tue, Feb 12 2002, Vojtech Pavlik wrote:
> > > On Tue, Feb 12, 2002 at 02:17:48PM +0100, Martin Dalecki wrote:
> > > 
> > > > So the conclusions is that not just the read_ahead array is bogous now.
> > > > The max_readahead array can be killed entierly from the kernel as well ;-).
> > > > 
> > > > The answer is: I'm now confident that you can just remove all the
> > > > max_readahead initialization from the ide code.
> > > 
> > > Since I've come to the same conclusion, here is the patch. It removes
> > > read_ahead, max_readahead, BLKRAGET, BLKRASET, BLKFRAGET and BLKFRASET
> > > completely.
> > > 
> > > Comments, Jens?
> > 
> > Could you battle it out, and I'll take a good look at the patch
> > tomorrow :-). I'm all for a bit of spring cleaning here, it's needed it
> > badly for quite a while.
> 
> Basically the LOT of all of you are WRONG and quit submitting patches to
> try and dork up the works.

:) Somehow, I expected exactly this reply from you. Thanks for not
disappointing me.

> Since we already have added back one ratehole from 2.4 that Linus
> strictly forbid, I am glad to see everyone here is an expert!
> I just love how the copy of a request has worked its way back into to
> the code-base. :-/  I recall Linus stating it was/is a horrid mess.

Sorry, can't comment on this, the patch I did with Martin certainly
doesn't *add* anything.

-- 
Vojtech Pavlik
SuSE Labs
