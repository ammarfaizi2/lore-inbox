Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278498AbRJPCPI>; Mon, 15 Oct 2001 22:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278500AbRJPCOu>; Mon, 15 Oct 2001 22:14:50 -0400
Received: from [209.195.52.30] ([209.195.52.30]:27938 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S278498AbRJPCO3>;
	Mon, 15 Oct 2001 22:14:29 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Patrick McFarland <unknown@panax.com>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 15 Oct 2001 17:53:32 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <20011015211216.A1314@localhost>
Message-ID: <Pine.LNX.4.40.0110151742440.1380-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from an interested bystander here's how I see it

much of the time the -ac VM is better, but sometimes it is MUCH worse.
It's performance can vary substantually even while running the same test.

the linux VM may not be as fast in some cases, but it is far more
predictable and repeatable, and doesn't have the same horrible 'worst
case' performance that has been the bane of the 2.4 kernels.

say for the sake of argument that the linus VM is only 80% as good as the
-ac VM. but the -ac VM has pathalogical conditions that hit is 5% of the
time (both numbers out of thin air, I'm sure that aa would argue that it's
better then the 80% and Rik would argue that it's less then 5% :-)

we're late in the 2.4 series, stability and predictability is better then
raw performance. the 5% pathalogical problem is bad enough to make that VM
unsuatable for many machines (and worse the conditions that trigger it
aren't well understood making it untrustworthy for a much larger group of
machines) while the slight performance hit on the 80% as good is much
easier to deal with (buy a faster disk or more ram)

I have been impressed by the repeatability shown by the linus VM system
and have just been waiting for the last of the gotchas to be hammered out
before switching my production machines from 2.4.5 to a newer kernel.

David Lang



 On Mon, 15
Oct 2001, Patrick McFarland wrote:

> Date: Mon, 15 Oct 2001 21:12:18 -0400
> From: Patrick McFarland <unknown@panax.com>
> To: linux-kernel@vger.kernel.org
> Subject: VM
>
> Linus, this question is really to you...
>
> Why is the simple vm system still in place on the linus tree? I would think the smart vm system in the ac tree would be better suited to .. oh.. say .. everything. (The potential for less swapping is _always better_)
>
> --
> Patrick "Diablo-D3" McFarland || unknown@panax.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
