Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHTWg4>; Mon, 20 Aug 2001 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269728AbRHTWgq>; Mon, 20 Aug 2001 18:36:46 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:5642 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S269726AbRHTWgm>;
	Mon, 20 Aug 2001 18:36:42 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15233.37122.901333.300620@abasin.nj.nec.com>
Date: Mon, 20 Aug 2001 18:36:50 -0400 (EDT)
To: linux-kernel@vger.kernel.org
Subject: aic7xxx with 2.4.9 on 7899P
In-Reply-To: <200108202145.f7KLjsY43284@aslan.scsiguy.com>
In-Reply-To: <20010820230909.A28422@oisec.net>
	<200108202145.f7KLjsY43284@aslan.scsiguy.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's always a blessing and a curse when people seem to be haveing
problems with the same drivers as you.  I started looking into this
when I user complained about disk access time.  I think this is
related to the running aic7xxx topics.

>From my tests, I got a Dell 4400 who's Adaptec 7899P, according to
bonnie++, was writing slower then some of my my IDE drives on a
different system.  I tried Red Hat's 2.4.3-12smp kernel and got a
little improvement.  I then built 2.4.9 and started running bonnie++
again and my syslog gets filled up with such errors:

Aug 20 14:23:33 ps1 kernel: __alloc_pages: 0-order all
Aug 20 14:23:36 ps1 last message repeated 376 times
Aug 20 14:23:36 ps1 kernel: ed.
Aug 20 14:23:36 ps1 kernel: __alloc_pages: 0-order all
Aug 20 14:23:44 ps1 last message repeated 376 times
Aug 20 14:23:44 ps1 kernel: ed.
Aug 20 14:23:44 ps1 kernel: __alloc_pages: 0-order all
Aug 20 14:23:44 ps1 last message repeated 363 times

With slow access time.  Please request more info if you think it might
help.

	Sven
