Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313096AbSDDC5N>; Wed, 3 Apr 2002 21:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313098AbSDDC5D>; Wed, 3 Apr 2002 21:57:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1540 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313096AbSDDC4u>; Wed, 3 Apr 2002 21:56:50 -0500
Date: Wed, 3 Apr 2002 21:54:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jauder Ho <jauderho@carumba.com>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 vs. ext3 recovery after crash
In-Reply-To: <20020403102550.GT4735@turbolinux.com>
Message-ID: <Pine.LNX.3.96.1020403214341.185C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Andreas Dilger wrote:


> Well, 'mount' output is useless w.r.t. the root filesystem, because it is
> simply copied from /etc/fstab.  You need to check /proc/mounts to see if
> it is _ever_ being mounted as ext3 (lots of people have this problem,
> especially if they use initrds and ext3 as a module).

  The problem is that the initial mount is changing. I was at one point
making ext3 a module, and building initrd files with the ext3 modules and
fstab in the initrd. Didn't seem the way to go so I put ext3 in the
kernel, and that (usually) works. So I'm not making that particular error.

  Thanks for the ideas, I'm going to collect dmesg output and post so
someone can tell me I missed something obvious. Unless someone has a way
to so it from crashing, in which case I'll duck the problem for the
moment.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

