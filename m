Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263954AbSKCWEt>; Sun, 3 Nov 2002 17:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSKCWEs>; Sun, 3 Nov 2002 17:04:48 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:43403 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263954AbSKCWEn>; Sun, 3 Nov 2002 17:04:43 -0500
Date: Sun, 3 Nov 2002 23:11:04 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Htree ate my hard drive, was: post-halloween 0.2
Message-ID: <20021103221104.GB1107@admingilde.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021030171149.GA15007@suse.de> <200210310727.52636.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <200210310727.52636.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

after testing htree support, i ran into similar problems:

booted 2.5, tune2fs -O dir_index on all filesystems,
umounted home
fscked -D home, mounted home, all is well...
rebooted into 2.4.19 and everything is still fine

then i got a 'maximum mount count reached' on / while booting 2.4
on fscking, it optimized some directories.
afterwards i had some files missing all over the root fs

after removing dir_index all files were there again

lately my / got checked again, and fsck complained about some
hashed directory entries on a fs without dir_index...
i had to press return several times but did not run into problems...

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9xZ74j/Eaxd/oD7IRAms6AJ950h4CWHYR9UA0Xcb0Vh56qVo2AwCfegbL
DNCm2aDcVFcr3jb4NLwYu9w=
=NtMf
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
