Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCPXZc>; Fri, 16 Mar 2001 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRCPXZX>; Fri, 16 Mar 2001 18:25:23 -0500
Received: from quechua.inka.de ([212.227.14.2]:8778 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130777AbRCPXZO>;
	Fri, 16 Mar 2001 18:25:14 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 network performances
In-Reply-To: <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14e3aC-0002l8-00@sites.inka.de>
Date: Sat, 17 Mar 2001 00:24:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi> you wrote:
> Yesterday I discovered that the load I can throw out to network seems to
> depend on other activities running on machine. I was able to get
> throughput of 33M/s with ATM when machine was idle, while I compiled
> kernel at same time, the throughput was 135M/s.

- which protocol/application you have used for this
- how do you have measured throughput (try wristwatch!)

I could think that applications can profit from increased context switches
count, especially if there is a handshake network protocol going on. But it
could also be some hardware problems.

Greetings
Bernd
