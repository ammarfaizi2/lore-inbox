Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319616AbSIMMOb>; Fri, 13 Sep 2002 08:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319617AbSIMMOb>; Fri, 13 Sep 2002 08:14:31 -0400
Received: from 62-190-219-50.pdu.pipex.net ([62.190.219.50]:7943 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319616AbSIMMOa>; Fri, 13 Sep 2002 08:14:30 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209131227.g8DCR6vi000944@darkstar.example.net>
Subject: Re: XFS?
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Sep 2002 13:27:06 +0100 (BST)
In-Reply-To: <Pine.LNX.3.96.1020913074543.22464B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Sep 13, 2002 07:53:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > In my opinion the non-inclosure in the mainline kernel is the most 
> > > important reason not to use XFS (or any other FS). Which in turn 
> > > massively reduces the tester base. It is a shame, because for some type 
> > > of applications it performs great, or better than anything else.
> > 
> 
> > On the other hand, filesystem corruption bugs are one of the worst type
> > to suffer from.  We absolutely don't want to include filesystems without
> > at least a reasonable proven track record in the mainline kernel, and
> > therefore encourage the various distributions to use them, incase any
> > bugs do show up.  Look how long a buffer overflow existed in Zlib
> > unnoticed. 
> 
> Given that the IDE code in 2.5 wrote random bad data not only in the
> mounted filesystems but on other partitions and even drives, if we are
> dropping things which have an unreasonable track record, we should drop
> IDE for sure ;-)

Things have certainly changed, (for better or worse, I'm not sure), since the 1.3.X days when a development kernel was generally still pretty stable.

> This is a development kernel, the rules for what goes in should be far
> more open than the stable series. IMHO both JFS (AIX) and XFS (IRIX)
> should be in, because they will not be solid until users actually use
> them, and better that be in a development kernel.

Totally agreed.  I was talking about the stable kernel.

> > EXT2 is a very capable filesystem, and has *years* of proven
> > reliability.  That's why I'm not going to switch away from it for
> > critical work any time soon. 
> 
> One might note that both JFS and XFS have been around since xiafs was the
> Linux f/s of choice.

Not for Linux, though - I'm talking about years of Linux stability.

> It's all relative. If you want old and grotty, go back to minix f/s.

That's why I qualified my above comment with 'is a very capable filesystem' :-).

I know what you mean, but I was just pointing out that EXT-2 balances proven reliability in the stable kernel, features, and performance VERY well, infact what other OS family can make that claim?  BSD is the only one I can think of.  Oh, sure FAT has been around forever, but it's somewhat lacking in the features department.

John.
