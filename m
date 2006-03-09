Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWCISHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWCISHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCISHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:07:18 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:27812 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750751AbWCISHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:07:16 -0500
X-Sasl-enc: QK6T57VuKMWMYHB6cHsOAemIumUIzklGWE/J480qz3CB 1141927633
Message-ID: <44106EDB.5020905@imap.cc>
Date: Thu, 09 Mar 2006 19:07:23 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
References: <5NHCi-8jp-5@gated-at.bofh.it>	<44101B83.9060503@imap.cc> <20060309041809.028c8c6a.akpm@osdl.org>
In-Reply-To: <20060309041809.028c8c6a.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF25BA08337B75162034FCF55"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF25BA08337B75162034FCF55
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09.03.2006 13:18, Andrew Morton wrote:

> Tilman Schmidt <tilman@imap.cc> wrote:
>=20
>>Andrew Morton wrote:
>>
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16=
-rc5/2.6.16-rc5-mm3/
>>
>> This panics and dies during early boot with a divide error in kmem_cac=
he_init
>> on my Dell GX110.
>=20
> Yup, please apply ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/pat=
ches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/hot-fixes/revert-x86_64-mm-i386-early-=
alignment.patch

That fixed it. Thanks!

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigF25BA08337B75162034FCF55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEG7jMdB4Whm86/kRAv+vAJsGJu7B8Tn6KsREB3lA/0OrWBvCKwCfV/c4
jXVI8D2sIxCwJNANA5KREUM=
=2+hM
-----END PGP SIGNATURE-----

--------------enigF25BA08337B75162034FCF55--
