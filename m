Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRCQAN6>; Fri, 16 Mar 2001 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbRCQANt>; Fri, 16 Mar 2001 19:13:49 -0500
Received: from ruthenium.btinternet.com ([194.73.73.138]:58247 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S131447AbRCQANm>;
	Fri, 16 Mar 2001 19:13:42 -0500
Date: Sat, 17 Mar 2001 00:12:54 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Michael Bacarella <mbac@nyct.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: New ld must have --oformat instead of -oformat ?
In-Reply-To: <20010316184702.A19192@sync.nyct.net>
Message-ID: <Pine.LNX.4.31.0103170008290.28486-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Michael Bacarella wrote:

> Riding the bleeding edge of debian leaves some interesting tastes.
> The line 'ld: cannot open binary: No such file or directory' is puzzling.
> The Makefile only has one dash. Changing -oformat to --oformat in
> arch/i386/boot/Makefile builds the kernel just fine.

Correct fix. (Already in 2.4.2-ac, and 2.4.3-pre)

> Did I stumble onto something that is a non-issue or am I just lucky enough
> to be the first one to trip over it?

It came up a few weeks ago.
It's only an issue in that 2.4.3 hasn't been released yet, so you'll
need to apply one of the above mentioned patchsets. (Or do it by
hand as you already did :)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

