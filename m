Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTIHNYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbTIHNYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43997 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261506AbTIHNX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:23:59 -0400
Date: Tue, 2 Sep 2003 16:25:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Haoqiang Zheng <hzheng@cs.columbia.edu>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Mike Galbraith <efault@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030902142552.GG1358@openzaurus.ucw.cz>
References: <3F4182FD.3040900@cyberone.com.au> <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net> <20030820021351.GE4306@holomorphy.com> <3F4A1386.9090505@cs.columbia.edu> <3F4A172F.8080303@cyberone.com.au> <3F4A272F.8000602@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A272F.8000602@cs.columbia.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >about X doesn't sit well with me. I think the best you could hope 
> >for there
> >_might_ be a config option _if_ you could show some significant
> >improvements not attainable by modifying either X or the kernel in a 
> >more
> >generic manner.
> >
> Yes, this is exactly what Keith Packard did in this paper:  
> http://keithp.com/~keithp/talks/usenix2000/smart.html .  The X 
> scheduler is certainly "smarter" by giving a higher priority to more 
> interactive X clients. But I think guessing the importance of a 
> client by the X server itself is flawed because the X server doesn't 
> have a whole picture of the system. For example, it doesn't know 
> anything about the "nice" value of a process.  I think the kernel is 
> in the best position to decide which process is more important. 
> That's why I proposed kernel based approach.

Tasks can easily report their interactivity needs/nice value.
X are already depend on clients not trying to screw each other,
so thats okay.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

