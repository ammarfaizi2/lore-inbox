Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUAAWID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbUAAWHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:07:50 -0500
Received: from neveragain.de ([217.69.76.1]:14534 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S265485AbUAAWGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:06:31 -0500
Date: Thu, 1 Jan 2004 23:06:15 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: ACPI and framebuffer related problems with Linux 2.6.1-rc1
Message-ID: <20040101220615.GA1804@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm writing this mail as I'm discovering ACPI and framebuffer related probl=
ems
on my Acer TravelMate 800LCi notebook with Linux 2.6.1-rc1. First, it's goo=
d=20
to see that the synaptics-patches from -mm made it into the mainstream kern=
el,
they are necessary to make the synaptics work together with XFree here.

However, there is a problem with ACPI: /proc/acpi/processor/CPU0/performanc=
e,=20
which was there in previous versions of the kernel and allowed me to slow t=
he=20
CPU down in order to save power, disappeared in Linux 2.6.1-rc1. It's simpl=
y=20
not there anymore. Was it replaced? If so, what is the right way to do it b=
y=20
now?

Secondly, there also is a framebuffer related problem. I have VesaFB in kern
and pass 'vga=3D791' to it at boot time. However, at the time when it switc=
hed
to FB in previous versions of Linux, the screen by now simply stays black.=
=20
Is this a known problem and if so is a fix available?

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9JnXHPo+jNcUXjARAqdLAJ9UU37eixkykHPNMw/VNdEPvWFQWwCgw4kK
mLWvqFzZ6wdbw2OfPlE77qA=
=umfd
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
