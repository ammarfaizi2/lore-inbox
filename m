Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFSVAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFSVAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUFSVAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:00:34 -0400
Received: from pop.gmx.de ([213.165.64.20]:12778 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262451AbUFSVAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:00:20 -0400
X-Authenticated: #4512188
Message-ID: <40D4A962.7030508@gmx.de>
Date: Sat, 19 Jun 2004 23:00:18 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.7-ck1, cfq ionice?
References: <200406162122.51430.kernel@kolivas.org>
In-Reply-To: <200406162122.51430.kernel@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So,

I have been using 2.6.7-ck1 for a few days now and must say it is simply 
*great*. Everything is working as it should, but only better. :-) Even 
ut2004 seems to be much smoother using staircase, some people reported 
15% more fps (I haven't measured), but it runs as smooth as ut2003 did 
previously with Nick's scheduler (before the O(1) scheduler was updated 
to its current state in mm).

The only thing left, which is a major pain for me, is disk i/o. Once it 
starts performance goes down, I think even more with staircase than with 
Nick's but this could be due to faster feel of staircase in general...

Example: When I do a emerge rsync in gentoo a tree consisting of nearly 
9000 files gets synced and a cache is built which causes a lot of random 
access on hd. So when I try to use thunderbird mailer at the same time, 
it act like a snail now due to concurrent disk access.

As I understood the cfq ionice part would solve this issue. I never 
tried it, as I think I never had a kernel containing it (and never had 
such a desperate need for it :-). Reading your changelog, it is not 
included anymore in ck1. So should I beg Jens Axboe for a rediff or new 
patch or how to get this piece inside? I think it is the only thing left 
for the next to perfect desktop experience I ever had.

Cheers,

Prakash
