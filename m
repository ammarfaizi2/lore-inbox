Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbREBIwe>; Wed, 2 May 2001 04:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbREBIwY>; Wed, 2 May 2001 04:52:24 -0400
Received: from chiara.elte.hu ([157.181.150.200]:49673 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132416AbREBIwQ>;
	Wed, 2 May 2001 04:52:16 -0400
Date: Wed, 2 May 2001 10:50:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEC8562.887CFA72@chromium.com>
Message-ID: <Pine.LNX.4.33.0105021047040.3642-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Apr 2001, Fabio Riccardi wrote:

> TUX has definitively been my performance yardstick for the development
> of X15, but I had many sources of inspiration for the X15
> architecture. Maybe the most relevant are the Flash Web Server (Pai,
> Druschel, Zwaenepoel), several Linus observations on this list about
> (web) server architecture and kernnel services, and the reading of the
> Hennessy & Patterson architecture books. [...]

i think Zach's phhttpd is an important milestone as well, it's the first
userspace webserver that shows how to use event-based, sigio-based async
networking IO and sendfile() under Linux. (I believe it had some
performance problems related to sigio queue overflow, these issues might
be solved in the latest kernels.) The zerocopy enhancements should help
phhttpd as well.

	Ingo

