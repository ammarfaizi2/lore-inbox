Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLGJqU>; Fri, 7 Dec 2001 04:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLGJqL>; Fri, 7 Dec 2001 04:46:11 -0500
Received: from 217-79-103-50.adsl.griffin.net.uk ([217.79.103.50]:43163 "EHLO
	beast.ez-dsp.com") by vger.kernel.org with ESMTP id <S282823AbRLGJqD>;
	Fri, 7 Dec 2001 04:46:03 -0500
Message-ID: <016501c17f04$3f5730c0$0cfea8c0@ezdsp.com>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112061458360.15516-100000@mustard.heime.net> <3C0FD78D.F567ECBD@zip.com.au> <00e601c17eb0$25e20d80$0801a8c0@Stev.org> <3C1006C3.895EEE9F@zip.com.au>
Subject: Re: temporarily system freeze with high I/O write to ext2 fs
Date: Fri, 7 Dec 2001 09:47:54 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > > > why is it that Linux 'hangs' while doing heavy I/O operations (such
as
> > dd)
> > > > to (and perhaps from?) ext2 file systems? I can't see the same
behaivour
> > > > when using other file systems, such as ReiserFS
> > > >
> > >
> > > A partial fix for this went into 2.4.17-pre2.  What kernel are you
> > > using?
> >
> > i have always had with problem normally during disk writes.
> > currently on 2.4.x-14 + 2.4.16
>
> Please try 2.4.17-pre2 or later.
>

ok i should have some time to try that at the weekend.

> > its not that it hangs but it gets extremely laggy eg 2/3 seconds pause
> > for keyboard input to appear on a console.
>
> Your app got paged out, and the enormous read latencies in 2.4.16
> caused it to remain there.

why would it have been paged out there was loads of free
ram. there is 192MB in the machine and no X windows or
anything and the app was bash and there are not many other processes.

    James





