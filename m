Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQKFRHE>; Mon, 6 Nov 2000 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129493AbQKFRGy>; Mon, 6 Nov 2000 12:06:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129222AbQKFRGp>; Mon, 6 Nov 2000 12:06:45 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 6 Nov 2000 17:07:16 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <2908.973513747@ocs3.ocs-net> from "Keith Owens" at Nov 06, 2000 11:29:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13spjq-0006OE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Just load the driver at bootup and forget about it.  Problem solved.
> 
> I daily curse the name of whoever added autoload and autounload.
> Autoload maybe useful, autounload is just asking for problems.

Deal with it. Hardware is also now auto load and auto unloading too. For 2.5
hopefully a lot of this can be tidied up and done better - persistent storage
in the modules that is written to disk and put back by insmod/rmmod (in 
userspace) will help a lot.

The locking issues are not going to go away. Home PC's are going more and
more USB oriented. Servers are going towards more and more hotswap cards.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
