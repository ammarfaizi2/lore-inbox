Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTLDWci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLDWbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:31:49 -0500
Received: from [68.114.43.143] ([68.114.43.143]:39894 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S263637AbTLDWbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:31:17 -0500
Date: Thu, 4 Dec 2003 17:31:16 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: oomkiller in 2.4.23-bk3 gone bad
Message-ID: <20031204223116.GN16568@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Don't know about previous 2.4.23 but I'm getting this on a couple
servers that have high memory usage:

Dec  4 14:34:24 build1 kernel: VM: killing process fill
Dec  4 14:35:46 build1 kernel: VM: killing process fill
Dec  4 14:37:29 build1 kernel: VM: killing process df-checker.pl
Dec  4 14:38:03 build1 kernel: VM: killing process fill
Dec  4 14:39:27 build1 kernel: VM: killing process fill
Dec  4 14:40:28 build1 kernel: VM: killing process sh
Dec  4 14:40:33 build1 kernel: VM: killing process fill
Dec  4 14:42:35 build1 kernel: VM: killing process bash
Dec  4 14:42:35 build1 kernel: VM: killing process bash
Dec  4 14:43:13 build1 kernel: VM: killing process sh
Dec  4 14:43:14 build1 kernel: VM: killing process fill
Dec  4 14:45:41 build1 kernel: VM: killing process cron
Dec  4 14:45:42 build1 kernel: VM: killing process sh
Dec  4 14:45:43 build1 kernel: VM: killing process cron
Dec  4 14:45:48 build1 kernel: VM: killing process idle-kill
Dec  4 14:45:48 build1 kernel: VM: killing process fill
Dec  4 14:45:48 build1 kernel: VM: killing process fill
Dec  4 14:47:19 build1 kernel: VM: killing process fill
Dec  4 14:47:20 build1 kernel: VM: killing process bash
Dec  4 14:48:31 build1 kernel: VM: killing process firewall

I've also seen it kill off cron and some other server critical
root-owned processes.



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z7W08+1vMONE2jsRAmoLAJoD5lSrFvNGrMDKxCUx5L2NfWK4AgCcCLpg
LY5XIsDqvxj++H03No2nfjE=
=GhJI
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--
