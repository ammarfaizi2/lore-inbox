Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSBMWmN>; Wed, 13 Feb 2002 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSBMWmE>; Wed, 13 Feb 2002 17:42:04 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1789
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S289026AbSBMWlx>; Wed, 13 Feb 2002 17:41:53 -0500
Date: Wed, 13 Feb 2002 14:41:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_sync livelock fix
Message-ID: <20020213224145.GC335@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@zip.com.au>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16b14Z-0001oR-00@starship.berlin> <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 05:24:38PM -0500, Bill Davidsen wrote:
> On Wed, 13 Feb 2002, Daniel Phillips wrote:
> > On this topic, it would make a lot of sense from the user's point of view to
> > have a way of syncing a single volume, how would we express that?
> 
> I have an idea, I'll put it in another message, since only two of us are
> likely to be reading at this point.
> 

Not true...

There's at least me. ;)  I have this thread flagged as "interesting".

Syncing a specific volume/fs is quite interesting also.  Maybe "sync
[--only-current-fs] [--fs $dev]"

Mike
