Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312588AbSCVRae>; Fri, 22 Mar 2002 12:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312764AbSCVRaY>; Fri, 22 Mar 2002 12:30:24 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26499 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312588AbSCVRaI>; Fri, 22 Mar 2002 12:30:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Mar 2002 09:35:06 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Bill Davidsen <davidsen@tmr.com>
cc: David Schwartz <davids@webmaster.com>, <joeja@mindspring.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: max number of threads on a system
In-Reply-To: <Pine.LNX.3.96.1020322103236.22096C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0203220934110.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Bill Davidsen wrote:

> On Thu, 21 Mar 2002, Davide Libenzi wrote:
>
> > On Thu, 21 Mar 2002, David Schwartz wrote:
> >
> > >
> > >
> > > On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
> > > >What limits the number of threads one can have on a Linux system?
> > >
> > > 	Common sense, one would hope.
> > >
> > > >I have a simple program that creates an array of threads and it locks up at
> > > >the creation of somewhere between 250 and 275 threads.
> >
> > $ ulimit -u
>
> /proc/sys/kernel/threads-max is the system limit. And "locks up" is odd
> unless the application is really poorly written to handle errors. Should
> time out and whine ;-)

Around 250 was the old limit for max user processes ( non root ), if i
remember well.



- Davide


