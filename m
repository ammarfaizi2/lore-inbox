Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSGOTrc>; Mon, 15 Jul 2002 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSGOTrb>; Mon, 15 Jul 2002 15:47:31 -0400
Received: from ousrvr.oulu.fi ([130.231.240.1]:8614 "EHLO oulu.fi")
	by vger.kernel.org with ESMTP id <S317627AbSGOTra>;
	Mon, 15 Jul 2002 15:47:30 -0400
Date: Mon, 15 Jul 2002 22:50:23 +0300 (EEST)
From: Jukka Honkela <fatal@ees2.oulu.fi>
X-X-Sender: fatal@stekt41
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch[ Simple Topology API
Message-ID: <Pine.SOL.4.44.0207152240110.3084-100000@stekt41>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Friesen wrote:

>> Beyond 8-way, you need glue logic (hypertransport switches?) and
>> latency seems bound to become an issue.

>Nope.  Just extend the ladder.  Each cpu talks to three other entities,
>either cpu or I/O.  Can be extended arbitrarily until latencies are too
>high.

You seem to be missing one critical piece from the OLS talk. The HT
protocol (or something related) can't handle more than 8 CPU's in a single
configuration. You need to have some kind of bridge to connect
more than 8CPU's together, although systems with more than 8 CPU's have
not been discussed officially anywhere, afaik.

8 CPU's and less belongs to the SUMO category (Sufficiently Uniform Memory
Organization, apparently new AMD terminology) whereas 9 CPU's and more is
likely to be NUMA.

-- 
Jukka Honkela


