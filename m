Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWCLDoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWCLDoj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWCLDoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:44:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2784 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750938AbWCLDoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:44:39 -0500
Subject: Re: can I bring Linux down by running "renice -20
	cpu_intensive_process"?
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
References: <441180DD.3020206@wpkg.org>
	 <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	 <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 11 Mar 2006 22:44:36 -0500
Message-Id: <1142135077.25358.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 22:01 +0000, Måns Rullgård wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
> 
> >>Subject: can I bring Linux down by running "renice -20
> >>cpu_intensive_process"?
> >>
> > Depends on what the cpu_intensive_process does. If it tries to allocate 
> > lots of memory, maybe. If it's _just_ CPU (as in `perl -e '1 while 1'`), 
> > you get a chance that you can input some commands on a terminal to kill it.
> > SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.
> 
> Sysrq+n changes all realtime tasks to normal priority.
> 

A nice -20 SCHED_OTHER task is not realtime, only SCHED_FIFO and
SCHED_RR.

Lee

