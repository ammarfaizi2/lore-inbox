Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUIXOH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUIXOH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUIXOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:07:57 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:19149 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S268764AbUIXOHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:07:36 -0400
Date: Fri, 24 Sep 2004 16:07:25 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
       linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ArcNet and 2.6.8.1
In-Reply-To: <1095976927.7332.3.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10409241531580.13944-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Alan Cox wrote:


> [..]
> > But ArcNet doesn't degrade in performance when you try to fill it up as
> > ethernet does. Thus ArcNet is very good for real-time applications - and
> > is used for such in the industry. But that is not an area where people
> > usually use Linux.
> 
> Nod. Its fair to say you may well be "the arcnet user" by now however
> 8). Most real time people I've met use fieldbus nowdays for control
> systems or ethernet and handshaking plus local timers
> 
> 

I don't think you are quite fair :-) The company I work for recently
merged with a  competitor. The part I came from have been using ArcNet for
10 years as a backbone in a decentralized control system. We had been
talking about going to ethernet but things like backward combability
keeped us on ArcNet. The other part of the company, however, choose ArcNet
an I/O-network when they started to redisign their control system from
scratch just 3 years ago!
Today I asked one of them why they did that: Open standard, low
gaurantied latencies (down to 5ms depending on the number of nodes on the
network), relatively low drain on the CPU, high bandwidth (10Mbit/s),
possibility of mixing electrical and fiber lines, long wires (the 150m we
need is no problem) and the availability of relative cheap industry grade
controllers running in extended temperature range. They found that all the
other kind of "fieldbuses" around and ethernet didn't have all these
qualities.

I think some industrial, medico and military companies still design new 
products with ArcNet today, but these kind of companies are not as open
about their choice of technology as telecom is so you simply don't hear
about it! 

Esben

