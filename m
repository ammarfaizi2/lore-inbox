Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbRFNRjH>; Thu, 14 Jun 2001 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbRFNRi5>; Thu, 14 Jun 2001 13:38:57 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:8711 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S263432AbRFNRip>; Thu, 14 Jun 2001 13:38:45 -0400
Date: Thu, 14 Jun 2001 17:38:24 +0000 (GMT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <3B2882C0.EDA802E3@idb.hist.no>
Message-ID: <Pine.LNX.4.10.10106141736570.4809-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would it be possible to maintain a dirty-rate count
> > for the dirty buffers?
> > 
> > For example, we it is possible to figure an approximate
> > disk subsystem speed from most of the given information.
> 
> Disk speed is difficult.  I may enable and disable swap on any number of
...
> You may be able to get some useful approximations, but you
> will probably not be able to get good numbers in all cases.

a useful approximation would be simply an idle flag.
for instance, if the disk is idle, then cleaning a few 
inactive-dirty pages would make perfect sense, even in 
the absence of memory pressure.

