Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUAGRpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbUAGRpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:45:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:27399 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265613AbUAGRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:44:48 -0500
Date: Wed, 7 Jan 2004 17:44:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Paul Misner <paul@misner.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <Pine.LNX.4.56.0401070128130.8521@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.44.0401071741570.31020-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The good news is that I no longer get just a black screen at boot.

Yeah!!!

> The bad news is that it still doesn't work quite right.

I expected that. Newer Nvidia cards are not properly supported. 

> No matter what mode I try to boot in I always get the same, and it's as if
> the image is drawn only on every second scanline. One result of this is
> that I can only visually see approximately the top half of what I'm
> supposed to see - like, if I type in something in the shell, then I have
> to press enter several times untill enough lines have passed for the text
> to reach the top of the screen and thus is actually visible.  Another
> result of this is ofcourse that what I /can/ see doesn't look very good.

Sounds like a double scan issue. As for it always going to 640x480 that is 
a bug in the driver which is also in the 2.4.X tree. 

> Also, after starting X (using the "nv" driver, not a fb X server) - if I
> switch back to a text console then the screen is completely garbled - I
> can switch back to X just fine though.

Try using the UseFBDev flag for teh X server. That usually helps.

> rejects, but I tried building it anyway - it wouldn't compile. So I went
> back to a clean 2.6.0 to which the patch applied flawlessly.

Yeah I made the patch against 2.6.0. I will update it soon. 

