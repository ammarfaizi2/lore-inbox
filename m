Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbRE3AbS>; Tue, 29 May 2001 20:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbRE3AbH>; Tue, 29 May 2001 20:31:07 -0400
Received: from mail.gci.com ([205.140.80.57]:40969 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S261490AbRE3Aa6>;
	Tue, 29 May 2001 20:30:58 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446E125@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.5 -ac series broken on Sparc64
Date: Tue, 29 May 2001 16:30:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've successfully built the 2.4.5 vanilla kernel.

I went to check the -ac series, and each [1-4] breaks
in the same way on Sparc64 platform:

include/linux/irq.h:61: asm/hw_irq.h: No such file or directory
*** [sched.o] Error 1

a find . -name 'hw_irq.h' shows appropriate versions
in i386, ia64, mips, mips64, alpha, ppc, parisc, um, and sh

Is this is a ports-maintainer issue, or what?  Surely
breaking the sparc platform is not in the future plans...

Thanks.

