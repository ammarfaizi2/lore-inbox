Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTI2MVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 08:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTI2MVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 08:21:45 -0400
Received: from [195.249.40.37] ([195.249.40.37]:525 "HELO nettonet.dk")
	by vger.kernel.org with SMTP id S263225AbTI2MVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 08:21:44 -0400
From: Simon Ask Ulsnes <simon@ulsnes.dk>
To: linux-kernel@vger.kernel.org
Subject: Complaint: Wacom driver in 2.6
Date: Mon, 29 Sep 2003 14:21:45 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291421.45692.simon@ulsnes.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there!
I am the lucky owner of a Wacom Graphire 2 tablet, which works great with the 
latest 2.4-kernels. However, the 2.6-drive is unusually and utterly broken. 
Frankly, it doesn't work at all.

When I load up X11 with the proper /dev-symlinks and all that stuff in place 
(2.6 names the tablet /dev/input/event1 as opposed to 2.4, which names it /
dev/input/event0), the tablet simply doesn't respond. I can see in my 
XFree86.0.log file that the tablet is recognized correctly by the kernel, but 
that's about it.

Of course, I tried the linux-wacom (linux-wacom.sourceforge.net) drivers, but 
they fail to compile most miserably (the beta dev-version). From what I could 
deduce of the compiler output, it is incompatible with 2.6.

I filed a bug report a long time ago (2.5.65-ish), but no one really seemed to 
care.

I would really like some info on what progress is being made in this area, as 
it currently is the only thing stopping me from switching seriously to 2.6.
I suppose it is also one of those drivers that Linus keeps talking about need 
to be ready before 2.6 can be finally released (in which I agree, obviously).

And finally, some relevant system specs:
Distro: Gentoo
Kernel: 2.6.0-test6
X11: XFree86 4.3.99.12

Yours sincerely,
Simon Ask Ulsnes


