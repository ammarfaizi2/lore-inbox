Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312720AbSCVPgr>; Fri, 22 Mar 2002 10:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312721AbSCVPgg>; Fri, 22 Mar 2002 10:36:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48141 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312720AbSCVPgU>; Fri, 22 Mar 2002 10:36:20 -0500
Date: Fri, 22 Mar 2002 10:34:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: David Schwartz <davids@webmaster.com>, joeja@mindspring.com,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: max number of threads on a system
In-Reply-To: <Pine.LNX.4.44.0203212202060.1580-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.3.96.1020322103236.22096C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Davide Libenzi wrote:

> On Thu, 21 Mar 2002, David Schwartz wrote:
> 
> >
> >
> > On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
> > >What limits the number of threads one can have on a Linux system?
> >
> > 	Common sense, one would hope.
> >
> > >I have a simple program that creates an array of threads and it locks up at
> > >the creation of somewhere between 250 and 275 threads.
> 
> $ ulimit -u

/proc/sys/kernel/threads-max is the system limit. And "locks up" is odd
unless the application is really poorly written to handle errors. Should
time out and whine ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

