Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275004AbRIYN7H>; Tue, 25 Sep 2001 09:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275007AbRIYN65>; Tue, 25 Sep 2001 09:58:57 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:35128 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S275004AbRIYN6q>; Tue, 25 Sep 2001 09:58:46 -0400
Date: Tue, 25 Sep 2001 15:59:09 +0200
From: Kurt Garloff <garloff@suse.de>
To: "[A]ndy80" <andy80@ptlug.org>
Cc: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Burning a CD image slow down my connection
Message-ID: <20010925155909.J8678@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"[A]ndy80" <andy80@ptlug.org>,
	"Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de> <1001420696.1316.8.camel@piccoli>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <1001420696.1316.8.camel@piccoli>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.10 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2001 at 02:24:54PM +0200, [A]ndy80 wrote:
> Hi
>=20
> > Hmm, /dev/cdrom would typically be a link. You might try to apply hdparm
> > to where the link points to, but I cannot really believe hdparm doesn't
> > follow links.
>=20
> yes it's a link to /dev/scd0 and I CAN mount it, because my IDE cdrom is
> seen as scsi. In lilo.conf I've this line: append=3D"hdd=3Dide-scsi
> hdc=3Dide-scsi" (read CD-WRITING HOWTO for more information)

Try appending ide1=3Ddma to the boot options then. It might break on your
machine, so first try manually.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7sI2sxmLh6hyYd04RAnrDAKC0MKQYtpBdednk9sgHx+U+Aqo20gCguM3W
+xbXy/JzG9pjBgRMFleyA/g=
=Aq5e
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
