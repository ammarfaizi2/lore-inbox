Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSIALeR>; Sun, 1 Sep 2002 07:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSIALeR>; Sun, 1 Sep 2002 07:34:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40198 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316684AbSIALeP>; Sun, 1 Sep 2002 07:34:15 -0400
Date: Sun, 1 Sep 2002 07:32:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: conman@kolivas.net
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM changes added to performance patches for 2.4.19
In-Reply-To: <1030170794.3d6728aa24046@kolivas.net>
Message-ID: <Pine.LNX.3.96.1020901072631.337B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002 conman@kolivas.net wrote:

> 
> With the patch against 2.4.19:
> 
> Scheduler O(1), Preemptible, Low Latency
> 
> I have now added two extra alternative patches that include 
> either Rik's rmap (thanks Rik) or AA's vm changes (thanks to Nuno Monteiro for
> merging this)
> 
> For the record, with the (very) brief usage of these two patches I found the
> rmap patch a little faster. This is very subjective and completely untested.
> 
> Check them out here and tell me what you think(please read the FAQ):
> http://kernel.kolivas.net

The ck3-aa patch has worked perfectly for me until I try to shut down. At
that point I get to "turning off swap" and the system hangs with the disk
light on. Can't get a dump, and it doesn't happen every time, but enough
that I am very cautious in what I do at shutdown. Total hang ignoring
sysreq.

Athlon 1.4GHz, 1GB RAM, hda:30GB, hdc:40GB, 20x CD-R, multiple NICs, two
local networks, one PPP over high speed serial.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

