Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285315AbRLFXq6>; Thu, 6 Dec 2001 18:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285312AbRLFXqr>; Thu, 6 Dec 2001 18:46:47 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:54689 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S285315AbRLFXqe>; Thu, 6 Dec 2001 18:46:34 -0500
Message-ID: <00e601c17eb0$25e20d80$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Andrew Morton" <akpm@zip.com.au>,
        "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112061458360.15516-100000@mustard.heime.net> <3C0FD78D.F567ECBD@zip.com.au>
Subject: Re: temporarily system freeze with high I/O write to ext2 fs
Date: Thu, 6 Dec 2001 23:45:54 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > why is it that Linux 'hangs' while doing heavy I/O operations (such as
dd)
> > to (and perhaps from?) ext2 file systems? I can't see the same behaivour
> > when using other file systems, such as ReiserFS
> >
>
> A partial fix for this went into 2.4.17-pre2.  What kernel are you
> using?

i have always had with problem normally during disk writes.
currently on 2.4.x-14 + 2.4.16

> For how long does it "hang"?   What exactly are you doing when it
> occurs?

its not that it hangs but it gets extremely laggy eg 2/3 seconds pause
for keyboard input to appear on a console.

> Is your disk system well-tuned?  What throughput do you get with
> `hdparm -t /dev/hdXX'?

i have tuned with hdparm as much as i can. but i cannot tune the
VM because the files in /proc/sys/vm do not seem to make any difference
to the system at all and the documents dont seem to be correct inn
procfs.txt
if docs are wrong for a kernel version would it not be better to either say
they are wrong
or remove them alll together. but i assume this is todo with the latest VM
change.

are there going to be new documents for these files ?

    James


