Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAJVgl>; Wed, 10 Jan 2001 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136576AbRAJVgb>; Wed, 10 Jan 2001 16:36:31 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:38524 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S129903AbRAJVgU>; Wed, 10 Jan 2001 16:36:20 -0500
Message-Id: <200101102136.f0ALaEr01228@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org
Subject: Re: unexplained high load
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 16:36:14 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, a D state.

D means disk wait, which the only thing that can postpone a -9. Basic, the 
process is stuck in a loop inside a routine that needs to be atomic.

You'll have to reboot to clear it. I believe this is a kernel bug. Try going 
back to 2.2.14, or maybe up to 2.2.19pre2.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
