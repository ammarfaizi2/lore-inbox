Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbRLEUyQ>; Wed, 5 Dec 2001 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284708AbRLEUyH>; Wed, 5 Dec 2001 15:54:07 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:25320 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S284676AbRLEUxy>;
	Wed, 5 Dec 2001 15:53:54 -0500
Message-ID: <008b01c17dce$d96b08d0$0801a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112052100470.3740-100000@mustard.heime.net>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
Date: Wed, 5 Dec 2001 20:53:10 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > thats still does not mean they are sequential creating
> > large files almost always causes them to fragment.
>
> ok...
> mkfs /dev/hdb1
> dd if=/dev/zero of=some-file bs=x count=x
>
> What can fragment this file????
 say you wanna write a 500MB file
on a disk with plenty of space.

but when you create the file it happens to
create it in a place that only a 50MB file can
fit because there is another file on the disk in that
position. after 50MB is created then you have to put the rest file
elsewhere thus you now have a fragmented file.

    James






