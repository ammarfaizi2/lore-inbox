Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266015AbUA1Rbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUA1Rbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:31:49 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:29963 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266015AbUA1Rbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:31:47 -0500
Message-ID: <4017F2C0.4020001@techsource.com>
Date: Wed, 28 Jan 2004 12:34:56 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Crazy idea:  Design open-source graphics chip
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat off-topic, so we shouldn't discuss it TOO much on-list, 
but I feel it's relevant to the state of affairs with Linux.


I haven't looked at what's available on opencores.org, but one of the 
biggest problems we seem to have is with getting high-quality graphics 
cards that are compatible with Linux in the sense that there are open 
specs and there's an open-source driver.  Oh, and we'd like to have 
something decent.

I have personally designed a graphics engine.  Actually, I would say 
that I did maybe 90% of the Verilog coding on it, and about 20% of the 
back-end (place, route, etc.) work.  I also did 100% of the X11 software 
(DDX) and 0% of the kernel driver code.  I wouldn't call it a 
masterpiece of engineering compared to the latest and greatest high-end 
3D and CAD graphics chips, but it's a powerful workhorse used in most of 
the air traffic control graphics cards and medical imaging cards that my 
employer sells (10 megapixel displays are easy for us).  Were you to 
read the manual on it, you'd think some of it was a bit unusual (such as 
the way you issue rendering commands), because it WAS my first ASIC 
ever.  I did meet all of our performance goals.  And I've come a long 
way since then.  (Unfortunately, this may sound like a plug, but I have 
competing desires to be humble about what I did but also not to 
publically say something that might understate the value of my 
employer's products.  I also feel a sense of pride in my accomplishment.)

That being said, I would LOVE to be involved in the design of an 
open-source graphics chip with the Linux market primarily in mind.  This 
is a major sore point for us, and I, for one, would love to be involved 
in solving it.  With an open architecture, everyone wins.  We win 
because we have something stable which we can put in main-line Linux, 
and chip fabs win, because anyone can sell it, and anyone can write 
drivers for any platform.

Imagine ATI and nVidia competing on how they can IMPROVE the design over 
one another but being obligated to release the source code.  I know... 
wishful thinking.  But I know a variety of ways that chips and boards 
could be made with respectable geometries (90nm) and high performance. 
No more being at the mercy of closed-development graphics chip designers 
who make Linux an after-though if they even think of us at all.


Please forgive my off-topic intrusion.

