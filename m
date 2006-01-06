Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWAFPSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWAFPSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAFPRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:17:46 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:35803 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932334AbWAFPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:17:32 -0500
Message-ID: <43BE8A04.6080603@stesmi.com>
Date: Fri, 06 Jan 2006 16:17:24 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
CC: Marcin Dalecki <martin@dalecki.de>, Lee Revell <rlrevell@joe-job.com>,
       Hannu Savolainen <hannu@opensound.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de>	 <20060103193736.GG3831@stusta.de>	 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>	 <mailman.1136368805.14661.linux-kernel2news@redhat.com>	 <20060104030034.6b780485.zaitcev@redhat.com>	 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>	 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>	 <s5hmziaird8.wl%tiwai@suse.de>	 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>	 <1136504460.847.91.camel@mindpipe>	 <4A284096-E889-4E6D-B017-B8241CD72A0D@dalecki.de> <1136510509.9382.24.camel@localhost>
In-Reply-To: <1136510509.9382.24.camel@localhost>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig80A86C0E01FB7E504BC9EB73"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80A86C0E01FB7E504BC9EB73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zan Lynx wrote:
> On Fri, 2006-01-06 at 01:14 +0100, Marcin Dalecki wrote:
> 
>>On 2006-01-06, at 00:40, Lee Revell wrote:
>>
>>>Hey, interesting, this is exactly what dmix does in userspace.  And we
>>>have not seen any bug reports caused by the concept of userspace  
>>>mixing
>>>(just implementation bugs like any piece of software).
>>
>>This attitude that every kind of software has to have bugs is
>>blunt idiotic tale-tale bullshit just showing off complete incompetence.
>>
>>Does the acronym car-ABS and micro-controller maybe perhaps ring a  
>>bell for you? 
> 
> 
> Funny that you should mention bug-free code and ABS.
> 
> Just a few months ago, Subaru updated the ABS controller code for the
> WRX.  They sent me the notice in the mail.  It was an optional upgrade,
> the change was only needed to fix some very odd corner cases.  
> 
> The point being that even critical micro-controller software has bugs.
> 
> Even software that has been mathematically proofed can have bugs.  Knuth
> uses it as a joke: "Beware bugs in the above code.  I have
> proven it correct; I have not actually tried it."
> 
> It's so funny because it's so true.

Same as when Renault introduced the keyless system in the Laguna in 2001
(some call it the Laguna II) - it's basically a card you stick into a
slot in the console which enables you to just press a button to start
the car instead of turning a key and it also contained memory about
your chair settings, mirrors and volume/sound settings of the radio.

Now, is this a highly complex piece of software running there to do
those things?

Regardless of how what someone believes - a few months later someone
was out driving and all of a sudden the car started speeding up and
since there was no key you couldn't turn the car off and the breaks
weren't strong enough to slow the car down and running at roughly
200kph he managed to YANK the card out of the slot before it could be
slowed down and the ignition turned off - the guy was lucky to be
alive.

It turns out that it was a combination of a bug in the keyless
system AND the cruise control that made this happen - two bugs
that in themselves wouldn't have triggered but at the right speed,
and when everything matched things went haywire, so no, no matter
how tight you write specifications or papers you can't get
everything bugfree, even in such a simple system as a keycard
for your car. Note that one of the bugs WAS in the keycard.

// Stefan

--------------enig80A86C0E01FB7E504BC9EB73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvooHBrn2kJu9P78RA4M8AJ9hbCn6wCAlUv0ks5KbHt8QQy9/wwCgwO6/
dUvkCQVgS6hEy9NWlz0PrvA=
=6gND
-----END PGP SIGNATURE-----

--------------enig80A86C0E01FB7E504BC9EB73--
