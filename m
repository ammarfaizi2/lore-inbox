Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVBBQU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVBBQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVBBQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:20:57 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:61094 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262371AbVBBQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:19:26 -0500
From: Lennert Van Alboom <lennert.vanalboom@ugent.be>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Date: Wed, 2 Feb 2005 17:19:14 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org
References: <20050121161959.GO3922@fi.muni.cz> <200502021030.06488.lennert.vanalboom@ugent.be> <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5894109.NE4VRYyl39";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502021719.20470.lennert.vanalboom@ugent.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5894109.NE4VRYyl39
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Positive, I only applied this single two-line change. I'm not capable of=20
messing with kernel code myself so I prefer not to. Probably just a lucky=20
shot that the vesa didn't go nuts with nvidia before... O well, with a bit=
=20
more o'those pharmaceutical drugs even this 80x25 doesn't look too bad.=20
Hurray!

Lennert

On Wednesday 02 February 2005 17:00, Linus Torvalds wrote:
> On Wed, 2 Feb 2005, Lennert Van Alboom wrote:
> > I applied the patch and it works like a charm. As a kinky side effect:
> > before this patch, using a compiled-in vesa or vga16 framebuffer worked
> > with the proprietary nvidia driver, whereas now tty1-6 are corrupt when
> > not using 80x25. Strangeness :)
>
> It really sounds like you should lay off those pharmaceutical drugs ;)
>
> That is _strange_. Is it literally just this single pipe merging change
> that matters to you? No other changces? I don't see how it could
> _possibly_ make any difference at all to anything else.
>
> 		Linus

--nextPart5894109.NE4VRYyl39
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAP2Io6KaR1afCnARAqDZAKCus7Q/P4feY/UPH9ozEyqkbd1GiwCfVgKC
czEfbFb5fGREz9nfgYEMH04=
=m8N0
-----END PGP SIGNATURE-----

--nextPart5894109.NE4VRYyl39--
