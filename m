Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJMUQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 16:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJMUQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 16:16:00 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:18118 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261905AbTJMUP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 16:15:59 -0400
Date: Mon, 13 Oct 2003 13:15:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031013201558.GK3634@ip68-0-152-218.tc.ph.cox.net>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <20031007205244.GA2978@kroah.com> <yw1xvfr0wxfa.fsf@users.sourceforge.net> <20031007213758.GB3095@kroah.com> <bm4mat$6ld$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bm4mat$6ld$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 10:09:33PM +0000, bill davidsen wrote:
> In article <20031007213758.GB3095@kroah.com>,
> Greg KH  <linux-kernel@vger.kernel.org> wrote:
> 
> | mount -t ramfs none /dev
> | 
> | That is what udev will run off of :)
> | 
> | Again, can you point me to any documentation that states that udev will
> | do this on a persistant filesystem?
> 
> I'm going back to look again, but I don't recall that it won't, either.
> If it wants a ramfs on /dev, why doesn't it just create one? That's a
> question, not an argument! I had assumed it would run on a persistent
> f/s if present.

Whatever f/s udev runs on is independant of udev, it just runs.  Ideally
distros / packagers should set things up so that it runs on ramfs.

-- 
Tom Rini
http://gate.crashing.org/~trini/
