Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTE1HC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTE1HC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:02:57 -0400
Received: from ip68-111-188-90.sd.sd.cox.net ([68.111.188.90]:63616 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP id S264571AbTE1HCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:02:55 -0400
Date: Wed, 28 May 2003 00:16:08 -0700
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528071608.GA5801@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net> <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271954.11635.m.c.p@wolk-project.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:04:49PM +0200, Marc-Christian Petersen wrote:
> ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is dead/:
>      speak _NOW_ please, doesn't matter who you are!

Ok, add my box to the list.  Variety of post 2.4.18 kernels, -ac's, -rc's,
etc... all demonstrate it to one degree or another.

Lately it's gotten REALLY bad.

Currently I'm using 21-rc2-ac2 and it freezes for upwards of 15 sec
regularly when I'm exercising the HD (three simultaneous brag threads
downloading from various newsgroups).  The mouse moves, but other than
that, X is entirely unresponsive.  An xterm with continually scrolling
text, for example, will appear to stop scrolling until the kernel comes
back.

The HD light is on solid the whole time.

21-rc2 does it too.  I haven't tried anything later than that yet. Well, I
tried 20-ck7 and it ate my RAID0 due to a DMA-ism and I've not tested
anything else since. :(

-- 
 Marc Wilson |     Nothing in life is to be feared.  It is only to
 msw@cox.net |     be understood.
