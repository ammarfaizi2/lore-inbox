Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSDPQuY>; Tue, 16 Apr 2002 12:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313768AbSDPQuX>; Tue, 16 Apr 2002 12:50:23 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:34268 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313767AbSDPQuW>;
	Tue, 16 Apr 2002 12:50:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15548.22093.57788.557129@napali.hpl.hp.com>
Date: Tue, 16 Apr 2002 09:50:21 -0700
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <a9hjd0$16s$1@penguin.transmeta.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 16 Apr 2002 16:27:12 +0000 (UTC), torvalds@transmeta.com (Linus Torvalds) said:

  Linus> And I've had some Intel people grumble about it, because it
  Linus> apparently means that the timer tick takes anything from 2%
  Linus> to an extreme of 10% (!!) of the CPU time under certain
  Linus> loads.

I'm not sure I believe this.  I have had occasional cases where I
wondered whether the timer tick caused significant overhead, but it
always turned out to be something else.  In my measurements,
*user-level* profiling has the 2-10% overhead you're mentioning, but
that's with a signal delivered to user level on each tick.

	--david
