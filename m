Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131685AbQK2SpC>; Wed, 29 Nov 2000 13:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131919AbQK2Som>; Wed, 29 Nov 2000 13:44:42 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:58118 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S131685AbQK2Sok>; Wed, 29 Nov 2000 13:44:40 -0500
Date: Wed, 29 Nov 2000 19:14:02 +0100
From: Kurt Garloff <kurt@garloff.de>
To: --Damacus Porteng-- <kernel@bastion.yi.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
Message-ID: <20001129191402.F5891@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
        --Damacus Porteng-- <kernel@bastion.yi.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001129130616.A4879@bastion.sprileet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001129130616.A4879@bastion.sprileet.net>; from kernel@bastion.yi.org on Wed, Nov 29, 2000 at 01:06:16PM -0600
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2000 at 01:06:16PM -0600, --Damacus Porteng-- wrote:
> Problem:
> 	The problem lies with using my EIDE CDRW - I set it up properly using
> 	IDE-SCSI.  I can use my mp3tocdda shell script to encode mp3s to CD
> 	(uses cdrecord as well) on the fly using either drive, however, when I
> 	use cdrecord to write a data CD, the system hard-locks, no kernel
> 	panic messages, and no Magic SysRQ keystroke works. =20
>=20
> 	Quite odd that I could do the cdrecord for audio tracks, but not
> 	data..

Strange. If you read data from the harddisk on an IDE channel and write it
(with cdrecord) to some CDRW on the same IDE channel, you have to expect
trouble: As with IDE there is no disconnect from the bus (as opposed to
SCSI), you risk buffer underruns.=20
A lockup however is not to be expected :-(

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JUdpxmLh6hyYd04RAm7sAKCHZm6sWgjpCJI2NLwwYwBAITQqsQCeIyqa
Xhtf7FmCeWbKOPqB24R/CPg=
=AbM7
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
