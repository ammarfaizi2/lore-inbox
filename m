Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSBKI4r>; Mon, 11 Feb 2002 03:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbSBKI4i>; Mon, 11 Feb 2002 03:56:38 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:10768 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S287631AbSBKI43>;
	Mon, 11 Feb 2002 03:56:29 -0500
Date: Mon, 11 Feb 2002 12:00:21 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager
Message-ID: <20020211090021.GA8012@pazke.ipt>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202081825.g18IPSf03107@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <200202081825.g18IPSf03107@localhost.localdomain>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

can you please explain, what does this config.in fragment mean:

if [ "$CONFIG_VISWS" !=3D "y" ]; then
   bool 'MCA support' CONFIG_MCA
   if [ "$CONFIG_MCA" =3D "y" ]; then
	bool '   Support for the NCR Voyager Architecture' CONFIG_VOYAGER
	define_bool CONFIG_X86_TSC n
   fi
else
   define_bool CONFIG_MCA n
fi

How MCA and NCR Voyager support related to SGI Visual Workstations support
(CONFIG_VISWS) ?

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Z4gkBm4rlNOo3YgRAuEsAJ9tkhTwIsv+XDCyDq/sx4Q1pR6fJACfQfan
JyPkNcZme9grqPPFgpx/gT0=
=MSBq
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
