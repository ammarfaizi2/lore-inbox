Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWBOBz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWBOBz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWBOBz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:55:26 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35498 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030486AbWBOBzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:55:25 -0500
X-Sasl-enc: vHNBi7ycn72YGy7xp+t5pcVtyVERUf2kE/aHc+fi6bif 1139968522
Message-ID: <43F28A46.9030105@imap.cc>
Date: Wed, 15 Feb 2006 02:56:22 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, hjlipp@web.de, greg@kroah.com, kkeil@suse.de,
       akpm@osdl.org
Subject: Re: + isdn4linux-siemens-gigaset-drivers-common-module.patch added
 to -mm tree
References: <200602121032.k1CAWLTg002183@shell0.pdx.osdl.net> <1139758170.20703.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1139758170.20703.14.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD341A381F9BC2EB479F7E9A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD341A381F9BC2EB479F7E9A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12.02.2006 16:29, Arjan van de Ven wrote:
>=20
>>+struct prot_skb {
>>+	atomic_t		empty;
>>+	struct semaphore	*sem;
>>+	struct sk_buff		*skb;
>>+};
>=20
> please consider using mutexes instead!

Thanks for the hint. As you may have guessed, the driver dates from
pre-mutex times. :-) However, this structure is currently unused,
anyway, so we'll just remove it and recreate it with a mutex should we
need it again.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigFD341A381F9BC2EB479F7E9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8opGMdB4Whm86/kRAnZmAJ9BIz5jH2mGyZUsdQjNbkcQRuVsaACeMTTX
a6pugemlJJF3sHKW25m6UWw=
=EFrN
-----END PGP SIGNATURE-----

--------------enigFD341A381F9BC2EB479F7E9A--
