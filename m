Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFB7m>; Fri, 5 Jan 2001 20:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAFB7c>; Fri, 5 Jan 2001 20:59:32 -0500
Received: from pop.gmx.net ([194.221.183.20]:52507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129324AbRAFB7O>;
	Fri, 5 Jan 2001 20:59:14 -0500
Date: Sat, 6 Jan 2001 02:58:02 +0100
From: Raphael Schmid <raphael.schmid@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with devfs (?)
Message-ID: <20010106025802.A7561@awapp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm using ROCK Linux, which is built with devfs, originally Kernel
2.4.0-test9. This problem occurs, when I want to boot some Kernel after
2.4.0-test9, whereas building and installing the Kernel never is a problem.

I enabled devfs support as well as the mounting of devfs at bootup in the
configuration, just as it is with my "default"Kernel, next, I played around
with lilo.conf (under normal circumstances a make bzlilo without any
playing-around should do it, shouldn't it?)
Then, as this also did show no success I tried passing root=/.....
devfs=mount (<= don't nail me on this one, but I'm sure I did it the right
way) at the LILO boot prompt.
Whole story. Point. That's all. When trying to mount the root he hangs with
"Kernel Panic: I have no root and I want to scream." Poor Kernel.
Hope this helps anyone except me in any way (or perhaps I'm just too
stupid).

Best Regards, Raphael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
