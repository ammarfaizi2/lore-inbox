Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRBFKVU>; Tue, 6 Feb 2001 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBFKVK>; Tue, 6 Feb 2001 05:21:10 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:5389 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129101AbRBFKVA>; Tue, 6 Feb 2001 05:21:00 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 6 Feb 2001 11:20:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.x: spinlock problem
Message-ID: <3A7FDE02.17474.A94DE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had reported this before: In 2.4.0 getting exact system time from 
interrupt handlers seems inaccurate (in 2.2.18 it works fine). I have 
applied the same modifications to the 2.4 code base as to 2.2.

With 2.4.1 the kernel is incredibly slow, so you can watch the 
individual lines of kernel boot be printed on the screen.

I checked the spinlocks, but could not find a problem. Before I start 
removing the new spinlocks for timer, PIC and RTC, I'd like to hear 
what the gurus might think.

I also tried to find out how I can profile the kernel or trace the 
spinlocks, but that seems to be hardly documented.

Any hints?

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
