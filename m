Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132161AbRATT7m>; Sat, 20 Jan 2001 14:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132222AbRATT7c>; Sat, 20 Jan 2001 14:59:32 -0500
Received: from [63.95.87.168] ([63.95.87.168]:27404 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132161AbRATT7Z>;
	Sat, 20 Jan 2001 14:59:25 -0500
Date: Sat, 20 Jan 2001 14:59:24 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.x kernels?
Message-ID: <20010120145924.A22169@xi.linuxpower.cx>
In-Reply-To: <3A69EBF8.B35A3B80@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A69EBF8.B35A3B80@Home.net>; from Shawn.Starr@Home.net on Sat, Jan 20, 2001 at 02:50:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 02:50:16PM -0500, Shawn Starr wrote: 
> It just seems that since using 2.4 ive noticed my poor Pentium 200Mhz
> slow down whether being in X or otherwise. It just seems that the system
> is sluggish.
> 
> I am using the new ReiserFS filesystem and I do know its still in heavy
> development perhaps my latency is due to this (?)

Reiserfs uses much more complex data structures then ext2 (trees..). I don't
think that latency has ever been a design criteria and all of the benchmarks
they use are pretty much pure throughput tests.

So it wouldn't be really surprising if reiserfs had very bad latency. You
should apply the timepegs patch and profile your kernel latency to see where
it's coming from.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
