Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbQLFLVt>; Wed, 6 Dec 2000 06:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbQLFLVk>; Wed, 6 Dec 2000 06:21:40 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:26638 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S131371AbQLFLVb>; Wed, 6 Dec 2000 06:21:31 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Dec 2000 11:51:01 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: poll: nanoseconds in 2.5?
Message-ID: <3A2E281C.22288.D5C37E@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

maybe some of you know that I patched an early 2.2 kernel (2.1.131 or 
so) to provide nanoseconds to the customers, i.e. xtime has tv_nsec.

The patch is available throughout 2.2 (including 2.2.17).

I merged the patch into 2.4test11, it compiles and boots so far.

Now I wonder if there's interest to integrate my code to an early 2.5. 
I will have to clean up some obsolete stuff, and order a few things 
first.

I will need strong support for the non i386 architectures however (I 
only have a Pentium for testing).

Interestingly some of my changes are already in 2.4: Moving the time 
stuff out from kernel/sched.c, joining mktime(), etc.

If there is interest, please say so. I could provide an early alpha-
quality patch by monday, maybe even this friday if someone wants to 
test it or implement another architecture.

(The 2.2 stuff is named PPSkit-1.0.1 and can be found in 
/pub/linux/daemons/ntp/PPS on most mirrors of quality ;-)

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
