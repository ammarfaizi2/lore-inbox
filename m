Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293123AbSB1Gdl>; Thu, 28 Feb 2002 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293195AbSB1Gbh>; Thu, 28 Feb 2002 01:31:37 -0500
Received: from florin.dsl.visi.com ([209.98.146.184]:37954 "HELO
	beaver.iucha.org") by vger.kernel.org with SMTP id <S293194AbSB1Gb0>;
	Thu, 28 Feb 2002 01:31:26 -0500
Date: Thu, 28 Feb 2002 00:31:13 -0600
From: Florin Iucha <florin@iucha.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Franck <afranck@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre1-ac1
Message-ID: <20020228003113.B4519@iucha.net>
In-Reply-To: <02022723312400.01097@dg1kfa> <E16gDhO-0006OL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gDhO-0006OL-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 27, 2002 at 11:41:26PM +0000
X-message-flag: Outlook: Where do you want [your files] to go today?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2002 at 11:41:26PM +0000, Alan Cox wrote:
> What compiler firstly, and what I/O subsystem. Are you using highmem,
> did you build from a clean tree ?

florin@bee:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4  (Debian prerelease)

00:05.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

No highmem (256Mb)

Clean tree 2.4.17 -> 2.4.18 -> 2.4.19-pre1 -> 2.4.19-pre1-ac1

Problem gone in 2.4.19-pre1-ac2, patched from clean tree, built on
2.4.18-rc2-ac1. Weird...

It looks like something is hosed in the 2.4.19-pre1-ac1 patchset.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (OpenBSD)
Comment: For info see http://www.gnupg.org

iD8DBQE8fc6wNLPgdTuQ3+QRAhl3AJ9XKb3/ZSBsiHuzD6ThV5Q+pQpCBACfZOMd
7q05AFYs7DqdAeL1lGc423Y=
=Mj7L
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
