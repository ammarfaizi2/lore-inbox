Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSGZQvL>; Fri, 26 Jul 2002 12:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSGZQvL>; Fri, 26 Jul 2002 12:51:11 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:22883 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317849AbSGZQvJ>; Fri, 26 Jul 2002 12:51:09 -0400
Date: Fri, 26 Jul 2002 18:54:11 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alexander Viro <viro@math.psu.edu>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Fri, Jul 26, 2002 at 12:45:41PM -0400, Alexander Viro wrote:
> On Fri, 26 Jul 2002, Kurt Garloff wrote:
> > The patches are all available at
> > http://www.suse.de/~garloff/linux/scsi-many/
>=20
> As long as you realize that it won't go in 2.5 in that form...

The sd parts can and should be ported to 2.5, I think.
The /proc/scsi/scsi extensions and other stuff I wrote to support it,=20
won't be needed, as we have driverfs in 2.5.
And, of course, the device number management will be solved in a more
general way, but I do not yet see how.=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QX6zxmLh6hyYd04RAh9EAJsGWbSklVEHhX5rVdXKuvr3RBxSQQCcDX9b
EZqUgwpVP+k/zVMsel8PJkk=
=AkXg
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
