Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSKSNsT>; Tue, 19 Nov 2002 08:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKSNsT>; Tue, 19 Nov 2002 08:48:19 -0500
Received: from 251-120-ADSL.red.retevision.es ([80.224.120.251]:28867 "EHLO
	marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S265187AbSKSNsS>; Tue, 19 Nov 2002 08:48:18 -0500
Date: Tue, 19 Nov 2002 14:55:25 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bttv & 2.5.48
Message-ID: <20021119135525.GB14615@jerry.marcet.dyndns.org>
References: <7F54A233BE1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <7F54A233BE1@vcnet.vc.cvut.cz>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Petr Vandrovec <VANDROVE@vc.cvut.cz> [021119 15:27]:

>> drivers/media/video/bttv-cards.c: In function AUDC_CONFIG_PINNACLE' unde=
clared (first use in this function)
>> drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is re=
ported only once
>> drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
>> drivers/media/video/bttv-cards.c: In function name'
>> make[4]: *** [drivers/media/video/bttv-cards.o] Error 1
>> make[3]: *** [drivers/media/video] Error 2
>> make[2]: *** [drivers/media] Error 2
>> make[1]: *** [drivers] Error 2
>> make: *** [modules] Error 2
>>=20
>> I know this has not changed since 2.5.47, nor couldn't spot any
>> difference within the /media tree, yet it fails on 2.5.48 while it
>> compiled fine on 2.5.47
=20
>> Any idea where the error might be?

>I just commented out that offending line, as I do not have Pinnacle,
>so it should be never executed ;-)

That's the first thing I did, but how's that it compiled fine in 2.5.47
if nothing changed?

>If you have Pinnacle, then you'll have to get tda9887 driver somewhere.
>This driver defines AUD_CONFIG_PINNACLE (as far as I can tell from
>missing pieces...).

It's one of the two cards I have but I'm not have it plugged it ATM.


--=20
Javier Marcet <jmarcet@pobox.com>

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3aQs0ACgkQx/ptJkB7frwHxgCfYwPk5AvjThy/EjhoKW4lsR+k
HOUAn1BhZ6FypTmo1OGEe6IMVyWVRojH
=/J+6
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
