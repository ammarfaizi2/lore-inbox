Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbSLDXAI>; Wed, 4 Dec 2002 18:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbSLDXAI>; Wed, 4 Dec 2002 18:00:08 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39175 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267134AbSLDXAH>; Wed, 4 Dec 2002 18:00:07 -0500
Date: Wed, 4 Dec 2002 18:06:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.4.20-ac1 lp.o not built
In-Reply-To: <Pine.LNX.4.44.0212041622370.29684-300000@oddball.prodigy.com>
Message-ID: <Pine.LNX.3.96.1021204175826.13574A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1543749759-1039037439=:29684"
Content-ID: <Pine.LNX.3.96.1021204175826.13574B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1543749759-1039037439=:29684
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1021204175826.13574C@gatekeeper.tmr.com>

On Wed, 4 Dec 2002, Bill Davidsen wrote:

> Make blows up when trying to build, there appears to be no effort to build 
> lp.o, which it then can't find at link time.
> 
> Attached to prevent munging is the tail end of the make output and the 
> active lines of the .config. 2.4.20 builds, although it doesn't have quite 
> the same config options as -ac1, obviously, since some things are changed.
> 
Looks like it is the CONFIG_LP_CONSOLE making the problem, if that's not
compatible with using lp, and I don't see why that's a problem other than
possible mangled output, then the options should prevent each other in
some way, so you don't do that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--8323328-1543749759-1039037439=:29684--
