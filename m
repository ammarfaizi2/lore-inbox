Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUCKMbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUCKMbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:31:06 -0500
Received: from 68-184-155-122.cpe.ga.charter.com ([68.184.155.122]:61965 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261215AbUCKMbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:31:01 -0500
Date: Thu, 11 Mar 2004 07:31:00 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: NVIDIA and 2.6.4?
Message-ID: <20040311123100.GE17760@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I'm trying to use the NVIDIA driver so I can play NWN and some other
games which won't run with the stock XFree (xserver-xfree86_4.3.0-5)=20
driver.  When I run "make" in the NVIDIA_kernel directory I get alot of
undefined variables:

/lib/modules/2.6.4/build/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' un=
declared here (not in a function)
/lib/modules/2.6.4/build/include/asm/mpspec.h:20: error: conflicting types =
for `mp_bus_id_to_type'
/lib/modules/2.6.4/build/include/asm/mpspec.h:8: error: previous declaratio=
n of `mp_bus_id_to_type'
/lib/modules/2.6.4/build/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' =
undeclared here (not in a function)
/lib/modules/2.6.4/build/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' un=
declared here (not in a function)
/lib/modules/2.6.4/build/include/asm/mpspec.h:24: error: conflicting types =
for `mp_bus_id_to_pci_bus'
/lib/modules/2.6.4/build/include/asm/mpspec.h:12: error: previous declarati=
on of `mp_bus_id_to_pci_bus'
/lib/modules/2.6.4/build/include/asm/mpspec.h:50: error: `MAX_APICS' undecl=
ared here (not in a function)

And that's just for starters.  Does anyone know if there's a way to get
this to compile cleanly or is it SoL until a new driver is released
(running 1.0.4191 currently).

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUFwE8+1vMONE2jsRAqOKAJ9nqocO43+LxM/4o5E8iSuCOxtZAQCfehhx
BSlAwZr9Bk/pewg9uDx8oCQ=
=yCSD
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
