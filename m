Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSBVJDP>; Fri, 22 Feb 2002 04:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSBVJCz>; Fri, 22 Feb 2002 04:02:55 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:44685 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292838AbSBVJCn>; Fri, 22 Feb 2002 04:02:43 -0500
Date: Fri, 22 Feb 2002 10:51:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: David Burrows <snadge@ugh.net.au>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <20020222124629.F15623-100000@starbug.ugh.net.au>
Message-ID: <Pine.LNX.4.44.0202221047440.30230-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, David Burrows wrote:

> I would assume that FreeBSD and Windows would still use the timer for some
> reason or another.  Therefore whatever sudden quirk that appeared in my
> hardware has revealed a bug in Linux..

Actually, FreeBSD frobs the timer (i8254) much more during its calibration 
than linux, so my guess is that its not a broken timer or somesuch, and 
they both use the TSC (if available) so perhaps its not that either.

Regards,
	Zwane Mwaikambo

