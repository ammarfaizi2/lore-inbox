Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTD2Duk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 23:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbTD2Duk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 23:50:40 -0400
Received: from holomorphy.com ([66.224.33.161]:2250 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261912AbTD2Duj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 23:50:39 -0400
Date: Mon, 28 Apr 2003 21:02:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030429040247.GF30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428151648.GF4525@Wotan.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 05:16:49PM +0200, Andi Kleen wrote:
> Nobody is doing that. pgcl is 2.5 only and seems to be still quite instable.
> Also it's extremly intrusive.

Unfortunately true. For all the merits of the technique itself, I'm not
hugh, and my results are proportionally less impressive.

That said, the intrusiveness aspect is easily dealt with as the patch
itself is very easy to chop into small pieces and merge incrementally.

I'd also say my progress toward stabilization is steady, though, of
course, things are by no means perfect.

At this point I'm literally more concerned about cleanliness than pure
stability, as the stability aspects lacking appear to be related
primarily to sweeping through code I can't regularly test anyway. After
that, of course, due diligence demands the driver sweeps etc. be
carried out before fully merging, but it's ultimately busywork. Not to
say it's any less essential, for a kernel would be useless without
drivers, but that's what it is.

If this is not your experience, I'd love to hear things like bugreports
and so on. Whatever feedback I can get I'd be very grateful for. I feel
that the highmem emphasis of my own particular effort has marginalized
the patch, and no one's really trying it out for things like large fs
blocksize and the linear space reductions and speedups. Of course, that
may be partially due to the fact I've not merged some of the things
needed to properly combat fragmentation into the patch, but those will
be taken care of in the next 72-96 hours (if they're not and I can't
write about them ajh will strangle me, but I've already taken care of
most of it anyway, and just haven't posted a release with the stuff).


-- wli
