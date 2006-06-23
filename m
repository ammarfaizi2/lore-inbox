Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWFWOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWFWOPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWFWOPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:15:01 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:38330 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750741AbWFWOPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:15:00 -0400
Subject: Re: all-modular snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Collins <paul@briny.ondioline.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <87hd2cz116.fsf@briny.internal.ondioline.org>
References: <87hd2cz116.fsf@briny.internal.ondioline.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1D2HO/H6PtMafGIpufJc"
Date: Fri, 23 Jun 2006 16:14:55 +0200
Message-Id: <1151072095.7608.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1D2HO/H6PtMafGIpufJc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 19:14 +1000, Paul Collins wrote:
> I get this when building from Linus's current git tree:
>=20
>     LD      sound/built-in.o
>   ld: sound/aoa/built-in.o: No such file: No such file or directory
>   make[1]: *** [sound/built-in.o] Error 1
>   make: *** [sound] Error 2
>=20
> Doing "touch sound/aoa/built-in.o" lets the build continue and
> complete successfully.

Ahrg! That's a mistake in my Makefile programming, I'll probably have to
move the core/ files up one dir. Sorry.

johannes

--=-1D2HO/H6PtMafGIpufJc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJv3XaVg1VMiehFYAQIqTRAAs6VClE9YJKDUqHEfkdNakRrbaG4WA1V7
5TvESpfty1R42EI5e26Kco1U0USdGZMqEoBZnAFVGdHaSUf3A48EUEDe4ZFAERR0
eI4lm8lEisAdYejQYQbp2YNN9Nj2+HDxjuIrNQ96RyEpSc4VMHkH0E6ymlVnnEPG
jssnP8UP9G9fa9cwS81cabO3SA4o7xT59Or7jcRytKiBobFV39ix1Ekm4aDP6y14
yd4Bmn03lONPYqGpVhN7LzEcy4x3juICHsfZCIe7b8f/BrQezpeNyl+UPZPz/Ogs
jf3IGWVVg98baYgvsZ82AKEnHwDyrgutdz82zWgSwqUBOQLVY7uX1ODRp59BPOce
1x4YYYD4latxtQXXxRFq1GlUWnwqsmeMxb1Zwf5Yx86NVE/4mdAxnCxD/KvI1jAi
LRhtfjiltyHrmuuobHWySmxGFYI9s5aPoyehaRD9gNphCyDggt4NVKw8qXBfP/Wo
FQW7wYie62i7PNUi9W+FBL0WFn+TihAfgbBOBCCnLY9Q7P3/QFTC5oASzGOQvSIG
2KA5Yjh9xCGs61x8Umc2yte8nE1JWn+Xiipu2eK3eHInS3JcGPi8MWr6oi5wDECu
O4mctQgreOO1HvLPFVuTiHCZz03BwgfSFWL8S1mtBbQXIaNRprHdybkCZpjzHxHO
QaLNQOtPkuU=
=Y1tC
-----END PGP SIGNATURE-----

--=-1D2HO/H6PtMafGIpufJc--

