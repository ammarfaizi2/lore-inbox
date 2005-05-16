Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVEPNGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVEPNGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVEPNGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:06:46 -0400
Received: from [80.247.74.3] ([80.247.74.3]:26548 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261606AbVEPNGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:06:33 -0400
Message-Id: <6.2.1.2.2.20050516150603.06683eb0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 15:06:25 +0200
To: li nux <lnxluv@yahoo.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050516125526.82482.qmail@web60512.mail.yahoo.com>
References: <20050516125526.82482.qmail@web60512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14.55 16/05/2005, li nux wrote:

>I guess u r on 32-bit platform.
>Then, u need to enable PAE ( if not enabled alredy)
>and rebuild the kernel.
>This will be transparent to the user space.
>Ur word size will still be 32-bit, only thing is PAE
>will change the way u translate the address by adding
>one more level of indexing to the page table.

Yes! It's already PAE enabled.


>-lnxluv.
>
>--- Roberto Fichera <kernel@tekno-soft.it> wrote:
> > Hi All,
> >
> > I've a dual Xeon 3.2GHz HT with 8GB of memory
> > running kernel 2.6.11.
> > I whould like to know the way how to use all the
> > memory in a single
> > process, the application is a big simulation which
> > needs big memory chuncks.
> > I have readed about hugetlbfs, shmfs and tmpfs, but
> > don't understand how I
> > can access
> > the whole memory. Ok! I can create a big file on
> > tmpfs using shm_open() and
> > than map it by using mmap() or mmap2() but how can I
> > access over 4GB using
> > standard pointers (if I had to use it)?
> >
> > So, please send me some url, documents etc and/or
> > piece
> > of source code that shows how to do it in user
> > space.
> >
> > Thanks _very much_ in advance,
> >
> > Roberto Fichera.
> >
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
>__________________________________
>Yahoo! Mail Mobile
>Take Yahoo! Mail with you! Check email on your mobile phone.
>http://mobile.yahoo.com/learn/mail
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera. 

