Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRCFNPY>; Tue, 6 Mar 2001 08:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbRCFNPO>; Tue, 6 Mar 2001 08:15:14 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:44293 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130636AbRCFNPI>; Tue, 6 Mar 2001 08:15:08 -0500
Date: Tue, 6 Mar 2001 05:15:07 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>,
        Jeremy Hansen <jeremy@xxedgexx.com>, <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <Pine.LNX.4.33.0103060449230.15874-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.33.0103060513160.15874-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, dean gaudet wrote:

> i assume you meant to time the xlog.c program?  (or did i miss another
> program on the thread?)
>
> i've an IBM-DJSA-210 (travelstar 10GB, 5411rpm) which appears to do
> *something* with the write cache flag -- it gets 0.10s elapsed real time
> in default config; and gets 2.91s if i do "hdparm -W 0".
>
> ditto for an IBM-DTLA-307015 (deskstar 15GB 7200rpm) -- varies from .15s
> with write-cache to 1.8s without.
>
> and an IBM-DTLA-307075 (deskstar 75GB 7200rpm) varies from .03s to 1.67s.
>
> of course 1.8s is nowhere near enough time for 200 writes to complete.

hi, not enough sleep, can't do math.  1.67s is exactly the ballpark you'd
expect for 200 writes to a correctly functioning 7200rpm disk.  and the
travelstar appears to be doing the right thing as well.

-dean

