Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRK3I1E>; Fri, 30 Nov 2001 03:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283559AbRK3I1B>; Fri, 30 Nov 2001 03:27:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14328 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283564AbRK3I0D>;
	Fri, 30 Nov 2001 03:26:03 -0500
Date: Fri, 30 Nov 2001 03:25:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [LART] pc_keyb.c changes
Message-ID: <Pine.GSO.4.21.0111300252030.13367-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Could the person who switched from BKL to spin_lock_irqsave() in
pc_keyb.c please share whatever the hell he had been smoking?  Free clue:
disabling interrupts for long intervals to improve scalability is right up
there with fighting for peace and fucking for virginity.

	Linus, could we please revert that crap and feed the authors to
Larry?  If they are religious about Scalability At Any Cost, Common Sense
Be Damned(tm) - let's give them a chance to become martyrs...

