Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276447AbRI2HZm>; Sat, 29 Sep 2001 03:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRI2HZc>; Sat, 29 Sep 2001 03:25:32 -0400
Received: from cs82093.pp.htv.fi ([212.90.82.93]:45184 "EHLO cs82093.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S276447AbRI2HZN>;
	Sat, 29 Sep 2001 03:25:13 -0400
Message-ID: <3BB57763.1D8F3C25@welho.com>
Date: Sat, 29 Sep 2001 10:25:23 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pavel@md5.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
In-Reply-To: <20010928143205.B3669@md5.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Zaitsev wrote:
> Now I don't trust 2.4 line
> kernel to work *at all*, so cautiously keep all old kernels in the /boot,
> when upgrading.

Well, it's a good idea to always keep a few old kernels in /boot but I
certainly identify with your point. I like to run the bleeding edge
kernels at home but lately I've been having doubts. I've been looking
for a stable kernel since 2.4.0-test9. While 2.4.0-test9 is not exactly
bug free either, any later kernel either reboots at random (all later
test versions and early 2.4.x versions) or locks up hard on my SMP
machine. This does not appear to have anything to do with load, indeed
it often happens with the machine completely idle. It can take hours or
days before this occurs but sooner or later it does. Of course, nothing
ever gets written to the logs. With 2.4.8 I almost thought I had hit
paydirt, but no such luck. 2.4.9 crashed right off the bat. 2.4.10 seems
more unstable than most. Enough so that I finally patched in ext3 and
installed journals on my file systems just to give them a semblance of
stability (and to speed up the random reboots).

That said, I might just have a hardware problem. However, something in
the new kernels seems to touch it off. Any ideas and tools to track this
down, besides intuition and brute force, would be appreciated. [Right
now I'm running with swap disabled, on somebody's suggestion. Let's see
what happens.]

Regards,

	Mika Liljeberg
