Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVIFGDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVIFGDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIFGDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:03:49 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:52418 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932198AbVIFGDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:03:47 -0400
Date: Tue, 6 Sep 2005 08:03:46 +0200
From: Sander <sander@humilis.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Bob Richmond <bob@lorez.org>, linux-kernel@vger.kernel.org
Subject: Re: Immediate general protection errors on Tyan board
Message-ID: <20050906060346.GA9071@favonius>
Reply-To: sander@humilis.net
References: <431BE71F.2040901@lorez.org> <431BE9CE.8080302@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431BE9CE.8080302@comcast.net>
X-Uptime: 07:17:43 up 30 days, 16:42, 30 users,  load average: 0.00, 0.03, 0.01
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote (ao):
> Bob Richmond wrote:
> >Immediately upon boot on this system, most userland programs will 
> >segfault, including mount. This causes the system to come up in a 
> >bizarre state with the root filesystem mounted read-only, and nothing 
> >runs without segfault. There have been numerous similar posts about 
> >this problem, but they also seem to point to an associated kernel 
> >message, "Bad page state" that I don't observe. dmesg (which runs 
> >without segfault) returns many similar messages to:
> >
> >start_udev[576] general protection rip:2aaaaae0fc70 rsp:7fffffb23d90 
> >error:0
> 
> echo 0 > /proc/sys/kernel/randomize_va_space - Seems to fix it for most 
> people.
> 
> See http://bugzilla.kernel.org/show_bug.cgi?id=4851 for more details.

I only had some programs segfault, but this got resolved by doing an
update of the OS (Debian). It also started after an update of Debian.

Both programs installed with Debian packages as self-compiled programs
crashed with the ".. general protection rip: .." and ".. segfault at
..".

This happened on a dual Opteron Tyan system running 2.6.12-rc5.

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
