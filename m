Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRC2DzG>; Wed, 28 Mar 2001 22:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132662AbRC2Dy4>; Wed, 28 Mar 2001 22:54:56 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:51619 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132660AbRC2Dyp>; Wed, 28 Mar 2001 22:54:45 -0500
Date: Wed, 28 Mar 2001 19:54:25 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Pavel Machek <pavel@suse.cz>
cc: Russell King <rmk@arm.linux.org.uk>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Are you using fbcon? If so, and if it goes away after starting X, then it
>is the "fbcon kills interrupt latency" problem.

Ug!!! This is getting bad. Give me some time. I plan on releasing a new
vesafb using MMX to help speed up the drawing routines. It will help alot
with the latency issues. I also know using ARM assembly we can greatly
reduce the latency issues.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

