Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262786AbSI2QA5>; Sun, 29 Sep 2002 12:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSI2QA5>; Sun, 29 Sep 2002 12:00:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262786AbSI2QAz>;
	Sun, 29 Sep 2002 12:00:55 -0400
Date: Sun, 29 Sep 2002 18:06:01 +0200
From: Jens Axboe <axboe@suse.de>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: james <jdickens@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929160601.GG1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290114.15994.jdickens@ameritech.net> <1033312735.1326.3.camel@aurora.localdomain> <20020929154516.GE1014@suse.de> <1033315176.1310.10.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033315176.1310.10.camel@aurora.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Trever L. Adams wrote:
> On Sun, 2002-09-29 at 11:45, Jens Axboe wrote:
> > How many accounts of the new block layer corrupting data have you been
> > aware of? Since 2.5.1-preX when bio was introduced, I know of one such
> > bug: floppy, due to the partial completion changes. Hardly critical.
> > 
> > -- 
> > Jens Axboe
> 
> Sorry Jens, I never meant to imply I had heard of any since that floppy
> bug.  I just understand there were some problems at the beginning. 
> Also, I haven't been able to follow LKM as well as I would have liked
> lately, but a few months ago, in one of the many IDE bash sessions that
> have happened in 2.5.x I read a few people blaiming some of the problems
> on interactions between the new block layer and the IDE layer.

No worries. I can understand how people would be weary of block layer
changes, as they have the potential to corrupt your data.

> Sorry about the worries.  I am just trying to be cautious.  I am
> guessing you are saying that the block layer is now solid?   If this is

Nah I'm saying that it's always been solid. Why would I suddenly
destabilize it now? :-)

> the case, it sure knocks a few of my worries out of the ball park and I
> will be that much closer to trying out 2.5.x myself.

As always, it's untested territory so a backup may be in order. But I
don't view testing 2.5 as any more dangerous as testing 2.4-ac.

-- 
Jens Axboe

