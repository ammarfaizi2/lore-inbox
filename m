Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbRFYEtK>; Mon, 25 Jun 2001 00:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264476AbRFYEtB>; Mon, 25 Jun 2001 00:49:01 -0400
Received: from adsl-65-68-16-200.dsl.ltrkar.swbell.net ([65.68.16.200]:16164
	"EHLO etmain.edafio.com") by vger.kernel.org with ESMTP
	id <S264436AbRFYEsx> convert rfc822-to-8bit; Mon, 25 Jun 2001 00:48:53 -0400
Subject: RE: Crash on boot (2.4.5)
Date: Sun, 24 Jun 2001 23:44:00 -0500
Message-ID: <3BDF3E4668AD0D49A7B0E3003B294282BC92@etmain.edafio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Crash on boot (2.4.5)
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
content-class: urn:content-classes:message
Thread-Index: AcD88B/htiBJExjqTa+FOE4re6LoFwAQRylw
From: "Andy Ward" <andyw@edafio.com>
To: "David Brown" <dave@codewhore.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunatly, the memory is just fine.  Both 2.2 *and* two versions of
windows run just fine on the same machine, so it's probably not that.

-- andyw

-----Original Message-----
From: David Brown [mailto:dave@codewhore.org]
Sent: Sunday, June 24, 2001 2:14 PM
To: Andy Ward
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash on boot (2.4.5)


Daniel:

Have you tried swapping in a different stick of RAM and/or running a
boot-time memory tester? Does it boot on 2.2 or any other OSs?

I had a problem like this once before - turned out one of the two 128MB
CAS2
modules were bad. I replaced it and 2.4 booted wonderfully.


Good Luck,

- Dave
  dave@codewhore.org


----- Original Message -----
From: "Daniel Fraley" <the_toastman@aristotle.net>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, June 24, 2001 2:51 PM
Subject: Crash on boot (2.4.5)


> Hi, everyone..  I'm borrowing my roommate's email, so please send
replies
to
> andyw@edafio.com.  Thanks!
>
> Here's my problem...  when I boot anything 2.4, I get several oopsen
in a
> row, all of which are either (most commonly) kernel paging request
could
not
> be handled, or (much less common) unable to handle kernel Null pointer
> dereference.  I will send any info on request, but here's my hardware
and
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
> This happens regardless if I turn on swap or not.  When swap is on, it
is
a
> 128MB partition (and yes, I'm aware of the recommendation of 2x RAM,
but I
> believe I read somewhere that someone was working on that, and I
didn't
want
> to waste the extra 384MB on swap).
>
> Is there anything I can do to fix this?
>
> -- andyw
>
> p.s., booting with devfs=nomount is better, but still causes oopsen (I
get
> to a login prompt, but if I do much more than mount a disk a copy to
it,
the
> system freaks)
>
>
>

