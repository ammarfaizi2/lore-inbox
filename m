Return-Path: <linux-kernel-owner+w=401wt.eu-S937341AbWLKQ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937341AbWLKQ66 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936333AbWLKQ65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:58:57 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:2781 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937341AbWLKQ64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:58:56 -0500
Message-ID: <457D8E35.9050706@imap.cc>
Date: Mon, 11 Dec 2006 17:58:29 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Corey Minyard <cminyard@mvista.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com> <20061211102016.43e76da2@localhost.localdomain>
In-Reply-To: <20061211102016.43e76da2@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5FED70519E560178E0B0D693"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5FED70519E560178E0B0D693
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2006 10:20:16 +0000, Alan wrote:
> This looks wrong. You already have a kernel interface to serial drivers=
=2E
> It is called a line discipline. We use it for ppp, we use it for slip, =
we
> use it for a few other things such as attaching sync drivers to some
> devices.

I was under the impression that line disciplines need a user space
process to open the serial device and push them onto it. Is there
a way for a driver to attach to a serial port through the line
discipline interface from kernel space, eg. from an initialization,
module load, or probe function?

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig5FED70519E560178E0B0D693
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfY41MdB4Whm86/kRAtrLAJ9wacG36Ydk1OsrwI7di97LZhYvFwCeI8pb
B8tRHDr9hF8/zwEMCuk+SxE=
=Yd6s
-----END PGP SIGNATURE-----

--------------enig5FED70519E560178E0B0D693--
