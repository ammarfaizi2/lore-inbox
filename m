Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVH3KT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVH3KT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVH3KT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:19:56 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:26772 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751212AbVH3KTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:19:55 -0400
Date: Tue, 30 Aug 2005 12:19:59 +0200
From: Harald Welte <laforge@gpl-violations.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050830101958.GJ4202@rama.de.gnumonks.org>
References: <20050830085522.GA8820@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20050830085522.GA8820@midnight.suse.cz>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 10:55:22AM +0200, Vojtech Pavlik wrote:
> Hi!
>=20
> The D-Link DWL-G730AP devices from the Kernel Summit run Linux, And it's
> likely a GPL violation, too, since sources are nowhere to be found.

*lol*. Interestingly they must have twiddled the IP stack since when I
tried an "nmap" on the device, it didn't recognize it as a Linux TCP/IP
stack.

> They're based on a Marvell Libertas AP-32 (ARM9) design, similar
> to the ASUS WL-530g. A bootlog from the ASUS (which has telnet enabled
> for some reason, and thus can be logged in) is at the end of the mail.

So you grabbed that bootlog from the ASUS device, or from the D-Link?

If it is from the ASUS, what makes you think that the D-Link runs the
same OS?  It is quite often the case that one chipset design has
multiple operating systems ported to it (you see systems with the same
broadcom or Intersil chipset, one running Linux, the other VxWorks).

Please indicate how you came to the conclusion that the D-Link really
runs Linux.

> A firmware image is available from D-Link
> (ftp://ftp.dlink.com/Wireless/dwlg730AP/Firmware/dwlg730ap_firmware_100.b=
in),
> and it seems to be composed of compressed blocks padded by zeroes. I have=
n't
> verified yet that it's indeed a compressed kernel, cramfs, etc, but it se=
ems
> quite likely.

I'm downloading it right now, and I'll see whether I can find any Linux
in there.

> Anyone interested in dissecting it, and pushing D-Link/Marvell to release
> the kernel sources?=20

Sure, it's (unfortunately) not the first time I'm dealing with D-Link on
their GPL [in]compliance :((

> I'd love to get more out of this cute device ...

If the design really is identical enough to the ASUS device, then I
suggest looking into
http://dlsvr02.asus.com/pub/ASUS/wireless/WL-530g/GPL_1825.zip

Cheers,
--=20
- Harald Welte <laforge@gpl-violations.org>       http://gpl-violations.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFDLOXaXGVTD0i/8RAuRoAJ97jdtfZRSKclGbgYnv7Ak/q+zL7QCcCxHG
JfRJPX4Jh3A9QeTr3Z9wXJw=
=vQ+U
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
