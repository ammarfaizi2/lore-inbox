Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTFBUgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTFBUgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:36:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26120 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261888AbTFBUgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:36:43 -0400
Date: Mon, 2 Jun 2003 22:49:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [patch] epoll race fix for 2.5 ...
Message-ID: <20030602204955.GC10750@alpha.home.local>
References: <Pine.LNX.4.55.0305311458260.11255@bigblue.dev.mcafeelabs.com> <200306022242.22879.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306022242.22879.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Jun 02, 2003 at 10:42:22PM +0200, Marc-Christian Petersen wrote:
> On Monday 02 June 2003 22:27, Davide Libenzi wrote:
> 
> Hi Davide,
> 
> > The was a race triggered by heavy MT usage that could have caused
> > processes in D state. Bad Davide, bad ...
> > Also, the semaphore is now per-epoll-fd and not global. Plus some comment
> > adjustment.
> > Updated patches for 2.4.{20,21-rc6} are here :
> > http://www.xmailserver.org/linux-patches/nio-improve.html#patches
> is it just me or am I too silly to follow your release name changes? ;)

Do like me : download the latest of each name, and compare the sizes, then
the dates of the files inside the diffs, and you'll find that epoll-lt is the
newer :-)

Cheers,
Willy

