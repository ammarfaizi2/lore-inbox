Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSKDCkR>; Sun, 3 Nov 2002 21:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264636AbSKDCkQ>; Sun, 3 Nov 2002 21:40:16 -0500
Received: from siaar2aa.compuserve.com ([149.174.40.137]:12863 "EHLO
	siaar2aa.compuserve.com") by vger.kernel.org with ESMTP
	id <S264635AbSKDCkP>; Sun, 3 Nov 2002 21:40:15 -0500
Message-ID: <3DC5DF14.34483A96@compuserve.com>
Date: Sun, 03 Nov 2002 18:44:37 -0800
From: Jennie Haywood <jehaywood@compuserve.com>
X-Mailer: Mozilla 4.61 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-general] Re: What's left over.
References: <Pine.LNX.3.96.1021103082813.5197A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>
> On 1 Nov 2002, Alan Cox wrote:
>
> > On Fri, 2002-11-01 at 06:34, Bill Davidsen wrote:
> > >   From the standpoint of just the driver that's true. However, the remote
> > > machine and all the network bits between them are a string of single
> > > points of failure. Isn't it good that both disk and network can be
> > > supported.
> >
> The AIX support has a group just to beat on dumps customers send. What
> more evidence is needed that people can and do use the capability.
>

AIX has 4 people doing dumps in Austin (otherwise known as ZTRANS).  There are
others in other countries.
The folks from other countries were brought to Austin for training (usually for 3
months).
There is usually one person in L3 doing dumps in Austin for service, although
every subsystem has someone that specializes in reading dumps for that subsystem.

The first 4 people only do a scan of the dump to see if it's a known problem.  If
it's not
a known problem AND it's in AIX code it goes to whoever it is that owns that
subsystem.

Dumps are only the beginning with AIX.   Trace hooks along with dumps are VERY
useful.
The trace hooks are also what the performance people use.

The Linux kernel  is _extremely_  painful to debug compared to AIX.


--
Jennie Haywood
jehaywood@compuserve.com
Everyone is crazy. It's just a matter of degree.
jehaywood@yahoo.com
-
The oak tree in your backyard is just a nut that held its ground.


