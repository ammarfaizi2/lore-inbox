Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268935AbTCARM3>; Sat, 1 Mar 2003 12:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268937AbTCARM3>; Sat, 1 Mar 2003 12:12:29 -0500
Received: from r35h118.res.gatech.edu ([128.61.35.118]:14210 "EHLO
	mail.overcode.net") by vger.kernel.org with ESMTP
	id <S268935AbTCARM2>; Sat, 1 Mar 2003 12:12:28 -0500
Date: Sat, 1 Mar 2003 12:22:51 -0500
From: fauxpas@temp123.org
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IOAPIC on Via KT266a
Message-ID: <20030301172251.GA30143@temp123.org>
References: <20030227165248.GA12030@temp123.org> <15967.28629.35699.473056@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <15967.28629.35699.473056@gargle.gargle.HOWL>
X-GPG-Key: http://temp123.org/~fauxpas/fauxpas.pgp
X-GPG-Fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2003 at 03:19:01PM +0100, Mikael Pettersson wrote:

> This is almost certainly a hardware problem: your machine's APIC bus
> is corrupting messages, or some other agent than the CPU is creating
> corrupt messages. This isn't exactly unheard of for non-Intel chipsets.

Hmmm... windows seems to have a workaround for at least part of the
problem, I spent the last day trying to confuse the APIC unsuccessfully
on that system.  Could it be a problem with the uhci driver perhaps?
The only two persistant symptoms are the usb failure and the slew of=20
messages.

The APIC errors I receive are mostly 02(02) but a good deal of
02(01), 01(02) and 01(01).  Checksum errors galore.

This only happens with IO-APIC is enabled throughout:

hub.c: new USB device 00:11.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3D2 (error=3D-110)
hub.c: new USB device 00:11.2-1, assigned address 3
b.c: USB device not accepting new address=3D3 (error=3D-110)
hub.c: new USB device 00:11.2-2, assigned address 4
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3D4 (error=3D-110)
hub.c: new USB device 00:11.2-2, assigned address 5
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3D5 (error=3D-110)

--=20
Josh Litherland (fauxpas@temp123.org)

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+YOxrBrTD/Ik9kigRAu/WAJ9Cf6SgEbf+yjj+JduqRTmhsfXZGgCdGXzc
Q46j30DDAVe1SpjjrT4EMNQ=
=6fEr
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
