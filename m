Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRE3KGU>; Wed, 30 May 2001 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbRE3KGA>; Wed, 30 May 2001 06:06:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262694AbRE3KFy>; Wed, 30 May 2001 06:05:54 -0400
Subject: Re: 2.4.5 -ac series broken on Sparc64
To: lsawyer@gci.com (Leif Sawyer)
Date: Wed, 30 May 2001 08:58:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel mailinglist)
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446E125@berkeley.gci.com> from "Leif Sawyer" at May 29, 2001 04:30:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1550s0-0005XN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I went to check the -ac series, and each [1-4] breaks
> in the same way on Sparc64 platform:

Well I don't guarantee they will.

> include/linux/irq.h:61: asm/hw_irq.h: No such file or directory
> *** [sched.o] Error 1
> 
> a find . -name 'hw_irq.h' shows appropriate versions
> in i386, ia64, mips, mips64, alpha, ppc, parisc, um, and sh
> 
> Is this is a ports-maintainer issue, or what?  Surely
> breaking the sparc platform is not in the future plans...

The sparc64 tree isnt very well integrated with -ac. What I have I merge but
where -ac varies from the Linus tree or the Linus tree requires new files
tends to break it.

It can probably be an empty file

