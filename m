Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290127AbSAKVwc>; Fri, 11 Jan 2002 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290128AbSAKVwV>; Fri, 11 Jan 2002 16:52:21 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:29097 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S290127AbSAKVwG>; Fri, 11 Jan 2002 16:52:06 -0500
Date: Fri, 11 Jan 2002 16:53:04 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <3C3F5C43.7060300@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0201111649210.2711-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do vote for optimal cache use. Using squid (200MB process in my case)
> can be much faster if squid stays on the same CPU for a while, instead
> of hopping from one CPU to another (dual PII350 machine).

well, a typical desktop processor has 256-512K cache,
and at least 500 MB/s dram bandwidth, so cache flush time 
is only ~1ms, and can be as low as .2 ms.  the fact that
all current CPUs are out-of-order can hide some of this, as well...

