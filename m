Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTA2AhX>; Tue, 28 Jan 2003 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbTA2AhX>; Tue, 28 Jan 2003 19:37:23 -0500
Received: from turing.fb12.de ([193.41.124.37]:57473 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S264010AbTA2AhW>;
	Tue, 28 Jan 2003 19:37:22 -0500
Date: Wed, 29 Jan 2003 01:46:42 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, dada1@cosmosbay.com, cgf@redhat.com,
       andersg@0x63.nu, lkernel2003@tuxers.net, linux-kernel@vger.kernel.org,
       tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
Message-ID: <20030129014642.A1496@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>,
	dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
	lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
References: <20030128.152102.12708956.davem@redhat.com> <200301290009.DAA30355@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301290009.DAA30355@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Jan 29, 2003 at 03:09:21AM +0300
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x82AE75E4
x-gpg-keyid: 0x82AE75E4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

kuznet@ms2.inr.ac.ru(kuznet@ms2.inr.ac.ru)@2003.01.29 03:09:21 +0000:
> Hello!
>=20
> The proposed fix is enclosed. Please, check.

okay, this seems to be a solution.
i can't get the ssh session to lock up with this patch.

thanks,
B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

I'm not as think as you stoned I am.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj43JHIACgkQTsThvluiLwAvNACdHszKgTFA5cmFN+0MGlaCVPVz
fLEAnRVNPuWnQxDcVa7bO9kM5UY4aZto
=TD+1
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
