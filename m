Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRBEGy3>; Mon, 5 Feb 2001 01:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130421AbRBEGyT>; Mon, 5 Feb 2001 01:54:19 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:48121 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129468AbRBEGyL>;
	Mon, 5 Feb 2001 01:54:11 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Frank Davis <fdavis112@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1 
In-Reply-To: Your message of "Sun, 04 Feb 2001 23:51:12 EDT."
             <382569872.981348677202.JavaMail.root@web340-wra.mail.com> 
Date: Mon, 05 Feb 2001 17:54:00 +1100
Message-Id: <E14PfXF-0003w9-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <382569872.981348677202.JavaMail.root@web340-wra.mail.com> you write
:
> Hello,
>    Which archs still need to implement it? I briefly looked over the patch an
d noticed that it had i386, ppc, mips64, and s390 already there.

PPC is there (kinda hackish, but proof of concept).  For the rest, I
don't consider:

	return -ENOSYS;

an implementation.  Someone who understands the interrupt controllers
and vagarities for each platform needs to implement them...

Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
