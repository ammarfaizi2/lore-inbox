Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRLWPPn>; Sun, 23 Dec 2001 10:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbRLWPPd>; Sun, 23 Dec 2001 10:15:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:26847 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282491AbRLWPP1>;
	Sun, 23 Dec 2001 10:15:27 -0500
Date: Sun, 23 Dec 2001 16:15:18 +0100
Message-Id: <200112231515.fBNFFI530823@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: harri@synopsys.COM (Harald Dunkel)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Support for grub at installation time
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C25ECBF.AF0E819C@Synopsys.COM>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C25ECBF.AF0E819C@Synopsys.COM> you wrote:
> Below you can find a tiny patch to add 2 new targets to the top level 
> Makefile: bzgrub and zgrub. This is a suggestion about how the Grub 
> boot loader could be supported.

Please provide a grub-specific /sbin/installkernel instead.
The lilo targets should die aswell, IMHO.

> It would be nice if you could consider this patch to be included in 
> one of the future kernels. I am not the kernel patch specialist, so 
> please excuse if I missed to follow a specific procedure.

No.  The kernel build process shouldn't know at all about boot loaders.

	Christoph (a happy grub user)

-- 
Of course it doesn't work. We've performed a software upgrade.
