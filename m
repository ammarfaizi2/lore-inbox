Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTIRScX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTIRScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:32:23 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:17810 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S262057AbTIRScS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:32:18 -0400
Date: Thu, 18 Sep 2003 20:32:15 +0200
From: Jasper Spaans <jasper@vs19.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Message-ID: <20030918183215.GA14375@spaans.vs19.net>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net> <Pine.LNX.4.56.0309181518090.10528@jju_lnx.backbone.dif.dk> <20030918084011.5ac7be61.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20030918084011.5ac7be61.rddunlap@osdl.org>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
Keywords: USDOJ Perl-RSA assassination gamma tempest 9705 Samford Road S Box AVN 
User-Agent: Mutt/1.5.4i
X-SA-Exim-Rcpt-To: rddunlap@osdl.org, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: Re: IA32 - 27 New warnings
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2003 at 08:40:11AM -0700, Randy.Dunlap wrote:

> Bart (IDE maintainer) has already posted patches for this.
> See
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106329427503487&w=3D2

Which seems to invert some logic -- from the patch:

-                       return setup_pdc4030(hwif);
+                       if (!setup_pdc4030(hwif))
+                               return -ENODEV;
+                       return 0;

(I cannot find any changes to setup_pdc4030() in that changeset)

VrGr,
--=20
Jasper Spaans                http://jsp.vs19.net/
 18:46:22 up 9710 days,  9:33, 0 users, load average: 12.80 10.76 10.63

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/afov1Bo4HffkuxYRAl8oAJwKC0AsXPHPCeMpTTxh04KMuMhKoQCgsb9V
yMr+ExobhY+j3DZBemDMQSU=
=8gbA
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
