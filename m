Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTA1M0t>; Tue, 28 Jan 2003 07:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTA1M0t>; Tue, 28 Jan 2003 07:26:49 -0500
Received: from turing.fb12.de ([193.41.124.37]:26800 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S265285AbTA1M0r>;
	Tue, 28 Jan 2003 07:26:47 -0500
Date: Tue, 28 Jan 2003 13:36:06 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: dada1 <dada1@cosmosbay.com>
Cc: kuznet@ms2.inr.ac.ru, Christopher Faylor <cgf@redhat.com>,
       davem@redhat.com, andersg@0x63.nu, lkernel2003@tuxers.net,
       linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030128133606.A21796@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	dada1 <dada1@cosmosbay.com>, kuznet@ms2.inr.ac.ru,
	Christopher Faylor <cgf@redhat.com>, davem@redhat.com,
	andersg@0x63.nu, lkernel2003@tuxers.net,
	linux-kernel@vger.kernel.org, tobi@tobi.nu
References: <200301280355.GAA27468@sex.inr.ac.ru> <02c601c2c69c$05668d80$1d00a8c0@edumazet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02c601c2c69c$05668d80$1d00a8c0@edumazet>; from dada1@cosmosbay.com on Tue, Jan 28, 2003 at 08:08:10AM +0100
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x82AE75E4
x-gpg-keyid: 0x82AE75E4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

dada1(dada1@cosmosbay.com)@2003.01.28 08:08:10 +0000:
> From: <kuznet@ms2.inr.ac.ru>
> > Can you make tcpdump of this session which looks like tcpdump with -S? =
:-)

This might help you:

I still have a similar problem (ssh hang with other traffic) that i reported
in november on netdev:

  http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D103641051419994&w=3D2

(this post includes a tcpdump and a discription how to reproduce it)

I did not follow up on that because i did not have the time and
i ran into hardware problems then...

(You can find the 'socket' program i used here:
http://www.jnickelsen.de/socket/socket-1.2.html)

/Sebastian
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

"After writing for fifteen years it struck me I had no talent for writing.
But I couldn't give it up: by that time I was already famous." -- Mark Twain

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj42eTYACgkQTsThvluiLwB9FgCfcEvmExOJFZZzfXMdUumBxLkk
AJIAn2QXTt6baQMRTB2zOwdovEK0AmPh
=9NzC
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
