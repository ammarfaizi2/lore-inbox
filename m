Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRIDWIo>; Tue, 4 Sep 2001 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269673AbRIDWId>; Tue, 4 Sep 2001 18:08:33 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:10048 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269651AbRIDWI0>; Tue, 4 Sep 2001 18:08:26 -0400
Date: Wed, 5 Sep 2001 00:08:44 +0200
From: Kurt Garloff <kurt@garloff.de>
To: David Rundle <davekern@ihug.co.nz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gcc
Message-ID: <20010905000844.W1055@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	David Rundle <davekern@ihug.co.nz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3B9541C1.5BEFE0BA@ihug.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Content-Disposition: inline
In-Reply-To: <3B9541C1.5BEFE0BA@ihug.co.nz>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2001 at 09:04:01AM +1200, David Rundle wrote:
> hi i need help i have a data struct that matchs some hardwear but=20
> gcc is alignin it this meins it is out of sync whit the hardwear=20
> like=20
> char is              2 bytes=20
> long double is 12 bytes=20
> will thats what gcc thinks=20
>=20
> so i need to tell gcc not to align the data struct=20
>=20
> may be like=20

__attribute__((packed))

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lVDsxmLh6hyYd04RAqDWAJ0SCzvhlNfFSjaJx1RHUfcUNd4geACgupcR
JbrndmmybkOsJIXQPLVvdSY=
=RiQg
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--
