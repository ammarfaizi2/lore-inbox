Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSBLQ6f>; Tue, 12 Feb 2002 11:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290553AbSBLQ62>; Tue, 12 Feb 2002 11:58:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28932 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289813AbSBLQ51>;
	Tue, 12 Feb 2002 11:57:27 -0500
Date: Tue, 12 Feb 2002 17:57:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212175718.P1907@suse.de>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212144300.A18431@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Vojtech Pavlik wrote:
> On Tue, Feb 12, 2002 at 02:17:48PM +0100, Martin Dalecki wrote:
> 
> > So the conclusions is that not just the read_ahead array is bogous now.
> > The max_readahead array can be killed entierly from the kernel as well ;-).
> > 
> > The answer is: I'm now confident that you can just remove all the
> > max_readahead initialization from the ide code.
> 
> Since I've come to the same conclusion, here is the patch. It removes
> read_ahead, max_readahead, BLKRAGET, BLKRASET, BLKFRAGET and BLKFRASET
> completely.
> 
> Comments, Jens?

Could you battle it out, and I'll take a good look at the patch
tomorrow :-). I'm all for a bit of spring cleaning here, it's needed it
badly for quite a while.

-- 
Jens Axboe

