Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262962AbSJGKD4>; Mon, 7 Oct 2002 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbSJGKD4>; Mon, 7 Oct 2002 06:03:56 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:60266 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S262962AbSJGKDy>; Mon, 7 Oct 2002 06:03:54 -0400
Message-Id: <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 11:18:44 +0200
X-Mailer: KMail [version 1.3.2]
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <3DA140ED.6512D1A1@aitel.hist.no>
In-Reply-To: <3DA140ED.6512D1A1@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 10:08, Helge Hafting wrote:
> "Martin J. Bligh" wrote:
> > > Then there's the issue of application startup. There's not enough
> > > read ahead. This is especially sad, as the order of page faults is
> > > at least partially predictable.
> >
> > Is the problem really, fundamentally a lack of readahead in the
> > kernel? Or is it that your application is huge bloated pig?
>
> Often the latter.  People getting interested in linux
> seems to believe that openoffice is the msoffice replacement,
> and that _is_ a huge bloated pig.  It needs 50M to start
> the text editor - and lots of _cpu_.  It takes a long time
> to start on a 266MHz machine even when the disk io
> is avoided by the pagecahce.

OpenOffice _is_ an important application, whether we like it or not.

How does one measure and profile application startup other than with
a stopwatch ? I'd like to gather some objective data on this.

> A snappy desktop is trivial with 2.5, even with a slow machine.
> Just stay away from gnome and kde, use a ugly fast

A desktop machine needs to run a desktop enviroment. Only a window manager is 
not enough.

> window manager like icewm or twm (and possibly lots
> of others I haven't even heard about.)
> X itself is snappy enough, particularly with increased
> priority.
> Take some care when selecting apps (yes - there is choice!)
> and the desktop is just fine.  Openoffice is a nice
> package of programs, but there are replacements for most
> of them if speed is an issue.  If the machine is powerful
> enough to run ms software snappy then speed probably
> isn't such a big issue though.

KDE and friends _are_ not quite optimised for speed. That however doesn't 
mean that the kernel should not make an effort to allow them to run as fast 
as they can.

	Regards
		Oliver
