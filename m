Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTJGQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTJGQO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:14:59 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:19372 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S262461AbTJGQOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:14:54 -0400
Date: Tue, 7 Oct 2003 12:14:50 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007161450.GF1223@rdlg.net>
Mail-Followup-To: Andreas Jellinghaus <aj@dungeon.inka.de>,
	linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NpJxosW6I2mTcxQ7"
Content-Disposition: inline
In-Reply-To: <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NpJxosW6I2mTcxQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I use /dev/ide and /dev/scsi currently.  I also like how I can use
"/dev/cdrom" which is a link to my IDE CDROM on one machine and my SCSI
CDROM on my file server.  Tack that in with /dev/md0 which appears of
it's own accord when I forget to make the dev but do make the raid
device.




Thus spake Andreas Jellinghaus (aj@dungeon.inka.de):

> On Tue, 07 Oct 2003 14:26:07 +0000, Robert L. Harris wrote:
> > I just hope udev can give a look/feel similar to devfs as I have quite a
> > few machines already in production configured for devfs and really like
> > the manageablility.
>=20
> I wonder: do you use the /dev/disc/* links, or the /dev/ide/... and
> /dev/scsi/... constructs? I'm not sure how udev will be able to=20
> support both layouts.
>=20
> Also: do you prefer a devs compatible layout, or maybe use the change
> for a cleanup? a short list of obscurities: /dev/cdroms/cdrom0 but
> /dev/printers/0 and /dev/tts/0 and /dev/floppy but /dev/discs etc. also
> all floppy devices are in /dev/floopy, where each disc has is
> /dev/discs/discN directory/symlink. I think it's a good opportunity
> for a cleanup, but that wouldn't be compatible...
>=20
> Regards, Andreas
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--NpJxosW6I2mTcxQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/guZ68+1vMONE2jsRAgckAJ9HkD99e9QeXO7DO0Sj5zJtyqUfyACfS5nz
sQDQTbqkFljV+8PKGmP0gwE=
=UaPj
-----END PGP SIGNATURE-----

--NpJxosW6I2mTcxQ7--
