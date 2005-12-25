Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVLYSOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVLYSOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVLYSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:14:15 -0500
Received: from mout1.freenet.de ([194.97.50.132]:15300 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750882AbVLYSOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:14:15 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Mateusz Berezecki <mateuszb@gmail.com>
Subject: Re: kernel list / container_of aka list_entry question
Date: Sun, 25 Dec 2005 19:10:49 +0100
User-Agent: KMail/1.8.3
References: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com> <1e62d1370512250924r4e3078d0ubb8986d52ac8aeb@mail.gmail.com>
In-Reply-To: <1e62d1370512250924r4e3078d0ubb8986d52ac8aeb@mail.gmail.com>
Cc: Fawad Lateef <fawadlateef@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-mentors@selenic.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1369121.Uotd3vQADL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512251910.49869.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1369121.Uotd3vQADL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 25 December 2005 18:24, you wrote:
> > The second question is why the following code generates errors
> > during compilation. list.h header file is included.
> >
> >         struct atheros_priv *priv =3D ieee80211_priv(dev); /* line numb=
er 141 */
> >         struct list_head *iterator;
> >
> >
> >         list_for_each(iterator, &priv->rxbuf.list) {
> >                 struct ath_buf *bf =3D list_entry(iterator, (struct ath=
_buf), list);
                                                              ^            =
  ^
Remove the parenthesis.

=2D-=20
Greetings Michael.

--nextPart1369121.Uotd3vQADL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDruCplb09HEdWDKgRApAxAJ4hVv495sEUgwdpyLFeWfoLoP+JtgCcCFSL
Hr+cTeRhLFSNKSPXezHVEVI=
=1eg8
-----END PGP SIGNATURE-----

--nextPart1369121.Uotd3vQADL--
