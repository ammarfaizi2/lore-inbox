Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136742AbREAWEq>; Tue, 1 May 2001 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREAWEh>; Tue, 1 May 2001 18:04:37 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:55044 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S136739AbREAWEV>; Tue, 1 May 2001 18:04:21 -0400
Date: Wed, 2 May 2001 00:03:37 +0200
From: Kurt Garloff <garloff@suse.de>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OnStream USB
Message-ID: <20010502000337.F8785@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010501145859.A28980@sin.sloth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010501145859.A28980@sin.sloth.org>; from geoffeg@sin.sloth.org on Tue, May 01, 2001 at 02:58:59PM -0400
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2001 at 02:58:59PM -0400, Geoffrey Gallaway wrote:
> I see that the SCSI version of the drive seems to be supported in linux
> but I can only find tidbits of information that don't confirm or deny
> this. Listed below are two sites that have some information which seem=20
> to confirm that the drive does indeed work, but I simply want to be=20
> sure.

The README on the webpage has been updated finally.
Compile usb-storage with Freecom support, load it and osst.=20
Access the device via /dev/(n)osst0. Use a blocksize of 32k.
(pipe over buffer -s 32k or use tar -b 64, see README.)
Newer versions of osst overcome this block size limitation, but those=20
have not yet been merged to the mainstream kernel.
If you find trouble, please also report to osst@linux1.onstream.nl.

Enjoy!
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67zK4xmLh6hyYd04RAlxlAJ46wxYbyne3xGO7KbHP0aWWroUg8ACfdPT6
cvOmHtckHNdypZbvb/f/jFQ=
=Eui/
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
