Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKVKJI>; Thu, 22 Nov 2001 05:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKVKI6>; Thu, 22 Nov 2001 05:08:58 -0500
Received: from ns.caldera.de ([212.34.180.1]:55683 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S275693AbRKVKIo>;
	Thu, 22 Nov 2001 05:08:44 -0500
Date: Thu, 22 Nov 2001 11:08:28 +0100
Message-Id: <200111221008.fAMA8Sa04042@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: rusty@rustcorp.com.au (Rusty Russell)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated parameter and modules rewrite (2.4.14)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E166p1R-0004ll-00@wagner>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E166p1R-0004ll-00@wagner> you wrote:
> Hi all,
>
>    http://ftp.kernel.org/pub/linux/kernel/people/rusty
>
> 	Unified boot/module parameter and module loader rewrite
> updated to 2.4.14.  I'm off to Linux Kongress, so I'll be difficult to
> contact for 10 days or so.

I absolutly oppose to the cosmetic naming changes.

Please let module be be initialized by module_init() and exited by
module_exit().  We had a hard enough time to get it everywhere, not
to mention the name makes a lot of sense.

Also MODULE_PARAM should just stay, combined with Keith's proposal
to use it at boottime aswell (as KBUILD_OBJECT.<paramname>).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
