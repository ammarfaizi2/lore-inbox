Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269016AbTBWXtE>; Sun, 23 Feb 2003 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbTBWXtE>; Sun, 23 Feb 2003 18:49:04 -0500
Received: from palrel11.hp.com ([156.153.255.246]:63413 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S269016AbTBWXtC>;
	Sun, 23 Feb 2003 18:49:02 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.24656.733807.819204@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 15:59:12 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <32500000.1046041615@[10.10.2.4]>
References: <15961.8482.577861.679601@napali.hpl.hp.com>
	<Pine.LNX.4.44.0302231326370.1534-100000@home.transmeta.com>
	<15961.19948.882374.766245@napali.hpl.hp.com>
	<32500000.1046041615@[10.10.2.4]>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 15:06:56 -0800, "Martin J. Bligh" <mbligh@aracnet.com> said:

  Linus> Last I saw P4 was kicking ia-64 butt on specint and friends.
  >>  I don't think so.  According to Intel [1], the highest
  >> clockfrequency for a 0.18um part is 2GHz (both for Xeon and P4,
  >> for Xeon MP it's 1.5GHz).  The highest reported SPECint for a
  >> 2GHz Xeon seems to be 701 [2].  In comparison, a 1GHz McKinley
  >> gets a SPECint of 810 [3].

  Martin> Got anything more real-world than SPECint type
  Martin> microbenchmarks?

SPECint a microbenchmark?  You seem to be redefining the meaning of
the word (last time I checked, lmbench was a microbenchmark).

Ironically, Itanium 2 seems to do even better in the "real world" than
suggested by benchmarks, partly because of the large caches, memory
bandwidth and, I'm guessing, partly because of it's straight-forward
micro-architecture (e.g., a synchronization operation takes on the
order of 10 cycles, as compared to order of dozens and hundres of
cycles on the Pentium 4).

BTW: I hope I don't sound too negative on the Pentium 4/Xeon.  It's
certainly an excellent performer for many things.  I just want to
point out that Itanium 2 also is a good performer, probably more so
than many on this list seem to be willing to give it credit for.

	--david
