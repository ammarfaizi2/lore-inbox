Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTHXCw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 22:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTHXCw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 22:52:27 -0400
Received: from [24.241.190.29] ([24.241.190.29]:2988 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S263384AbTHXCwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 22:52:24 -0400
Date: Sat, 23 Aug 2003 22:52:24 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-rc2-ac3 blew up
Message-ID: <20030824025224.GF3740@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXx4g46d83wF7unj"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LXx4g46d83wF7unj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This morning I put 2.4.22-rc2-ac3 on a mail server.  About 5 mins ago
the box blew up and we got this in a remote syslog:

Aug 23 22:04:08 mailserver1 kernel: Do you have a strange power sav ing mode enabled?
Aug 23 22:04:08 mailserver1 kernel: Uhhuh. NMI received for unknown reason 21.
Aug 23 22:04:08 mailserver1 kernel: Dazed and confused, but trying to continue

ACPI and AMP are NOT enabled.  I can attach the .config tomorrow if
someone wants it once the box is back up.  It's a 4way P3-550 with
16Gigs of RAM.  Himem and 64Gig were the compiled options as well as it
was compiled for P3.  Due to the way it locked up there wasn't anything
else we could get debug wise.  This is a production box so we had to
roll it back to the previous kernel and no-real debugging options are
available.  We do have a machine which is identicle except it is 4Gigs
of ram and instead of a raid0 of 4 disks totalling 200Gigs of space the
other machine has a single disk of 400GB.

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

--LXx4g46d83wF7unj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/SCho8+1vMONE2jsRAoeEAKC3MXC4qbxuI5J85nJPfg9RZYY+ewCghMci
iXV5pSO06unIsf6ZGJcOHQg=
=BVmp
-----END PGP SIGNATURE-----

--LXx4g46d83wF7unj--
