Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRBKUeM>; Sun, 11 Feb 2001 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRBKUeC>; Sun, 11 Feb 2001 15:34:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19470 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130093AbRBKUds>; Sun, 11 Feb 2001 15:33:48 -0500
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 11 Feb 2001 20:33:27 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), tao@acc.umu.se (David Weinehall),
        alan@lxorguk.ukuu.org.uk (Alan Cox), nicku@vtc.edu.hk (Nick Urbanik),
        linux-kernel@vger.kernel.org (Kernel list)
In-Reply-To: <3A86F556.8A5BAB7B@colorfullife.com> from "Manfred Spraul" at Feb 11, 2001 09:25:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S3Ba-0004wz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > printk a message and fail the call.  Don't panic.
> 
> Perhaps add a compile time warning, similar to __bad_udelay();
> The BUG is a bad idea.

They are all dynamic allocations
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
