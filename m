Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRBKU0c>; Sun, 11 Feb 2001 15:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRBKU0M>; Sun, 11 Feb 2001 15:26:12 -0500
Received: from colorfullife.com ([216.156.138.34]:16647 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130051AbRBKU0E>;
	Sun, 11 Feb 2001 15:26:04 -0500
Message-ID: <3A86F556.8A5BAB7B@colorfullife.com>
Date: Sun, 11 Feb 2001 21:25:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
In-Reply-To: <E14S04y-0004Tb-00@the-village.bc.nu> <3A86EF11.20C17FD8@mandrakesoft.com> <20010211210826.D20267@khan.acc.umu.se> <3A86F2BA.1B50360C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> 
> printk a message and fail the call.  Don't panic.
> 

Perhaps add a compile time warning, similar to __bad_udelay();

The BUG is a bad idea.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
