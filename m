Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136544AbRAHGPh>; Mon, 8 Jan 2001 01:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136556AbRAHGPR>; Mon, 8 Jan 2001 01:15:17 -0500
Received: from www.wen-online.de ([212.223.88.39]:5893 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136544AbRAHGPG>;
	Mon, 8 Jan 2001 01:15:06 -0500
Date: Mon, 8 Jan 2001 06:53:11 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: dep <dennispowell@earthlink.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, newbie@XFree86.Org
Subject: [OT] Re: performance boost from merging linux-2.4.0, xfree86-4.02
In-Reply-To: <01010717145901.00573@depoffice.localdomain>
Message-ID: <Pine.Linu.4.10.10101080645340.1615-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, dep wrote:

> for what it's worth:
> 
> this afternoon i conducted an experiment: i copied everything that 
> was newer from 
> [xfree-4.02-sourcedir]/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel 
> to my [linux-2.4.0-sourcedir]/drivers/char/drm and then built a 
> monolithic kernel containing agpgart, dri, and mga support. the 
> performance improvement is simply tremendous -- gears, for instance, 
> in the XscreenSavers module form, is running at at least 75 fps at 
> 1280x1024. really screaming.
> 
> obviously, anybody wanting to play with this needs to backup 
> everything first. but i think the experiment is well worth it for 
> anyone competent to build a kernel and who is interested in the 
> potential of the dri stuff in X.
> 
> this also suggests that probably the kernel dri stuff could stand an 
> update.

Greetings,

Can you (or anyone) point me to a clue-x-4 to get rid of this?

(II) R128(0): Acceleration enabled
(II) R128(0): Using hardware cursor (scanline 3606)
(II) R128(0): Largest offscreen area available: 1600 x 5787
(**) Option "dpms"
(**) R128(0): DPMS enabled
(II) R128(0): Direct rendering disabled

I've been wanting to see what X can do with dri for a while now,
but alas the bugger isn't being cooperative.

Any replies off list please.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
