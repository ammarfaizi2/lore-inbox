Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290834AbSBFWCZ>; Wed, 6 Feb 2002 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSBFWCP>; Wed, 6 Feb 2002 17:02:15 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:55485 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290834AbSBFWCJ>; Wed, 6 Feb 2002 17:02:09 -0500
Date: Wed, 6 Feb 2002 17:06:34 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020206220634.GB24571@earthlink.net>
In-Reply-To: <20020206213420.GA24571@earthlink.net> <Pine.LNX.4.33L.0202061936240.17850-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202061936240.17850-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They run fastest when you run each of the dbench forks
> sequentially and have the others stuck in get_request_wait.

One interesting part of tiotest is the latency measurements.
Latency isn't printed by tiobench.pl though.  I think it's 
valueable information (and wish I had it).

> This, of course, is completely unacceptable for real-world
> server scenarios, where all users of the server need to be
> serviced fairly.

Agreed.  I'm glad kernel hackers focus on latency too. :)

There are _some_ applications where throughput is critical 
though.  I would prefer to measure both throughput and 
latency at the same time, but am not yet clear on how to
deal with the Heisenberg principle.

-- 
Randy Hron

