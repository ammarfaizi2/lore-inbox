Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262920AbSJGIC0>; Mon, 7 Oct 2002 04:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262921AbSJGICZ>; Mon, 7 Oct 2002 04:02:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58121 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262920AbSJGICY>; Mon, 7 Oct 2002 04:02:24 -0400
Message-ID: <3DA140ED.6512D1A1@aitel.hist.no>
Date: Mon, 07 Oct 2002 10:08:13 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - 
 (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > Then there's the issue of application startup. There's not enough
> > read ahead. This is especially sad, as the order of page faults is
> > at least partially predictable.
> 
> Is the problem really, fundamentally a lack of readahead in the
> kernel? Or is it that your application is huge bloated pig?

Often the latter.  People getting interested in linux
seems to believe that openoffice is the msoffice replacement,
and that _is_ a huge bloated pig.  It needs 50M to start
the text editor - and lots of _cpu_.  It takes a long time
to start on a 266MHz machine even when the disk io
is avoided by the pagecahce. 

A snappy desktop is trivial with 2.5, even with a slow machine.
Just stay away from gnome and kde, use a ugly fast
window manager like icewm or twm (and possibly lots
of others I haven't even heard about.)  
X itself is snappy enough, particularly with increased
priority.   
Take some care when selecting apps (yes - there is choice!)
and the desktop is just fine.  Openoffice is a nice
package of programs, but there are replacements for most
of them if speed is an issue.  If the machine is powerful
enough to run ms software snappy then speed probably
isn't such a big issue though.

> With admittedly no evidence whatsoever, I suspect the latter is
> really the root cause of this type of problem.
> 
> Ditto for the "takes me years to switch between desktops" ...
> maybe it's just that RAM is full of utter garbage due to mindless
> feature-bloat, so everything gets swapped out. If you're running
> something like Netscape / Mozilla ... ;-)

My guess is a bloated window manager.  Switching desktops
is fast for me, even with netscape running and swap in use.
Or are you talking 64M machines?
 
> I still think userspace is 90% of the problem here ...

Yes.

Helge Hafting
