Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261923AbSJJRsY>; Thu, 10 Oct 2002 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJJRsY>; Thu, 10 Oct 2002 13:48:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22031 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261923AbSJJRsX>; Thu, 10 Oct 2002 13:48:23 -0400
Date: Thu, 10 Oct 2002 13:46:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: lell02 <lell02@stud.uni-passau.de>
cc: Jens Axboe <axboe@suse.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
In-Reply-To: <200210091042.g99Agwjm009964@tom.rz.uni-passau.de>
Message-ID: <Pine.LNX.3.96.1021010134148.17862C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, lell02 wrote:

> >You might be talking about two different patches -- one for cd-rw
> >support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
> >been maintaining) and the other for cd-mrw. The cd-mrw patch is very
> >small, not a lot is required to support that in the cd driver.
> >Supporting cd-rw is a lot harder, basically you have to do in software
> >what cd-mrw does in hardware (defect management, read-modify-write
> >packet gathering, etc).
> >
> >cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
> >looked at that lately.
> >
> 
> thanx for clearing out these differences. 
> 
> but, isn't cd-mrw supposed to replace the old packet-writing technique?
> so, in the end, there wouldn't be any need for packet-writing, if every burner 
> ships with cd-mrw-support... i read in the "specs", that the technology would 
> be much better.

When will you be sending me my replacement writers which support cd-mrw?
Hum, I thought not. You ignore the fact that there are at least hundreds
of thousands of devices in use which don't have that feature, but which
will support packet with the existing patches. AFAIK the code exists for
2.4, so perhaps only a port is needed.

Hopefully someone using this can clarify, I tried the code a while ago,
and it worked but was pretty slow. I would still find it useful in many
cases, however, I'm getting smarter about using slow writers :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

