Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEAfQ>; Sat, 4 Nov 2000 19:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEAfG>; Sat, 4 Nov 2000 19:35:06 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:19986 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129030AbQKEAfB>;
	Sat, 4 Nov 2000 19:35:01 -0500
Date: Sat, 4 Nov 2000 17:34:05 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Multithreaded locks.c
Message-ID: <20001104173405.A15262@hq.fsmlabs.com>
In-Reply-To: <3A042031.A170B555@uow.edu.au> <E13s7vQ-0004hr-00@the-village.bc.nu> <3A04A285.3CA6FD37@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A04A285.3CA6FD37@uow.edu.au>; from Andrew Morton on Sun, Nov 05, 2000 at 10:57:57AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 10:57:57AM +1100, Andrew Morton wrote:
> Even the DG/UX manpage doesn't say what happens when you sidegrade
> the lock.  LOCK_EX->LOCK_EX :)

Suggested code:
         printk("Don't do that\n"); return -EKNUCKLEHEAD;


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
