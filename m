Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271720AbTG2NJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271690AbTG2NJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:09:33 -0400
Received: from [24.241.190.29] ([24.241.190.29]:2697 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S271720AbTG2NJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:09:31 -0400
Date: Tue, 29 Jul 2003 09:09:24 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS Server running 2.6.0-test2
Message-ID: <20030729130924.GE786@rdlg.net>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030729110716.GC786@rdlg.net> <16166.25350.70923.742360@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <16166.25350.70923.742360@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



The messages file is completely empty of any error messages related to
anything disk or filesystem related from about 6 hours prior to the
error up until the time I rebooted.  In addition the actual device
(RAID5 filesystem) is intact.

Robert



Thus spake Neil Brown (neilb@cse.unsw.edu.au):

> On Tuesday July 29, Robert.L.Harris@rdlg.net wrote:
> >=20
> >=20
> > Just converted my nfs server to 2.6.0-test2 last night.  This morning I
> > found this on my console:
> >=20
> > {0}:/>
> > Message from syslogd@camel at Tue Jul 29 00:02:30 2003 ...
> > camel kernel: journal commit I/O error
> >=20
>=20
> I'm guessing that the filesystem got an I/O error when writing to the
> device.
> Anything in the kernel log that might confirm or deny this?
>=20
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JnIE8+1vMONE2jsRAqdQAKCoDF4npaTevTSccBglLXgrXnU5QwCg3x84
RaHgZWeMiWJgUC729AhQlBE=
=CvgH
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
