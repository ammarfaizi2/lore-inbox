Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131769AbQKCU6d>; Fri, 3 Nov 2000 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131702AbQKCU6N>; Fri, 3 Nov 2000 15:58:13 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131651AbQKCU6L>;
	Fri, 3 Nov 2000 15:58:11 -0500
Message-ID: <20001103192519.A134@bug.ucw.cz>
Date: Fri, 3 Nov 2000 19:25:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ne2k pcmcia problem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I unplug pcmcia ne2k (without  stopping card, just uplug), it
oopses. In earlier kernels, it gave few error messages but more or
less worked.

I get 

invalid operand 0000

fault is in __wake_up

stack trace contains
c027... (bogus)
c0279978 (bogus)
c01a5e08 ei_receive
c0115994 process_timeout
c01ef18a cs_sleep
c01ef4fa do_shutdown
...

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
