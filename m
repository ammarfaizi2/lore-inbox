Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUF0TYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUF0TYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUF0TYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:24:08 -0400
Received: from wblv-227-07.telkomadsl.co.za ([165.165.227.7]:11201 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262071AbUF0TXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:23:54 -0400
Subject: Re: [PATCH] Staircase scheduler v7.7
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Con Kolivas <lkml@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <40DEF1E2.6020609@kolivas.org>
References: <40DEF1E2.6020609@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PSx6yLBRCdymoUhToeC5"
Message-Id: <1088364206.9556.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 27 Jun 2004 21:23:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PSx6yLBRCdymoUhToeC5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-27 at 18:12, Con Kolivas wrote:

> Changes since v7.4:
>=20
> Two major bugs:
> - Nanosecond to jiffy conversion meant it was possible to queue a task=20
> with no timeslice. Fixed.
> - The preempt logic I added to 7.4 to allow preempted tasks to continue=20
> where they left off turned out to be a DoS recipe. Fixed.
>=20

Seems all right in regards to the issues with 7.4.

I do though get that xmms sort of 'hangs'.  Its not hard, it just say in
the 'play' state, but the graph do not move, and no sound.  This is
fairly intermittently.  Not sure though if it is scheduler only,
something recent in -bk, or the recent alsa patch Takashi Iwai
posted (using dmix btw).   I will have a look and let you know.


Cheers,

--=20
Martin Schlemmer

--=-PSx6yLBRCdymoUhToeC5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3x6uqburzKaJYLYRApAkAJ97ZA5JE2d601aDREyoe5SikPTQSgCfdKPp
gX4pU0ZOzQUs6aPeMlTRMtw=
=tEwp
-----END PGP SIGNATURE-----

--=-PSx6yLBRCdymoUhToeC5--

