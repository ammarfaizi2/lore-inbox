Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUAIPFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUAIPFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:05:22 -0500
Received: from [68.114.43.143] ([68.114.43.143]:18644 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S261967AbUAIPFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:05:15 -0500
Date: Fri, 9 Jan 2004 10:05:12 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: What SCSI in the IBM?
Message-ID: <20040109150512.GF24295@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



The network cards in this IBM came up great once I found the right port.
Now though I'm trying to find what SCSI driver to use.  lspci reports
"Symbios Logic unknown device (Formerly NCR)" but if I do a modprobe on=20
all 3 drivers as well as the one ncr driver no go.  All of them report
no such device except the sym53c416 which says unresolved symbol:

isapnp-find-dev.

Thoughts?


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//sMo8+1vMONE2jsRAnOfAKDIQx/VPOiZjlFgrfX3CdFNw7WW3ACeKteW
tWPoAWxeHEOXjgL1XR2QWdA=
=ctaZ
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
