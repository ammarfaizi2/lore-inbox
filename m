Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282927AbRK0ULi>; Tue, 27 Nov 2001 15:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282928AbRK0UL3>; Tue, 27 Nov 2001 15:11:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9480 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282927AbRK0ULQ>; Tue, 27 Nov 2001 15:11:16 -0500
Date: Tue, 27 Nov 2001 15:04:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <hgd70us5kslnp9os92ekfu7l4sqpcpn5op@4ax.com>
Message-ID: <Pine.LNX.3.96.1011127145403.31174D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Steve Brueggeman wrote:

> 2) At device initialization, and after device resets, force
> write-cache to be disabled. (not very nice to those that would rather
> have write cache enabled... poor souls)
> 
> 3) Set the Force Unit Access bit for all write commands. (again, not
> very nice to those poor souls that would rather have write cache
> enabled)

I don't have a problem with setting things to "most likely to succeed"
values, and (2) fits that. Those who really want w/c can enable in
rc.local. However, practice (3) is something I would associate with other
operating systems which believe that the computer knows best. You may
personally believe that you will trade any amount of performance for a
slight increase in reliability, but other may want to take the risk of
losing data and have the computer fast enough to do their work. I don't
think it's remotely Linux policy to do things like that, and I certainly
hope it doesn't happen.

Both decent disk drives and UPS systems are available, and having been in
the position of having systems which can't quite keep up with the load, I
want the option of doing what seems best. We have gotten along for years
without doing something to force bypass of w/c, it seems that hdparm is up
to continuing to allow people to make their own choices.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

