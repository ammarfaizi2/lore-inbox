Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWJBAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWJBAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWJBAJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:09:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59059 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932517AbWJBAJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:09:07 -0400
X-Sasl-enc: v4he+cMY2pw2KszQEuSUhx34ATREqrAYjx5nhWQDqwJ+ 1159747748
Message-ID: <4520590E.1020703@imap.cc>
Date: Mon, 02 Oct 2006 02:10:54 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jeff@garzik.org>, kkeil@suse.de, kai.germaschewski@gmx.de,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04FB440F28206055CA1FF138"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04FB440F28206055CA1FF138
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sun, 01 Oct 2006 22:30:17 +0200, Alan Cox wrote:
> I've actually been spending some time reviewing these and the warnings
> are for stupid things but not real 64/32 problems. I've got some diffs
> that clean it up just by tidying up casts etc if anyone actually still
> cares about the old ISDN code.

Yes, the old ISDN code still has a considerable user base at least
here in Germany. There are many ISDN devices which are supported by
the old ISDN subsystem (ISDN4Linux) but not the new one (CAPI2.0).
(Some of them are supported by out-of-tree CAPI2.0 drivers like mISDN,
but still.) Also, CAPI2.0 so far doesn't have a driver interface
document (like Documentation/isdn/INTERFACE for ISDN4Linux), so the
old drivers may still be with us for some time to come.

Besides, Jeff's proposed patch would disable the new ISDN subsystem
along with the old one, so I suppose his criticism applies to the
new one too.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)




--------------enig04FB440F28206055CA1FF138
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFIFkOMdB4Whm86/kRAsgNAJ9w++k2I/Tm3G1VDttv813UZPetXACcDC40
+aEyrr9D0iR2yMT48A9k4oc=
=qRUh
-----END PGP SIGNATURE-----

--------------enig04FB440F28206055CA1FF138--
