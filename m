Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbRAUSEG>; Sun, 21 Jan 2001 13:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRAUSD4>; Sun, 21 Jan 2001 13:03:56 -0500
Received: from mail-smtp.socket.net ([216.106.1.32]:4623 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131245AbRAUSDo>; Sun, 21 Jan 2001 13:03:44 -0500
Date: Sun, 21 Jan 2001 12:05:12 -0600
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.0 CDROM problem, ILLEGAL REQUEST
Message-ID: <20010121120512.A22848@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux glitch 2.4.0 #1 SMP Mon Jan 15 20:34:07 CST 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When playing audio CDs under kernel 2.4.0, syslog is showing the
following message repeatedly:

     sr0: CDROM (ioctl) reports ILLEGAL REQUEST.

The command line utility cdplay seems to only cause this occasionally,
when I start playing a CD or skip to a different track, while gnome's
gtcd will generate it every few seconds... presumably gtcd is regularly
querying the drive.

I'm pretty sure that this wasn't occurring under the 2.4.0-testX
kernels, but I haven't verified this as they aren't currently
installed.

The system is a dual PIII 600 (i840) with 512MB.  The CDROM is an
internal Plextor PX-20TS, connected to an Adaptec 2940UW (PCI).  SCSI
support (including the aic7xxx driver) is compiled directly into the
kernel, while CDROM support is built as a module.  The only kernel
patch applied is version 2.4.0.3 of the crypto patch from
<http://www.kernel.org/pub/linux/kernel/crypto/v2.4/>.

Suggestions and/or pointers would be most appreciated.  Thanx!

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ayTYgrEMyr8Cx2YRAqDNAJ9KuO7XgpjI4zV/DESOonjclIYbHgCfaeA7
dLJqipR02UxPwUi/qnSiD9w=
=pcIY
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
