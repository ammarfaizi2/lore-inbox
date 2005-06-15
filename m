Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFOJRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFOJRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFOJRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:17:15 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:56628 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261360AbVFOJPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:15:01 -0400
Message-ID: <42AFF184.2030209@poczta.fm>
Date: Wed, 15 Jun 2005 11:14:44 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mru@inprovide.com>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net>
In-Reply-To: <200506150454.11532.pmcfarland@downeast.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig37E9F98E8E86D70C08B78979"
X-EMID: a2133138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37E9F98E8E86D70C08B78979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Patrick McFarland napisa=C5=82(a):
> On Wednesday 15 June 2005 04:26 am, Lukasz Stelmach wrote:
>=20
>>M=C3=A5ns Rullg=C3=A5rd napisa=C5=82(a):
>>
>>>I use utf-8 exclusively for my filenames (the few that are not 7-bit
>>>ascii).  Forcing others who use the system to do the same would cause
>>>them a lot of trouble, as they must transfer files to and from Windows=

>>>machines that use anything but utf-8.
>>
>>But VFAT (and NTFS???) use unicode, i.e. UTF-16 (???). AFAIK
>=20
> No, VFAT and NTFS use an 8-bit encoding,

I meant that they don't use utf-8 but it is still the unicode. I am not
sure i've made myself clear.

> Forcing people to use unicode isn't a bad thing btw, especially since
> it is a culture agnostic encoding that can represent wide characters
> (eg. from Asian languages) in a uniform manner*, and allowing to use
> multiple languages (eg. Chinese and Japanese) at once without needing
> to switch encodings.

Yes. I also think UTF-8 is a good idea, however it is not an ideal one.
It *preferes* Roman encodings since some Asian characters need even four
bytes.

IMHO for *every* filesystem there need to be an *option* to:

1. store filenames in utf-8 (that is quite possible today) or any other
unicode form.
2. convert them to/from a desired iocharset. I prefere using ISO-8859-2
on my system for not every tool support utf-8 today (hopefuly yet).

Of course if a user whishes to store filenames in some other encoding
she should be *able* to do so (that is why i like linux).

Generally. IMHO VFAT is a good example how character encoding needs to
be handeled.

Best regards.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig37E9F98E8E86D70C08B78979
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCr/GJNdzY8sm9K9wRAq4QAJ9G/89trokYUfnGnKK1a3tK8+N71gCfdGKe
07A9z9cDldavL+UO45WHhOo=
=XdgF
-----END PGP SIGNATURE-----

--------------enig37E9F98E8E86D70C08B78979--
