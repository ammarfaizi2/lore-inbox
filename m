Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319614AbSIMLzr>; Fri, 13 Sep 2002 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319615AbSIMLzr>; Fri, 13 Sep 2002 07:55:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48906 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319614AbSIMLzo>; Fri, 13 Sep 2002 07:55:44 -0400
Date: Fri, 13 Sep 2002 07:53:31 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: jbradford@dial.pipex.com
cc: linux-kernel@vger.kernel.org
Subject: Re: XFS?
In-Reply-To: <200209121500.g8CF0D30003216@darkstar.example.net>
Message-ID: <Pine.LNX.3.96.1020913074543.22464B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002 jbradford@dial.pipex.com wrote:

> > In my opinion the non-inclosure in the mainline kernel is the most 
> > important reason not to use XFS (or any other FS). Which in turn 
> > massively reduces the tester base. It is a shame, because for some type 
> > of applications it performs great, or better than anything else.
> 

> On the other hand, filesystem corruption bugs are one of the worst type
> to suffer from.  We absolutely don't want to include filesystems without
> at least a reasonable proven track record in the mainline kernel, and
> therefore encourage the various distributions to use them, incase any
> bugs do show up.  Look how long a buffer overflow existed in Zlib
> unnoticed. 

Given that the IDE code in 2.5 wrote random bad data not only in the
mounted filesystems but on other partitions and even drives, if we are
dropping things which have an unreasonable track record, we should drop
IDE for sure ;-)

This is a development kernel, the rules for what goes in should be far
more open than the stable series. IMHO both JFS (AIX) and XFS (IRIX)
should be in, because they will not be solid until users actually use
them, and better that be in a development kernel.

> 
> EXT2 is a very capable filesystem, and has *years* of proven
> reliability.  That's why I'm not going to switch away from it for
> critical work any time soon. 

One might note that both JFS and XFS have been around since xiafs was the
Linux f/s of choice. It's all relative. If you want old and grotty, go
back to minix f/s.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

