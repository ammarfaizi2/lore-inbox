Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRAEOwC>; Fri, 5 Jan 2001 09:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbRAEOvv>; Fri, 5 Jan 2001 09:51:51 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:43276 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S129834AbRAEOvj>;
	Fri, 5 Jan 2001 09:51:39 -0500
Date: Fri, 5 Jan 2001 08:49:28 -0600 (CST)
From: Brad Hartin <bhartin@satx.rr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: do_try_to_free_pages
In-Reply-To: <Pine.LNX.4.21.0101051232150.1295-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101050844170.11583-100000@osprey.hartinhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Rik van Riel wrote:

> [If you don't mind, please help test 2.4.0 a bit more. I'm
> pretty confident it's better than 2.2.18 when under load,
> but maybe the device drivers you use still need some tweaking]

I'll be trying to move to 2.4.0 again soon.  First 2.4.0-test* I tried was
one that ate filesystems (reinstall, not pretty).  Second 2.4.0-test* I
tried, I tried to get UDMA working (ALi 1533) ate my filesystems
again.  Third 2.4.0-test*, I finally decided to give up on UDMA on my
hardware when I trashed my filesystems once again.  Tried changing the
80-conductor cable a couple times, and tried different hdparm options, but
no luck.  Sucks having two 7200RPM/2MB buffer/UDMA33 drives and only
getting 7.7Mbyte/sec off of them.  At least my system at work
(Athlon/Irongate) gets 24MB/sec without tweaking on one of those Maxtor
60MB/5400RPM drives.

Oh well, I'm just rambling now...I'll probably fire up 2.4.0 this weekend
on my main machine, so unless this error is capable of corruption, I'll
likely wait until then and just skip the 2.2.19 series.

Thanks,
-----------------------------------------
Brad Hartin - bhartin@strafco.com
Communications Administrator
Straus-Frank Enterprises Limited
Carquest retail/wholesale distributor for
areas in TX, OK, LA, AR, NM, and KS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
