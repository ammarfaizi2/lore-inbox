Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271704AbRHUOm0>; Tue, 21 Aug 2001 10:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271706AbRHUOmQ>; Tue, 21 Aug 2001 10:42:16 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:36362 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S271704AbRHUOmD>;
	Tue, 21 Aug 2001 10:42:03 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15234.29508.488705.826498@abasin.nj.nec.com>
Date: Tue, 21 Aug 2001 10:42:12 -0400 (EDT)
To: linux-kernel@vger.kernel.org
Subject: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
In-Reply-To: <15233.37122.901333.300620@abasin.nj.nec.com>
In-Reply-To: <20010820230909.A28422@oisec.net>
	<200108202145.f7KLjsY43284@aslan.scsiguy.com>
	<15233.37122.901333.300620@abasin.nj.nec.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgive the sin of replying to my own message but Daniel Phillips
replied to a different message with a patch to somebody getting a
similar error to mine.  Here is the result:

Aug 20 15:10:33 ps1 kernel: cation failed (gfp=0x30/1). 
Aug 20 15:10:33 ps1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x30/1). 
Aug 20 15:10:46 ps1 last message repeated 327 times 
Aug 20 15:10:47 ps1 kernel: cation failed (gfp=0x30/1). 
Aug 20 15:10:47 ps1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x30/1). 
Aug 20 15:10:56 ps1 last message repeated 294 times 


Sven Heinicke writes:
 > 
 > It's always a blessing and a curse when people seem to be haveing
 > problems with the same drivers as you.  I started looking into this
 > when I user complained about disk access time.  I think this is
 > related to the running aic7xxx topics.
 > 
 > From my tests, I got a Dell 4400 who's Adaptec 7899P, according to
 > bonnie++, was writing slower then some of my my IDE drives on a
 > different system.  I tried Red Hat's 2.4.3-12smp kernel and got a
 > little improvement.  I then built 2.4.9 and started running bonnie++
 > again and my syslog gets filled up with such errors:
 > 
 > Aug 20 14:23:33 ps1 kernel: __alloc_pages: 0-order all
 > Aug 20 14:23:36 ps1 last message repeated 376 times
 > Aug 20 14:23:36 ps1 kernel: ed.
 > Aug 20 14:23:36 ps1 kernel: __alloc_pages: 0-order all
 > Aug 20 14:23:44 ps1 last message repeated 376 times
 > Aug 20 14:23:44 ps1 kernel: ed.
 > Aug 20 14:23:44 ps1 kernel: __alloc_pages: 0-order all
 > Aug 20 14:23:44 ps1 last message repeated 363 times
 > 
 > With slow access time.  Please request more info if you think it might
 > help.
 > 
 > 	Sven
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
