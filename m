Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRAUSFF>; Sun, 21 Jan 2001 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131739AbRAUSEq>; Sun, 21 Jan 2001 13:04:46 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:30477 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131574AbRAUSEl>; Sun, 21 Jan 2001 13:04:41 -0500
Date: Sun, 21 Jan 2001 13:09:53 -0500
From: Chris Mason <mason@suse.com>
To: Gregory Maxwell <greg@linuxpower.cx>, Shawn Starr <Shawn.Starr@Home.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.x
 kernels?
Message-ID: <186870000.980100593@tiny>
In-Reply-To: <20010120145924.A22169@xi.linuxpower.cx>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, January 20, 2001 02:59:24 PM -0500 Gregory Maxwell
<greg@linuxpower.cx> wrote:

> On Sat, Jan 20, 2001 at 02:50:16PM -0500, Shawn Starr wrote: 
>> It just seems that since using 2.4 ive noticed my poor Pentium 200Mhz
>> slow down whether being in X or otherwise. It just seems that the system
>> is sluggish.
>> 
>> I am using the new ReiserFS filesystem and I do know its still in heavy
>> development perhaps my latency is due to this (?)
> 
> Reiserfs uses much more complex data structures then ext2 (trees..). I
> don't think that latency has ever been a design criteria and all of the
> benchmarks they use are pretty much pure throughput tests.
> 
> So it wouldn't be really surprising if reiserfs had very bad latency. You
> should apply the timepegs patch and profile your kernel latency to see
> where it's coming from.

I'm actually very interested in fixing any latency problems.  If you do
these tests, please send the results along.

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
