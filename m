Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTICVUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTICVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:20:43 -0400
Received: from [24.241.190.29] ([24.241.190.29]:9132 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264359AbTICVUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:20:39 -0400
Date: Wed, 3 Sep 2003 17:20:38 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: nmi errors?
Message-ID: <20030903212038.GQ7353@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Can anyone tell me what this is?

16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason 31.
16:00:09 mailserver kernel: Dazed and confused, but trying to continue
16:00:09 mailserver kernel: Do you have a strange power saving mode enabled?
16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason 21.
16:00:34 mailserver kernel: Dazed and confused, but trying to continue

A coworker put a script on a server which loads up quite afew arrays
with pre-set values and then compares the values against arrays.  As soon a=
s he=20
kicked off the script I got alot of these in my log files.  Not much longer=
 and the=20
machine crashed hard.

Quad proc P3-550
16Gigs of RAM
Kernel: 2.4.22-rc2-ac3

CONFIG_HIGHMEM64G=3Dy
CONFIG_HIGHMEM=3Dy

Anyone have any thoughts or know what this means?  Do I have a HIGHMEM
problem?

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Vlsm8+1vMONE2jsRAruuAJ9NhjXfLoPAeg8P8BmOh1BndQCiOgCfTL2t
DDRmihuL1pv+baarN2atEg8=
=dVZC
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
