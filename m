Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTJSOeY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJSOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 10:34:24 -0400
Received: from webmail.cs.unm.edu ([64.106.20.39]:56020 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S262149AbTJSOeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 10:34:15 -0400
Date: Sun, 19 Oct 2003 08:33:54 -0600
From: Bernard Moret <moret@cs.unm.edu>
To: linux-kernel@vger.kernel.org
Subject: i8k support changed from 2.6.0-test7 to 2.6.0-test8?
Message-ID: <20031019143354.GE29525@cs.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Scanner: exiscan *1ABEd1-0005Pc-00*793l.lKuP5g*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell Precision M60 laptop (effectively, a souped-up Latitude D800).
I have tried just about every single 2.6.0-test*-bk* kernel (because
this laptop BIOS does not support apm and has a lot of new, unrecognized
hardware, I keep upgrading kernels every day or two...)

I have used with success under all 2.6.0-testx kernels so far the
"Dell laptop support" (i8k) to enable me to control the fans and the
volume buttons (with the i8ktools package; the fan control is
particularly useful, because the M60 BIOS insists on running the fans
all the time to keep the temp below 45C -- so it's noisy and has bad
battery life).  The i8k support complains that it cannot recognize my
laptop model, but it works just fine (if used as a module, it has to
be forced in for that reason).
I normally compiled support directly into the kernel, not as a module.

The last kernel for which this worked was 2.6.0-test7-bk8.
Two days later, the 2.6.0-test8 came out; I installed it with the same
configuration; the result is: "no such device".  I recompiled with
i8k set up as a module to look more carefully at what happens
when I insert it.  I get the same error message:
     insmod: error inserting 'i8k': -1 no such device

I have yet to do a diff between the two sources to find out what
changed; but I would humbly request that support for the i8k module
remain in 2.6.x kernels -- it is very useful.

					Bernard Moret
-- 
Bernard M.E. Moret	     moret@cs.unm.edu      http://www.cs.unm.edu/~moret
(505) 277-5699 (office)    (505) 277-6927 (FAX)     (505) 277-3112 (department)
Department of Computer Science, University of New Mexico, Albuquerque, NM 87131
