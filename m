Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271688AbTHHQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271690AbTHHQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:28:20 -0400
Received: from [24.241.190.29] ([24.241.190.29]:44983 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S271688AbTHHQ2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:28:16 -0400
Date: Fri, 8 Aug 2003 12:28:13 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21-ac3 and 16Gigs of ram?
Message-ID: <20030808162813.GI8950@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



  I was building a new kernel for a production mailserver.  I took the old
config from 2.4.18 and did a "make oldconfig" in the 2.4.21-ac3.  A
couple new values, compile, install reboot and reboot and reboot, etc.

  After a good bit of recompiling it seems that enabling the 64Gig
option instead of the 4Gig causes the machine to reboot after it counts
out it's procs.

  This machine only has 4Gigs of memory but is otherwise identicle to
the production server which has 16Gigs.


Thoughts?
  Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/M8+d8+1vMONE2jsRAk/GAJ9slsshMZcFCA/0OQOtql/BLLqREgCfa6Ns
b6164De/QdN19r/i8nw0AB4=
=aIQt
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
