Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbTCLHdY>; Wed, 12 Mar 2003 02:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263076AbTCLHdY>; Wed, 12 Mar 2003 02:33:24 -0500
Received: from smtp.cs.curtin.edu.au ([134.7.1.1]:52632 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S261642AbTCLHdX>; Wed, 12 Mar 2003 02:33:23 -0500
Message-ID: <041f01c2e86a$872520d0$64070786@synack>
From: "David Shirley" <dave@cs.curtin.edu.au>
To: "M. Soltysiak" <msoltysiak@hotmail.com>, <linux-kernel@vger.kernel.org>
References: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
Subject: Re: Linux BUG: Memory Leak
Date: Wed, 12 Mar 2003 15:19:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err for starters you should include kernel version and OS versions etc.

Also how do you expect any computer to work once it has run out of
memory? Do you have swap partition? I suspect not, or a small one in
any case!

Some of the applications you mention are notorios for memory leaks
themselves. ie UT!

Cheers
Dave



----- Original Message -----
From: "M. Soltysiak" <msoltysiak@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 12, 2003 2:49 PM
Subject: Linux BUG: Memory Leak


> I sent this here because i don't know which author screwed up.
>
> Basically, it's a massive kernel memory leak or a VM problem.
>
> System specs:
> 1 GBytes RAM
> duel CPU system; 1 Ghz each.
> IDE disk system, 133 Mhz bus speed, DMA.
> USB mouse.
> PS/2 Keyboard.
> Creative Labs emu10k1-based sound card.  (LIVE!)
> Asus Motherboard.
>
> Problem:
>
> When I boot the system, run X11 with KDE--totalling 100 M at most--things
> are fine.
>
> When I run applications that use quite a bit of memory -- those that use
500
> Megs of RAM -- Linux keeps on allocating memory until it's full.  When
full,
> system acts dead, as expected from the bad VM design.  But why does the
> system allocate memory until the RAM is full?  User applications are NOT
> leaking memory.
>
> Example: Installing Unreal Tournament 2003 -- from the CD drive, IDE --
for
> example, playing mp3 files and browsing the web with Mozilla, and the
system
> will eventually allocate memory until the system freezes.  All of RAM is
> allocated, and the system is frozen.
>
> Possible problem: VM algorithm is not too good, and should take a lesson
to
> BSD; or the kernel is leaking memory -- unknown location.  I'll look into
> the problem in a few weeks when i'm free; but now, i got work.
>
> I'm sure many people are getting this problem...
>
> I can fix the problem, but i got engineering projects to worry about.
>
> Matt.
>
>
>
>
> _________________________________________________________________
> The new MSN 8: smart spam protection and 2 months FREE*
> http://join.msn.com/?page=features/junkmail
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

