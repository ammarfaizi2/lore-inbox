Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDOEAo>; Sun, 15 Apr 2001 00:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132574AbRDOEAe>; Sun, 15 Apr 2001 00:00:34 -0400
Received: from mail.gator.com ([63.197.87.182]:52492 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132573AbRDOEA0>;
	Sun, 15 Apr 2001 00:00:26 -0400
From: "George Bonser" <george@gator.com>
To: "Bart Trojanowski" <bart@jukie.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Disorder?
Date: Sat, 14 Apr 2001 21:02:19 -0700
Message-ID: <CHEKKPICCNOGICGMDODJOENLCLAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0104142347410.19694-100000@localhost>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What kernel are you running?

That is 2.4.4-pre3

> This is disabled by default.  search for
> where FASTRETRANS_DEBUG is enabled (should be in linux/include/net/tcp.h
> and set it someting low (like 1 which is the default.  The actual error
> message comes up in tcp_input.c (search fro FASTRETRANS_DEBUG).
>
> Regards,
> Bart.

Thanks, Bart. Looks like it was set to 2.  I have set it to 1 and will build
it again.  I am trying to figure out why 2.4.4 (or to be more accurate
2.4.>1) dies on me when running in my web farm. This last time I tried
running top in the background with:

top -b -i -d10 >crap &

And it has run like a champ!  First time I have ever been able to run it
with good performance for more than 15 minutes.  Maybe I will  just
substitute /dev/null for crap and that will fix it :-/


