Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136044AbREGIOW>; Mon, 7 May 2001 04:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbREGIOL>; Mon, 7 May 2001 04:14:11 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:32522 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S136044AbREGIN5>;
	Mon, 7 May 2001 04:13:57 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 6 May 2001 05:49:08 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: jakob@unthought.net
Cc: linux-kernel@vger.kernel.org, dlitz@dlitz.net
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-Id: <20010506054908.08a90927.bruce@ask.ne.jp>
In-Reply-To: <20010507034208.A16593@unthought.net>
In-Reply-To: <20010505063726.A32232@va.samba.org>
	<20010506011553.A11297@zed.dlitz.net>
	<3AF584A2.4050208@kalifornia.com>
	<20010507034208.A16593@unthought.net>
X-Mailer: Sylpheed version 0.4.65 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >How far away is the capability to "teleport" processes from one machine to
> > >another over the network?  Think of the uptime!
> > >
> > 
> > It is here.  Look at Mosix.
> 
> No.  Not for uptime.
> 
> The "responsibility" for process completion does not get delegated. A process
> will always be bound to it's home-node (in mosix terms), no matter how far
> it's "teleported".   If the home-node fails, the process won't know what hit
> it.
> 
> There are good reasons why mosix let's processes depend on their home nodes.
> 
> This is not meant as backstabbing mosix, it's a great environment for a lot
> of things.
> 
> But it's not the universal silver bullet.

Take a look at

http://citeseer.nj.nec.com/299905.html

for something along the lines of what you want, I think (transparent process
migration between nodes). As a bonus, it's also architecture-independent.


Bruce

