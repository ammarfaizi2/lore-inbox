Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbQKFRQY>; Mon, 6 Nov 2000 12:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQKFRQO>; Mon, 6 Nov 2000 12:16:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:2060 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S129704AbQKFRQF>;
	Mon, 6 Nov 2000 12:16:05 -0500
Message-ID: <3A06F3F1.37F84C10@evision-ventures.com>
Date: Mon, 06 Nov 2000 19:09:53 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13spjq-0006OE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >Just load the driver at bootup and forget about it.  Problem solved.
> >
> > I daily curse the name of whoever added autoload and autounload.
> > Autoload maybe useful, autounload is just asking for problems.
> 
> Deal with it. Hardware is also now auto load and auto unloading too. For 2.5
> hopefully a lot of this can be tidied up and done better - persistent storage
> in the modules that is written to disk and put back by insmod/rmmod (in
> userspace) will help a lot.

Not quite: plugging physically hardware in and out is compleatly
different
then just loading a driver and unconditionally unloading it even when
the hardware is still there!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
