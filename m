Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbTIZQ0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 12:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIZQ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 12:26:03 -0400
Received: from gaia.cela.pl ([213.134.162.11]:3078 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261622AbTIZQ0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 12:26:01 -0400
Date: Fri, 26 Sep 2003 18:25:54 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <20030926151642.GL729@actcom.co.il>
Message-ID: <Pine.LNX.4.44.0309261820160.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> syscalltrack can do it, per executable / user / syscall parameters /
> whatever, but it's per syscall. Writing a perl script or C program to
> iterate over the supplied syscall list and write the allow/deny rules
> is pretty simple. Also, syscalltrack is meant for debugging, not
> security, so if you want something that's 100% tight you'd better go
> with one of the Linux security modules based on the LSM framework. 

OK, thx, I'll take a look.

> Since it's a known binary, if you can handle the increased run time,
> strace is your best shot. syscalltrack and other kernel based
> solutions are best when you need something that is "system wide". 

It's known only in the sense that I have it.  The process is accept 
submission from outside network (source code).  Compile it (in a security 
playbox) statically to produce a single binary.  Then run this, time it, 
verify correctness of outcoming data.  Send the results back out to the 
outside world.  Iterate for each submission - sometimes one every couple 
seconds other times one per hour (depends on the current data set etc).

> Previous discussion seemed to conclude that features like these are
> "not interesting enough to the majority of users". Maybe it's time to
> revise those discussions (c.f. the inclusion of SELinux, for
> example). 

This is for an information technology algorithmic programming contest -
currently being used on a single comp, but likely to be required (in
time...) by all such online contests (like the one funded by IBM/ACM)  
which might mean a few hundred maybe thousand worldwide.

Cheers,
MaZe.


