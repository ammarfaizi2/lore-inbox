Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVFJJgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVFJJgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVFJJgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:36:01 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:8972 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262534AbVFJJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:35:40 -0400
Message-ID: <42A95EE2.4030107@poczta.fm>
Date: Fri, 10 Jun 2005 11:35:30 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: moreau francis <francis_moreau2000@yahoo.fr>
Subject: framebuffer driver for an LCD display
References: <20050609082003.74895.qmail@web25805.mail.ukl.yahoo.com>
In-Reply-To: <20050609082003.74895.qmail@web25805.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9CB069562F96C3B9BFB428F3"
X-EMID: c60b1138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CB069562F96C3B9BFB428F3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

moreau francis napisa=C5=82(a):
> --- Lukasz Stelmach <stlman@poczta.fm> a =C3=A9crit :
>=20
>>Try to find something in:
>>/usr/src/linux/drivers/video/console/fbcon.c
>=20
> hmm I already looked at it...and I can't find out an answer to my initi=
al
> question: can a process which is using a fb console prevent another pro=
cess
> for accessing /dev/fb ?

I don't know.

If I understand it correctly thie situation can be described like this


      GFX hardware
      -----+------
           |
        ---+---
           fb
       +-------+
       |       |
    fbcon     mplayer
    /   \
  vcs1  vcs2
  tty1
  bash

So I belive there might be no way for bash to prevent mplayer from
running. Please someone who knows more about framebuffer divers
correct me because quite probably I'am wrong.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig9CB069562F96C3B9BFB428F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCqV7mNdzY8sm9K9wRArWZAJ0T6lF3H4fj/ywlFYCJcTeBsxAK3gCcCUq4
E6DccDnNemLX44sMQb67R1k=
=HpOx
-----END PGP SIGNATURE-----

--------------enig9CB069562F96C3B9BFB428F3--
