Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVATHNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVATHNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVATHNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:13:41 -0500
Received: from relay-am.club-internet.fr ([194.158.104.67]:748 "EHLO
	relay-am.club-internet.fr") by vger.kernel.org with ESMTP
	id S262068AbVATHN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:13:28 -0500
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Alps touchpad probing failure
Date: Thu, 20 Jan 2005 08:13:11 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501200024.01963.segfault@club-internet.fr> <200501192245.28544.dtor_core@ameritech.net>
In-Reply-To: <200501192245.28544.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4450151.lE06aGnXRS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501200813.16814.segfault@club-internet.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4450151.lE06aGnXRS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dmitry,

Le Jeudi 20 Janvier 2005 04:45, Dmitry Torokhov a =C3=A9crit=C2=A0:
> On Wednesday 19 January 2005 18:23, Daniel Caujolle-Bert wrote:
> > Hi,
> >
> >  With 2.6.11-rc1 bk6 and bk7 (didn't tried with < bk6), my alps touchpad
> > is no more correctly probed, it's recognised as a standard PS/2 mouse.
> > So, with this trivial two line patch, everything is working again.
> >
> > Cheers.
>
> Hi,
>
> I think Peter Osterlund has send similar patch recently - the breakage
> appears to be caused by Kensington mouse detection. It looks like these
> two don't like each other.

 Oh, i see. Okay, maybe that explain why the ps2 command _CMD_GETINFO retur=
ned=20
the wrong 0x0 0x0 0x16 values.

Cheers.
=2D-=20
73's de Daniel "Der Schreckliche", F1RMB.

             -=3D- Daniel Caujolle-Bert -=3D- segfault@club-internet.fr -=
=3D-
                        -=3D- http://naboo.homelinux.org -=3D-

--nextPart4450151.lE06aGnXRS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB71oMLToa6iW5KUsRAsw4AJ0cA6dI3/Y2xUA6QoEm0YIjOwLtkgCePM8V
djhSVjYkqdivnAN4aJ2IZRU=
=fS1a
-----END PGP SIGNATURE-----

--nextPart4450151.lE06aGnXRS--
