Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTLWTYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLWTYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:24:46 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:39310 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S262425AbTLWTYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:24:36 -0500
Date: Tue, 23 Dec 2003 14:24:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 and Compaq Proliant 6500 Pentium Pro
Message-ID: <20031223192428.GA2616@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E1AYejy-0003ut-1z@beorn.cosoftwareshop.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <E1AYejy-0003ut-1z@beorn.cosoftwareshop.com>
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2003 at 10:05:54PM -0700, Don t Spam Me!!! wrote:
>=20
> Hi,
>=20
>      I was successfully running the latest RedHat 9 kernel (2.4.20-smp)=
=20
> and upgraded to Fedora Core stable(2.4.22-nptlsmp) and testing
> (2.6.0smp).  The 6500 has an Orion (82450KX) chipset.  During bootup, I=
=20
> receive a number of error messages.  Among other things:

    Hmm, my Quad PPro Proliant 5000 has been working fine with 2.6
kernels, but it's an older model of course.  I'm still learning about
these Compaqs.  Same chipset though.

> 1)   The system is a quad processor PPro, but it says "no smp detected"
> 2)   I get two ACPI errors (ACPI-0084 and ACPI-0134)

    I think I can safely say the two ACPI errors mean your 6500 doesn't
support ACPI, which doesn't surprise me.

    I wonder if booting with acpi=3Doff might fix both (1) and (2)?
I know there are two methods of detecting and setting up SMP, one via
ACPI.  I think it's supposed to fall back to the older MPS SMP stuff
but Compaqs are weird.  I've built my own kernels since day one with
ACPI off and never had this problem.

    I haven't looked, but I'd guess that the difference between the
RH9 kernel and the Fedora 2.4 kernel is the new ACPI stuff too.

> 3)   The kernel cannot determine the bus topology, and kudzu asks me to=
=20
> reconfigure my two ethernet cards everytime I boot

    What do you mean by 'cannot determine the bus topology'?  Are you
getting an error message?  Does this occur with both 2.6
and 2.4.22-blah?

    If turning ACPI off too doesn't fix all this, a copy of your dmesg
output would probably be helpful.  I beat my 5000 into submission, so
maybe I can help.

--=20
Joseph Fannin
jhf@rivenstone.net


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6JZsWv4KsgKfSVgRAlYzAJ9H+nq9r6pCWMhw68LQAIOTfiyergCcDvZ9
VShZZTuA4iGoFWYZLLSGACQ=
=t0ns
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
