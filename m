Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRKNWdp>; Wed, 14 Nov 2001 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRKNWdf>; Wed, 14 Nov 2001 17:33:35 -0500
Received: from laird.sea.internap.com ([206.253.215.165]:10587 "EHLO
	laird.sea.internap.com") by vger.kernel.org with ESMTP
	id <S278358AbRKNWdV>; Wed, 14 Nov 2001 17:33:21 -0500
Date: Wed, 14 Nov 2001 14:33:07 -0800 (PST)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.sea.internap.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "Peter T. Breuer" <ptb@it.uc3m.es>, <dalecki@evision.ag>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
In-Reply-To: <20011114164957.A7587@redhat.com>
Message-ID: <Pine.LNX.4.33.0111141421070.829-100000@laird.sea.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Nov 2001, Benjamin LaHaise wrote:
>
> On Wed, Nov 14, 2001 at 02:16:39PM -0700, Andreas Dilger wrote:
> > Well, the rumor is wrong.  There has always been a single-device 1TB/2TB
> > limit in the kernel (2^31 or 2^32 * 512 byte sector size), and until
> > recently it has not been a problem.  To remove the problem Jens Axboe
> > (I think, or Ben LaHaise, can't remember) has a patch to support 64-bit
> > block counts and has been tested with > 2TB devices.
>
> It was tested with a 10TB loopback raid, not a real device.  Strangly,
> nobody made any effort to test on real physical hardware (or offer any
> hardware for me to test on ;-).  The patch was against ~2.4.6 and will
> need to get dusted off again soon.
>

Interesting.  I have a couple 14x 100GB IDE boxes scheduled to show
up next week.  If I can get a patch for a reasonably recent kernel, I
could do a few tests on a ~1.2 GB FS, and maybe on one a bit bigger.

Once 160GB drives start shipping, it should be possible to make a 2TB
software RAID5 box in a 4U case for around $7k.

Interesting question: does Linux have problems with large NFS imports?


Scott

