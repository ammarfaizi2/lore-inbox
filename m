Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbTCGF5S>; Fri, 7 Mar 2003 00:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbTCGF5S>; Fri, 7 Mar 2003 00:57:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:62851 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261387AbTCGF5R>;
	Fri, 7 Mar 2003 00:57:17 -0500
Date: Thu, 6 Mar 2003 22:07:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Shawn <core@enodev.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030306220748.3f8f36d1.akpm@digeo.com>
In-Reply-To: <1047016271.3640.3.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303070649140.2662-100000@localhost.localdomain>
	<1047016271.3640.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 06:07:44.0862 (UTC) FILETIME=[DEB3BFE0:01C2E46F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> On Thu, 2003-03-06 at 23:52, Ingo Molnar wrote:
> > On Thu, 6 Mar 2003, Andrew Morton wrote:
> > 
> > > This improves the X interactivity tremendously.  I went back to 2.5.64
> > > base just to verify, and the difference was very noticeable.
> > > 
> > > The test involved doing the big kernel compile while moving large xterm,
> > > mozilla and sylpheed windows about.  With this patch the mouse cursor
> > > was sometimes a little jerky (0.1 seconds, perhaps) and mozilla redraws
> > > were maybe 0.5 seconds laggy.
> > > 
> > > So.  A big thumbs up on that one.  It appears to be approximately as
> > > successful as sched-2.5.64-a5.
> 
> I'm sorry, I'm an idiot. Where's sched-2.5.64-a5 available for download?
> Latest I found was  sched-2.5.63-B3 inside Andrew's patchset.

It all got merged.

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1068.1.17-to-1.1107.txt.gz

