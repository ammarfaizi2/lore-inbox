Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUAEMoD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUAEMoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:44:03 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:2803 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264451AbUAEMnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:43:53 -0500
Date: Tue, 06 Jan 2004 01:39:28 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: udev and devfs - The final word
In-reply-to: <200401051201.58356.roro.l@dewire.com>
To: Robin Rosenberg <roro.l@dewire.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073306368.4181.103.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-iLyug6VwGGuTbDfkpXQM";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <m31xqedelx.fsf@lugabout.jhcloos.org> <1073288725.2385.70.camel@laptop-linux>
 <200401051201.58356.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iLyug6VwGGuTbDfkpXQM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

The suspend to disk implementations all assume that devices are not
[dis]appearing under us while we're suspended. If you do go adding and
removing devices while the power is off, you can expect the same
problems you'd get if you removed them without suspending the machine.
It would be roughly equivalent to hot[un]plugging devices.

To return to the original point though, userspace may see a sudden big
jump in the time clock if it's looking, but it won't suddenly find major
& minor numbers are different.

Regards,

Nigel

On Tue, 2004-01-06 at 00:01, Robin Rosenberg wrote:
> > Yes. You end up running the original kernel.
>=20
> But not necessarily the same devices.

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-iLyug6VwGGuTbDfkpXQM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+VsAVfpQGcyBBWkRAicBAKCGrYIbFJrbvjNz921lTLmlx1HujACfYqaW
isOFmwMJ7cKPSKQgacLHnFo=
=TBG8
-----END PGP SIGNATURE-----

--=-iLyug6VwGGuTbDfkpXQM--

