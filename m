Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTEZN23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTEZN23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:28:29 -0400
Received: from ns.schottelius.org ([213.146.113.242]:44675 "HELO
	schottelius.net") by vger.kernel.org with SMTP id S264375AbTEZN21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:28:27 -0400
Date: Mon, 26 May 2003 15:41:16 +0200
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [bug] 2.5.68: USB
Message-ID: <20030526134116.GE770@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.68
X-Abuse: try 'Disposition-Notification-To: dev@null.org' in your header.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When attaching usb devices to my box, no new entries in /dev/ are
created (tried with usbstick, harddisk in a box)..so I can't acces any
of them!

------------------
flapp:/usr # lsmod
Module                  Size  Used by
usb_storage            99536  0=20
scsi_mod               48132  1 usb_storage
ohci_hcd               13152  0=20
usbcore                73436  4 usb_storage,ohci_hcd
=2E..

flapp:/usr # ls /dev/usb/
=2E  ..
flapp:/usr # ls /dev/scsi/
=2E  ..

flapp:/usr # cat /proc/scsi/scsi=20
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI_ Model: DK23AA-12        Rev: 0811
  Type:   Direct-Access                    ANSI SCSI revision: 02
   =20
(which is the usb harddisk)

Or do I have to load the scsi disk driver ?

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+0hl8tnlUggLJsX0RAtobAJ9zF5wccRcQ5ziPGMl+OsoeVK72+wCdEb8G
KPJXKdWGsKsOxf6KEqKFAqo=
=1ZAz
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
