Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWIXWAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIXWAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWIXWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:00:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:17087 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932217AbWIXWAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:00:45 -0400
X-Sasl-enc: Ys62adspNPeaFPW09JJ197P0sl4z+OALaMyGA/LSmgzg 1159135246
Message-ID: <45170075.2090803@imap.cc>
Date: Mon, 25 Sep 2006 00:02:29 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <200609241922.k8OJMeHs008932@turing-police.cc.vt.edu>
In-Reply-To: <200609241922.k8OJMeHs008932@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig49A2C87407BCC3EBAEE72465"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49A2C87407BCC3EBAEE72465
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24.09.2006 21:22, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 24 Sep 2006 18:59:18 +0200, Tilman Schmidt said:
>=20
>> FYI: On my Dell OptiPlex GX110 (Intel Pentium III, 933 MHz, 512 MB
>> RAM, i810 chipset), kernel 2.6.18-rc7-mm1 takes drastically longer
>> to boot than 2.6.18 mainline release. Some data points from the
>> respective dmesg outputs:
>=20
>> <<<<<<< 2.6.18
>> <4>[   26.336075] ------------------------
>> <4>[   26.336130] | Locking API testsuite:
>=20
> Try building your -rc7-mm1 kernel without CONFIG_DEBUG_LOCKING_API_SELF=
TESTS
> (and you've probably got a few other high-impact DEBUG options turned
> on - CONFIG_PROVE_LOCKING is another possible culprit).

Thanks, but what I am actually wondering, and what I think
may be worth investigating (provided I am not the only one
affected, of course) is why -mm1 is much slower than mainline
*built with the same DEBUG options*.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig49A2C87407BCC3EBAEE72465
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFFwB1MdB4Whm86/kRArvlAJ48BGe7uq/KJap/0g0QsXIsEP3eTACeInvU
0EyHvRsVMQu6aWInDTkjUXM=
=iMYv
-----END PGP SIGNATURE-----

--------------enig49A2C87407BCC3EBAEE72465--
