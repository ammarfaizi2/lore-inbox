Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131997AbRBFBU1>; Mon, 5 Feb 2001 20:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131893AbRBFBUS>; Mon, 5 Feb 2001 20:20:18 -0500
Received: from mail-smtp.socket.net ([216.106.1.32]:29958 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132158AbRBFBTw>; Mon, 5 Feb 2001 20:19:52 -0500
Date: Mon, 5 Feb 2001 19:22:35 -0600
From: "Gregory T. Norris" <haphazard@socket.net>
To: axboe@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010205192235.A1567@glitch.snoozer.net>
Mail-Followup-To: axboe@suse.de,
	linux-kernel <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux glitch 2.4.1 #1 SMP Fri Feb 2 18:11:24 CST 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15 2001, Jens Axboe wrote:                =20
> Could you try with this patch, so maybe we can get some hints as to =20
> what is going on?

Here's what I got after applying your patch to 2.4.1:

----- SNIP -----
Feb  5 17:25:26 glitch kernel: VFS: Disk change detected on device sr(11,0)
Feb  5 17:25:26 glitch kernel: VFS: Disk change detected on device sr(11,0)
Feb  5 17:25:26 glitch kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Feb  5 17:25:26 glitch kernel: Mode Sense (10) 00 0e 00 00 00 00 00 18 00=
=20
Feb  5 17:25:26 glitch kernel: [valid=3D0] Info fld=3D0x0, Current sr00:00:=
 sense key Illegal Request
Feb  5 17:25:26 glitch kernel: Additional sense indicates Invalid command o=
peration code
----- SNIP -----

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6f1HbgrEMyr8Cx2YRAjuoAJ91JMPOFWvtDC2VuLLcx2b5EHqMPgCbBBy5
GvpCo+USVaa2eLUHWH2hDco=
=B5Fz
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
