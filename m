Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVBRAnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVBRAnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVBRAnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:43:24 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:20845 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261276AbVBRAmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:42:43 -0500
Message-ID: <421539FD.10806@triplehelix.org>
Date: Thu, 17 Feb 2005 16:42:37 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
References: <4214450B.6090006@triplehelix.org> <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72A561B275B505571C91938B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72A561B275B505571C91938B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Does the box still work? It may well be that once all drivers have had a
> chance to initialize their hardware properly, the problem is just gone,
> and that the interim reports about not being able to handle the irq are
> just temporary noise.

The box seems to work fine; on the other hand, I don't have a mouse or
keyboard plugged in, it's my router machine. (In this particular
instance, I had a keyboard plugged in after I realized I goofed up with
some modules, but generally I don't do that.)

> Of course, even if it works, the noise _is_ actually indicative of a
> problem. There shouldn't be any pending interrupts, especially not
> level-triggered ones. And it can cause a non-working mouse if you don't
> load the driver for the wireless card (or vice versa).

If I have to reboot the box for something, I'll experiment with plugging
in a mouse before loading hostap. (But see below)

> What was the previous kernel you ran on that machine, just out of
> interest? If it hasn't happened before, it would be interesting to know
> when it started happening...

It used to be running 2.4.27, where there was no evidence of such a bug
occurring. I'd rather not bother with trying to find out what's going on
if it'll require me to reboot with all sorts prerelease snapshots, since
this is my web server, mail server, etc...

--
Joshua Kwan

--------------enig72A561B275B505571C91938B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQhU5/6OILr94RG8mAQIFrhAA9mScdEUYXv+ZXMzLpmQQ2nlqNTapjfcc
FU9/2S8xFMh15O72Fcxwz4CjA8a41XFY+4QOdB4i42hwPR8UTAxczRa+R15y5KbX
NlzEYdKTUtB3UA1T6NjbjOYksmuYtm1Nei8hiW+hZPbriXOQ3WDRO9yqjM9qttVO
ej5TiCBQ5lM0oW9oI6XAXg1SRMKqkgr4ONK35GGtGjYEg1tp0y0u8bzzM/Lv9x+N
crWYI78K6vHqR8rqPFnE4utbGZ0P7sQ5K4O1hTLAui3i1GXsCGoa0+wvpw+f2KYK
QtnszZ3CYBh2mKzFtvIFukkSLU26HV2xuLtNkxSTYDd5r1mVZzcz95ZJHYK6y6WJ
Z7WJwoyTWxFZUza1YD91kVSoyCmwNakn+hLD+lzTk8C/48KHidXdY7Bq7EeKud0a
7T+Rf/aORWb9l9QHyHI8Hh5hba5VNfj6Ou1hm1aEWhSXIeevenKN7o2Wy8vXyyRQ
ehc3AbYqBbjCAPll2/Qmj5XZkRVW2tPcTvYyMCNGsQvggDduErYYN1oKkq7Cz5ag
w+riafbfx3g+Vl6hJGrbVFFVA9g0bNwUGvNVdMNt5jxn+mDyBxu6rWO2PFMObiEb
hRZgtsqSreTfsGdaS9Y0ecoSQcHjn7ra/Ie4qIG3Rt5F6RRO/LLAEV/gfP9nTK1r
0WcW+Ot3EtY=
=BRfG
-----END PGP SIGNATURE-----

--------------enig72A561B275B505571C91938B--
