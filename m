Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289966AbSAKOa6>; Fri, 11 Jan 2002 09:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289967AbSAKOaj>; Fri, 11 Jan 2002 09:30:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38360 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289966AbSAKOa1>;
	Fri, 11 Jan 2002 09:30:27 -0500
Date: Fri, 11 Jan 2002 17:27:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Ed Tomlinson <tomlins@cam.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
In-Reply-To: <Pine.LNX.4.40.0201101841430.1493-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201111725420.3212-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Davide Libenzi wrote:

> > -H5 (-G1, latest I've tried worked)
> >
> > 1 GHz Athlon II, 640 MB
> > hang hard right after
> > Initializing RT netlink socket
>
> Look in init/main.c, if kernel_thread() is called before init_idle().

look at my patches, they have included this fix for quite some time.
(Linus found it or me, i dont remember.) So whatever problem Dieter has,
it's not this particular bug.

	Ingo

