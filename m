Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbUKHJqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbUKHJqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUKHJcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:32:54 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:20938 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261802AbUKHJMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:12:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Why my computer freeze completely with xawtv ?
Date: Mon, 8 Nov 2004 10:08:20 +0100
User-Agent: KMail/1.6.2
Cc: Con Kolivas <kernel@kolivas.org>,
       Gregoire Favre <Gregoire.Favre@freesurf.ch>,
       linux-kernel@vger.kernel.org
References: <20041107224621.GB5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
MIME-Version: 1.0
Message-Id: <200411081008.20960.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_EezjBP7E83qLmQX";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_EezjBP7E83qLmQX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Maandag 08 November 2004 09:30, Grzegorz Kulewski wrote:

> I suspect two things:
> - there is some bug in bttv and similar drivers (DVB) that corrupts memor=
y=20
> related with internal mm and vfs structures or does something equally bad,
> - or maybe PCI bandwitch is overflowed, but I do not think it should=20
> happen.
>=20
> But it is very hard to prove any of these I am afraid.

I have the problem as well since I moved from my K6-II to an Opteron based
system. As a workaround, I only use the card in grab mode instead of
overlay, this reduces the frequency of the crashes from once per 30 minutes
to once per month.

Someone also suggested the problem might be related to the old bt848
(ca. 1997) chip not behaving well on modern PCI buses.

	Arnd <><



--Boundary-02=_EezjBP7E83qLmQX
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBjzeE5t5GS2LDRf4RAhoZAJ9aJnFGlbw9V/vzMkdfXA/wJ0xLOgCgg+jw
NJmgei3lLokTjeMCY0Dj5Nc=
=6A+f
-----END PGP SIGNATURE-----

--Boundary-02=_EezjBP7E83qLmQX--
