Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSDWWYs>; Tue, 23 Apr 2002 18:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315359AbSDWWYr>; Tue, 23 Apr 2002 18:24:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36107 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315358AbSDWWYq>; Tue, 23 Apr 2002 18:24:46 -0400
Date: Tue, 23 Apr 2002 18:21:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Niemayer <niemayer@isg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mounting loop-device on a 2048 byte/sector medium fails
In-Reply-To: <3CC45E8D.68566324@isg.de>
Message-ID: <Pine.LNX.3.96.1020423181848.31248B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Peter Niemayer wrote:

> first I thought this was some loop-AES specific issue, but now I know
> it isn't: When I try to mount a filesystem on a loop device which
> is in turn using a 2048 byte/sector medium (a magneto-optical drive
> in my case), the mount fails though mkfs & fsck are happy.

I reported this some time ago as a problem with using offset mounting CDs
with a binary prefix before the ISO image. And since it seems that the
problem is not the offset but the sector size, the problems may be
related.

I'll look at this over the weekend if not before. It works with 2.0 and
2.2, I use it regularly, and it's the main thing keeping a few of my
machines on 2.2.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

