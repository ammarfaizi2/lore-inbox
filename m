Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLRFNX>; Mon, 18 Dec 2000 00:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLRFNO>; Mon, 18 Dec 2000 00:13:14 -0500
Received: from mail4.mia.bellsouth.net ([205.152.144.16]:10940 "EHLO
	mail4.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129325AbQLRFM6>; Mon, 18 Dec 2000 00:12:58 -0500
Message-ID: <3A3D4FB4.CBA887E4@bellsouth.net>
Date: Sun, 17 Dec 2000 23:43:48 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3
In-Reply-To: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DRM_R128=m
we fail to produce module linux/drivers/char/drm/r128.o
Any thoughts.
Albert

Linus Torvalds wrote:
> 
> The most noticeable part of this is that the run_task_queue fix should
> cure the lockup that some people have seen.
> 
> The shmfs cleanup should be unnoticeable except to users who use SAP with
> huge shared memory segments, where Christoph Rohlands work not only
> makes the code much more readable, it should also make it dependable..
> 
>                 Linus
> 
> ----
> 
>  - pre3:
>    - Christian Jullien: smc9194: proper dev_kfree_skb_irq
>    - Cort Dougan: new-style PowerPC Makefiles
>    - Andrew Morton, Petr Vandrovec: fix run_task_queue
>    - Christoph Rohland: shmfs for shared memory handling
> 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
