Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWBTQ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWBTQ7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWBTQ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:59:23 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:47515 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S1161037AbWBTQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:59:22 -0500
Date: Mon, 20 Feb 2006 18:00:26 +0100
From: Matthias =?ISO-8859-1?Q?Bl=E4sing?= 
	<matthias.blaesing@rwth-aachen.de>
Subject: Re: ieee1394 failed to work after S3 resume.
In-reply-to: <43F9E70C.5030809@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Subodh Shrivastava <subodh.shrivastava@gmail.com>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       bcollins@debian.org, scjody@modernduck.com
Message-id: <1140454826.30310.6.camel@prometheus.glx>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: multipart/signed; boundary="=-k+U75p5ywzBg/4raaNlE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <8b12046a0602191137n12997938kd8404814f7c8e2ba@mail.gmail.com>
 <43F9E70C.5030809@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k+U75p5ywzBg/4raaNlE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am Montag, den 20.02.2006, 16:58 +0100 schrieb Stefan Richter:
> Subodh Shrivastava wrote:
> > Suspend to Ram works fine here with 2.6.16-rc3 kernel except ieee1394
> > fails to resume properly.
> ...
> [SCSI command timeout in sbp2 after resume; no nodemgr updates after resu=
me]
> ...
>=20
> [
>  I could perhaps look into it in late spring or summer.


A workaround till then is the usage of a script (I use hibernate and
have blacklisted ohci1394), that unloads ohci1394 prior to suspending
and reloading the module after resume.

HTH

Matthias

--=20
Matthias Bl=E4sing (GPG-Schl=FCsselkennung: A71B4BD5)
ICQ: 84617206   AIM: linuxfun81   MSN: linuxfun@hotmail.com

--=-k+U75p5ywzBg/4raaNlE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD+fWpwuNy6qcbS9URAo8vAKCBWBa16IAPg90b19KftFzElBAkpgCfXTxM
L7Hg648nS6+sP5LQIrv4aMk=
=RnZq
-----END PGP SIGNATURE-----

--=-k+U75p5ywzBg/4raaNlE--


