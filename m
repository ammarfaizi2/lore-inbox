Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946695AbWKJOtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946695AbWKJOtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946694AbWKJOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:49:45 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:30364 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1946695AbWKJOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:49:44 -0500
Date: Fri, 10 Nov 2006 15:49:40 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: scary messages: HSM violation during boot of 2.6.18/amd64
Message-ID: <20061110144940.GA14232@lapse.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
X-OS: Debian GNU/Linux 4.0 kernel 2.6.18-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I just upgraded my workstation to 2.6.18.2. It has four SATA
drives in a RAID10, connected to the system in pairs on Promise and
Via on-board controllers.

Now on every boot, I see several messages like this for the drives
connected to the VIA controller (VT6420):

  ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)

What do these mean?

Also, for the first of the two drives on the Promise/FastTrak
PDC20378 controller, I see messages like this:

  ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00

What about those?

I saw none of that under 2.6.17.x. Should I be worried?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
the unix philosophy basically involves
giving you enough rope to hang yourself.
and then some more, just to be sure.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVJGEIgvIgzMMSnURAs/8AKCqCqZhnS1SYpKL9CWyu2Vqf+KpgACdFOyX
EmbUTjxGgirpOSl0RsBgSIQ=
=6cHv
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
