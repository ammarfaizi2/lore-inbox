Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTD2Wmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTD2Wmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:42:47 -0400
Received: from web41610.mail.yahoo.com ([66.218.93.110]:35983 "HELO
	web41610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261819AbTD2Wmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:42:46 -0400
Message-ID: <20030429225500.36795.qmail@web41610.mail.yahoo.com>
Date: Tue, 29 Apr 2003 15:55:00 -0700 (PDT)
From: Pawan Deepika <pawan_deepika@yahoo.com>
Subject: Re: 'tainting kernel' problem in linux-2.4.18
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0304291822040.6694@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.

 Putting MODULE_LICENSE solved my problem.

Cheers
Deepika

--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Tue, 29 Apr 2003, Pawan Deepika wrote:
> 
> >
> > Hi,
> >
> >  I am trying LKM with linux-2.4.18. I have a
> problem
> > here. When I load the module using 'insmod'
> command,
> > module gets loaded but I get following error
> >
> >
>
------------------------------------------------------
> > /sbin/insmod ./hello.o
> > Warning: loading ./hello.o will taint the kernel:
> no
> > license
> >   See http://www.tux.org/lkml/#export-tainted for
> > information about tainted modules
> > Module hello loaded, with warnings
> >
> ----------------------------------------------------
> >
> > Can anyone tell me why I am getting this problem
> and
> > what is the impact of this error while module is
> > running in kernel.
> >
> > Thanks in advance.
> >
> > Regards,
> > Deepika
> >
> The module police now require you to put something
> like:
> MODULE_LICENSE("Spellman Empire") (or something like
> that)
> in your module.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine
> (797.90 BogoMips).
> Why is the government concerned about the lunatic
> fringe? Think about it.
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
