Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbTBVV4U>; Sat, 22 Feb 2003 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTBVV4U>; Sat, 22 Feb 2003 16:56:20 -0500
Received: from coffee.Psychology.mcmaster.ca ([130.113.218.59]:6064 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S267931AbTBVV4T>; Sat, 22 Feb 2003 16:56:19 -0500
Date: Sat, 22 Feb 2003 17:06:27 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <2080000.1045947731@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, so now you've slid from talking about PCs to 2-way to 4-way ...
> perhaps because your original arguement was fatally flawed.

oh, come on.  the issue is whether memory is fast and flat.
most "scalability" efforts are mainly trying to code around the fact
that any ccNUMA (and most 4-ways) is going to be slow/bumpy.
it is reasonable to worry that optimizations for imbalanced machines
will hurt "normal" ones.  is it worth hurting uni by 5% to give
a 50% speedup to IBM's 32-way?  I think not, simply because 
low-end machines are more important to Linux.

the best way to kill Linux is to turn it into an OS best suited 
for $6+-digit machines.

> For applications that don't work well on clusters, you have no real

ccNUMA worst-case latencies are not much different from decent 
cluster (message-passing) latencies.  getting an app to work on a cluster
is a matter of programming will.

regards, mark hahn.

