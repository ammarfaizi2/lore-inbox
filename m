Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBQM3J>; Mon, 17 Feb 2003 07:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbTBQM3J>; Mon, 17 Feb 2003 07:29:09 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:49341 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267039AbTBQM3I>; Mon, 17 Feb 2003 07:29:08 -0500
From: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Message-ID: <1045485310.3e50d6fe94f1e@rumms.uni-mannheim.de>
Date: Mon, 17 Feb 2003 13:35:10 +0100
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
References: <Pine.LNX.3.96.1030217070321.31221A-101000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030217070321.31221A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill Davidsen <davidsen@tmr.com>:

> On Sun, 16 Feb 2003, I wrote:
> 
> > > I've got NFS problems with 2.5.5x - 60-bk3, too, but here I can
> workaround 
> > > them by simply pinging the NFS-server every second... Funny, but it
> works!
> > > Perhaps this can help finding the real bug?!
> 
> [ let's try this again, not typing in a moving car ]
> 
> > I was looking for network issues when I started timing pings, and didn't
> > see any. I thought it was bad timing, like not raining when you have a
> > coat, but maybe I was curing it.
> 
> Since it's possible that pings will actually change the problem rather
> than measure it, I'll tcpdump for a while and see if that tells me
> anything. I suspected network problems, since tcp has priority over udp in
> some places.
> 
> I looked at the code last night, but I don't see anything explaining a
> ping making things better. Something getting flushed?

I'm sorry, I don't exactly know what you want me to do... I'm not involved in
the linux net code and I did not even try to understand it yet...

I just have a small environment with a FreeBSD 4.6 box using my Linux box as a
NFS file server. This worked fine with my 2.4 kernel but with the 2.5.x test
kernels I've got the problem the FreeBSD box says 'NFS server not responding'
until I do simple pings (ICMP echo request, ICMP echo respond) to the linux box
(the NFS server)...

Letting the ping run all the time NFS works so stable I even can do lots of
compilations over it without any problems.

So I don't have any answer WHY this helps, but it does... Perhaps it really is
just a timing issue, I just don't know... If you can tell me what to measure and
which values would be interesting I'll do these tests and send you the
results...


  Thomas Schlichter
