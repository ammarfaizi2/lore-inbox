Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSGKFmk>; Thu, 11 Jul 2002 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGKFmj>; Thu, 11 Jul 2002 01:42:39 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:10170 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317672AbSGKFmj>; Thu, 11 Jul 2002 01:42:39 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 10 Jul 2002 22:44:48 -0700
Message-Id: <200207110544.WAA20858@adam.yggdrasil.com>
To: acme@conectiva.com.br
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date: Thu, 11 Jul 2002 00:01:54 -0300
>From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>

>BTW, where are these patches for IPv4 modularisation? I'd love to take a look
>and try it... Adam? Is it available for 2.5.latest?

	I have to catch a plane to Beijing in the morning and I
haven't packed and the internet connectivity in the rooms there is
flakey (possibly due to their router, which is running a Linux 2.2
kernel, by the way).  So, please excuse my sloppy approach, as this
might otherwise take weeks.

	I have made a diff of linux/{net,drivers/net} against 2.5.25,
which should show my ipv4 modularization changes, although there are a
bunch of other changes that are irrelevant (unrelated changes to
various net device drivers) and some that might be relevant (e.g.,
disintegrating drivers/net/net_init.c, modularizing some media level
network protocols).

	The diff is FTPable from

	ftp://ftp.yggdrasil.com/private/adam/kernel/netdiff-2.5.25.gz

	In case I missed something, I have also placed a complete .tar.gz
kernel snapshot at

	ftp://ftp.yggdrasil.com/private/adam/kernel/linux-2.5.25.ygg.tar.gz

	ipv4 modularization would need to be looked over by the lkml
crowd and cleaned up before being sent to Linus.  I probably got lots
of details wrong.  As I mentioned in a previous email, I thought that
there was a modularized ipv4 already working its way to Linus from the
vger cvs tree (don't know if it still exists), which I presumed would
have had a lot more programmer power alreadya applied to it.  Perhaps
Dave Miller could comment on whether I misunderstood the situation
and, if there were other ipv4 modularization patches floating around,
whether he or anyone else knows their current status.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

