Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131299AbRBMNF2>; Tue, 13 Feb 2001 08:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRBMNFS>; Tue, 13 Feb 2001 08:05:18 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:6188 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131299AbRBMNFO>;
	Tue, 13 Feb 2001 08:05:14 -0500
Message-ID: <XFMail.20010213130505.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Tue, 13 Feb 2001 13:05:05 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x SMP blamed for Xfree 4.0 crashes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having experienced a number of crashes with Xfree 4.0 with 2.4
kernels, that I wasn't getting with 2.2 kernels, a quick search on
the xfree Xpert mailing list reveals this:

--------------------------------------------------------------------
(http://www.xfree86.org/pipermail/xpert/2001-January/004666.html)

Mark Vojkovich mvojkovich@valinux.com
Wed, 10 Jan 2001 10:49:05 -0800 (PST)

On Wed, 10 Jan 2001, Martin Schenk wrote:
 > I'm using the nv.o driver
of XFree-4.0.1 with a TNT card
> on a SMP system under the new linux kernel 2.4.0.
>> Occasionally XFree segfaults and dumps me back to the command
> line.
> I assume the problem has to do with my using the new kernel,
> which provides finer grained kernel locks.
>> I attach the startup info from XFree.log and a backtrace done
> on the coredump (if someone is interested in the coredump,
> it is about 2MB bzip2'd).

   This is a long-standing problem with 2.3 and 2.4 SMP
kernels.  I believe it is a kernel bug and isn't the XFree86
project's problem.  The problem does not exist on 2.2
SMP kernels nor on 2.3/4 UP kernels.  The symptoms are
random segfaults in perfectly fine XFree86 code. 
---------------------------------------------------------------------

Anyone looking into this?

-tony


---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
If a nation expects to be ignorant and free,
... it expects what never was and never will be.
		-- Thomas Jefferson

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
