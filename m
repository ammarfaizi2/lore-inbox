Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264395AbRFXTMV>; Sun, 24 Jun 2001 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264399AbRFXTML>; Sun, 24 Jun 2001 15:12:11 -0400
Received: from nw02.internal.netwalk.net ([216.69.192.202]:12550 "EHLO
	nw02.netwalk.net") by vger.kernel.org with ESMTP id <S264395AbRFXTMH>;
	Sun, 24 Jun 2001 15:12:07 -0400
Message-ID: <007d01c0fce1$c55a8960$29c845d8@hal9000>
Reply-To: "David Brown" <dave@codewhore.org>
From: "David Brown" <dave@codewhore.org>
To: <andyw@edafio.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <001001c0fcde$a9422ec0$ecbd3fd8@wamprat>
Subject: Re: Crash on boot (2.4.5)
Date: Sun, 24 Jun 2001 15:13:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel:

Have you tried swapping in a different stick of RAM and/or running a
boot-time memory tester? Does it boot on 2.2 or any other OSs?

I had a problem like this once before - turned out one of the two 128MB CAS2
modules were bad. I replaced it and 2.4 booted wonderfully.


Good Luck,

- Dave
  dave@codewhore.org


----- Original Message -----
From: "Daniel Fraley" <the_toastman@aristotle.net>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, June 24, 2001 2:51 PM
Subject: Crash on boot (2.4.5)


> Hi, everyone..  I'm borrowing my roommate's email, so please send replies
to
> andyw@edafio.com.  Thanks!
>
> Here's my problem...  when I boot anything 2.4, I get several oopsen in a
> row, all of which are either (most commonly) kernel paging request could
not
> be handled, or (much less common) unable to handle kernel Null pointer
> dereference.  I will send any info on request, but here's my hardware and
> kernel config:
>
> iWill KKR-266R (Via 8363 Northbridge, 686B south)
> AMD tbird 1GHz
> 256MB cas2 pc133 sdram
> ATI Radeon DDR 64MB VIVO
> Kingston KNE120TX (Realtek 8139 chip)
> SBLive! 5.1
> IBM GXP75 30GB (on the via ide controller)
> Pioneer 16x dvd
> ls120
>
> This happens regardless if I turn on swap or not.  When swap is on, it is
a
> 128MB partition (and yes, I'm aware of the recommendation of 2x RAM, but I
> believe I read somewhere that someone was working on that, and I didn't
want
> to waste the extra 384MB on swap).
>
> Is there anything I can do to fix this?
>
> -- andyw
>
> p.s., booting with devfs=nomount is better, but still causes oopsen (I get
> to a login prompt, but if I do much more than mount a disk a copy to it,
the
> system freaks)
>
>
>

