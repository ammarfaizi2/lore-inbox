Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRCVRIR>; Thu, 22 Mar 2001 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRCVRII>; Thu, 22 Mar 2001 12:08:08 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:57912 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132101AbRCVRH4>; Thu, 22 Mar 2001 12:07:56 -0500
Date: Thu, 22 Mar 2001 18:05:28 +0100
From: Kurt Garloff <garloff@suse.de>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting post from the MC project to linux-kernel. :block while spinlock held...
Message-ID: <20010322180528.B6264@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ishikawa <ishikawa@yk.rim.or.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <3AB8E3E8.F3204180@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB8E3E8.F3204180@yk.rim.or.jp>; from ishikawa@yk.rim.or.jp on Thu, Mar 22, 2001 at 02:24:56AM +0900
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2001 at 02:24:56AM +0900, Chiaki Ishikawa wrote:
> --- begin quote ---
> > enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> > called with either interrupts disabled or a spin lock held. The
> > checker works by:
>=20
> Here's the file manifest. Apologies.
>=20
> drivers/atm/idt77105.c
> drivers/atm/iphase.c
> drivers/atm/uPD98402.c
> drivers/block/cciss.c
> drivers/block/cpqarray.c
> drivers/char/applicom.c
>     ...
> drivers/scsi/aha1542.c            <--- some scsi files
> drivers/scsi/atp870u.c             <----
> drivers/scsi/psi240i.c               <----
> drivers/scsi/sym53c416.c        <----
> drivers/scsi/tmscsim.c              <----
  ^^^^^^^^^^^^^^^^^^^^^^
 =20
How do I fond about about details?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ujDXxmLh6hyYd04RAkpsAJ9/KPl6Vvy1QxqD05v398u/k5n95wCgj44b
DVcZC1TO9dWWX+n6xC+5akE=
=5lDk
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
