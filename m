Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSI3IFy>; Mon, 30 Sep 2002 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbSI3IFy>; Mon, 30 Sep 2002 04:05:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46496 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261972AbSI3IFw>;
	Mon, 30 Sep 2002 04:05:52 -0400
Date: Mon, 30 Sep 2002 10:10:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Pittman <daniel@rimspace.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020930081056.GF27420@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <87k7l95f5a.fsf@enki.rimspace.net> <20020926082925.GK12862@suse.de> <873crw5o90.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873crw5o90.fsf@enki.rimspace.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Daniel Pittman wrote:
> >> This is a situation where, for a dedicated machine, delaying reads
> >> almost forever is actually a valuable thing. At least, valuable until
> >> it stops the writes from being able to proceed.
> > 
> > Well 0 should achieve that quite fine
> 
> Would you consider allowing something akin to 'writes_starved = -4' to
> allow writes to bypass reads only 4 times -- a preference for writes,
> but not forever?

Sure yes, that would be an acceptable solution.

-- 
Jens Axboe

