Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSK1NNA>; Thu, 28 Nov 2002 08:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSK1NNA>; Thu, 28 Nov 2002 08:13:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64268 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265475AbSK1NM7>; Thu, 28 Nov 2002 08:12:59 -0500
Date: Thu, 28 Nov 2002 08:18:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Benchmark] AIM9 results
In-Reply-To: <r1_20021126213149.29517.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.96.1021128081509.9795A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Paolo Ciarrocchi wrote:

> stream_pipe 10000 2807.4       280740.00 Stream Pipe Messages/second
> stream_pipe 10000 2602.3       260230.00 Stream Pipe Messages/second
> stream_pipe 10000 2487.1       248710.00 Stream Pipe Messages/second
> 
> dgram_pipe 10000 2756.9       275690.00 DataGram Pipe Messages/second
> dgram_pipe 10000 2460.5       246050.00 DataGram Pipe Messages/second
> dgram_pipe 10000 2377.9       237790.00 DataGram Pipe Messages/second
> 
> pipe_cpy 10000 4164.8       416480.00 Pipe Messages/second
> pipe_cpy 10000 3736.4       373640.00 Pipe Messages/second
> pipe_cpy 10000 3670.4       367040.00 Pipe Messages/second
> 
> ram_copy 10000 23801.6    595516032.00 Memory to Memory Copy/second
> ram_copy 10000 23583    590046660.00 Memory to Memory Copy/second
> ram_copy 10000 23578    589921560.00 Memory to Memory Copy/second

You didn't comment on these, but it clearly looks as if all methods of IPC
are getting slower, even shared memory. This has been discussed
previously, some of it has known areas of improvement, so I'm surprised
that the -mm kernel was slower.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

