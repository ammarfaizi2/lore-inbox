Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSATDO7>; Sat, 19 Jan 2002 22:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287863AbSATDOt>; Sat, 19 Jan 2002 22:14:49 -0500
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:24500
	"EHLO mail.jukie.net") by vger.kernel.org with ESMTP
	id <S287862AbSATDOj>; Sat, 19 Jan 2002 22:14:39 -0500
Date: Sat, 19 Jan 2002 22:14:28 -0500
From: Bart Trojanowski <bart@jukie.net>
To: Kallol Biswas <kallol@efi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C source lines for assembly listing
Message-ID: <20020119221428.O18844@jukie.net>
In-Reply-To: <Pine.LNX.4.40L0.0201170137380.32025-100000@karma.oltrelinux.com> <3C462ACD.5F61BFDC@efi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C462ACD.5F61BFDC@efi.com>; from kallol@efi.com on Wed, Jan 16, 2002 at 05:37:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Kallol Biswas <kallol@efi.com> [020116 20:35]:
> Hi,
>      Does gcc have an option to list the C source line information for
> assembly instructions?

I am not sure what you are asking for... but I will give it a shot. ;)

One of the tools that comes with the package binutils is called objdump.

If you compile your source with -g flag then you can use objdump to
display mixed assembly and C source code.

	gcc -g foo.c -o foo.o
	objdumpt -S foo.o

I hope this helps.

B.

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8SjYUkmD5p7UxHJcRAmPsAJ42VqzefU83dBiQp1citwyl82tnvwCZATR6
fF3vkYcLO7h6mropR7jW30k=
=wX45
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
