Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbTFEQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTFEQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:17:09 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:47514 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S264734AbTFEQRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:17:07 -0400
Date: Thu, 5 Jun 2003 12:30:36 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDRW and ide-scsi fun?
Message-ID: <20030605163036.GF8594@rdlg.net>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030605160440.GE8594@rdlg.net> <20030605162328.GA3351@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20030605162328.GA3351@werewolf.able.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



No I didn't.  Didn't know it needed that as the device appeared in
/proc/scsi/scsi just fine, cdrecord just couldn't find it.


Thus spake J.A. Magallon (jamagallon@able.es):

>=20
> On 06.05, Robert L. Harris wrote:
> >=20
> >=20
> > I have a DVD-CDRW:
> >=20
> > 'SONY    ' 'DVD RW DRU-510A ' '1.0a' Removable CD-ROM
> >=20
> > If I compile ide-cd and ide-scsi into the kernel I can see the drives
> > but cdrecord doesn't recognize them, even if I specify the device (2,0,=
0).
> > If I compile either one in and modularize the other I get the same
> > thing.  If I modularize both and then load them:
> >=20
> > modprobe ide-scsi
> > modprobe ide-cd
> >=20
> >=20
>=20
> Obvious question, have you tried to boot with 'hdc=3Dide-scsi' ?
> (for both builtin, ide has preference...)
>=20
> --=20
> J.A. Magallon <jamagallon@able.es>      \                 Software is lik=
e sex:
> werewolf.able.es                         \           It's better when it'=
s free
> Mandrake Linux release 9.2 (Cooker) for i586
> Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+33As8+1vMONE2jsRAnBtAJ9Svvuu+YuKhRTAcisa+iRKLjuHcgCfV+FY
JHhAHAym8yq79lnLMlZ2EnM=
=9G8g
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
