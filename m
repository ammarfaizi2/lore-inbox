Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbTACLjX>; Fri, 3 Jan 2003 06:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbTACLjX>; Fri, 3 Jan 2003 06:39:23 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:48874 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S267501AbTACLjV>; Fri, 3 Jan 2003 06:39:21 -0500
Date: Fri, 3 Jan 2003 11:47:50 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: SCSI recommends rewrite -- how?
Message-ID: <20030103114750.GC23444@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Hi,

   I've been getting the following error message turn up in my syslogs
at irregular intervals (a couple a week):

Jan  3 06:29:37 vlad kernel: Info fld=0x49c21c, Current sd08:18: sense key Recovered Error
Jan  3 06:29:37 vlad kernel: Additional sense indicates Recovered data without ecc - recommend rewrite

   The Info fld=... value changes.

   Two questions:

 - If I read Documentation/devices.txt correctly, this would appear to
   be the second SCSI disk, second [primary] partition. This is a
   problem, since that partition doesn't exist -- there's a single
   primary partition on that drive, containing 4 logical partitions.

 - Secondly, how can I identify the relevant bit of the disk that
   wants rewriting? Is the fld=0x... the offset on the drive, or the
   partition, or what?

   Thanks,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
       --- Never underestimate the bandwidth of a Volvo filled ---       
                           with backup tapes.                            

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+FXhmssJ7whwzWGARAoNJAJwKvgs55ngU0hhVr3Cyxjr7YlcV2QCfa98W
5QG7HMwoawV+drfO4gU4Htk=
=8mn/
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
