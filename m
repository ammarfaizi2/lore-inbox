Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUJWGGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUJWGGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUJWGDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 02:03:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29189 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266250AbUJWFz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:55:28 -0400
Date: Sat, 23 Oct 2004 07:52:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: espenfjo@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041023055212.GA21206@alpha.home.local>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local> <20041023014004.GG22558@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023014004.GG22558@stusta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
 
> 2.6.9 -> 2.6.10-rc1:
> - 4 days
> - > 15 MB patches

I firmly agree, and that's one of the reasons I still don't use 2.6. This
could be avoided with a shorter release cycle with far less new features
for each version (a bit like openbsd does), because about every maintainer
would have a valid base to work on for the next release or the one after,
and would not try to push unstable code in the "stable" kernel. Today, lots
of people are certain that 2.8 (or 3.0) won't be out before 3 or 4 years. So
if they want their code released soon, they push it hard in the current
mainline :-(

> It's a bit optimistic to call this amount of change "stabilizing".

What really frightens me is that judging from the changelogs, it really
looks like cleanups, bug fixes and sometimes core changes... This gives
a terrible idea of previous release code !

> 2.6 is corrently more a development kernel than a stable kernel.

That's how I present it to friends and customers too ;-) To others, I simply
say that it's the new stable kernel, and I observe how it works for them :-)

> The last bug I observed personally was the problem with suspending when 
> using CONFIG_REGPARM=y together with Roland's waitid patch which was 
> added in 2.6.9-rc2. If I'd used 2.6.9 with the same .config as 2.6.8.1, 
> this was simple one more bug...

Each time I try a new release, I barely find it extremely slow and unstable,
and I don't know where to start from to report broken things... Unfortunately
I don't have enough time to spend on bug reports these days so I stick to a
stable 2.4.

> IMHO Andrew+Linus should open a short-living 2.7 tree soon and Andrew 
> (or someone else) should maintain a 2.6 tree with less changes (like 
> Marcelo did and does with 2.4).

Yes, but not until the core is stabilized. Otherwise, ever changing features
and exports will discourage driver maintainers from backporting fixes.

Willy
 
