Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291103AbSBLPQa>; Tue, 12 Feb 2002 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291105AbSBLPQX>; Tue, 12 Feb 2002 10:16:23 -0500
Received: from galactus.CS.Berkeley.EDU ([169.229.62.130]:34312 "EHLO
	galactus.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id <S291103AbSBLPQR>; Tue, 12 Feb 2002 10:16:17 -0500
Message-ID: <3C6931B6.F3F84212@cs.berkeley.edu>
Date: Tue, 12 Feb 2002 07:16:06 -0800
From: "J. Robert von Behren" <jrvb@cs.berkeley.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-686 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 hangs hard w/ wavelan_cs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

I've been seeing some seriously bad behavior from the wavelan_cs kernel
module in 2.4.17.  (I've tried 2.4.16 as well, compiled my own kernels
rather than using the debian woody packages, etc - all w/ no effect on
the bug.)  After a bit of data is transfered, the machine hangs up.  The
Alt-SysRq trick does nothing, unfortunately, so I haven't been able to
get any additional info.  Also, the man page doesn't mention any
additional debugging that I can turn on, so the logs don't have anything
useful, either.  ;-(

The bug seems to be timing sensitive, since it doesn't always occur at
the same point in my file transfer tests.  It happens very consistently
though - always within the first few megabytes of data transfered.

I've used the same hardware setup w/ older versions of the kernel
(2.2.14, 2.2.17, and probably some other 2.2.X kernels) with no
problems.  The pertinent changes (AFAICT) are that I'm running 2.4 now,
and that I've been using the built-in pcmcia support, rather than the
external pcmcia_cs package.

Any ideas?  Any advice on how I can get some better debugging info?

Thanks much!!

Best regards,

-Rob von Behren
