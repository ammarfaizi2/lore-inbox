Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbTH2OQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTH2OQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:16:25 -0400
Received: from [24.241.190.29] ([24.241.190.29]:47238 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S261238AbTH2OQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:16:21 -0400
Date: Fri, 29 Aug 2003 10:16:19 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ext2 -> ext3 on the fly?
Message-ID: <20030829141619.GA12564@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have a number of servers which are currently mounting /usr as ext2.  I=20
have a means of doing an tune2fs -j on all of them remotely en mass but
I'd rather not reboot them all to enable journaling on machines that are
up and not having issues.  I've tried to do a:

mount -t ext3 -o remount /usr

as well as just a mount -o remount after changing the fstab.

on a test box but it just blows out a usage message.  Is there a way to
do this remount without a complete reboot that'll be transparant to
users?


If not, is it dangerous to tune2fs the filesystems, change the fstab and
then leave the box up for 2-6 months and let them reboot through
atrrition, upgrades, etc?

Current kernel is 2.4.21-ac3, getting outages and upgrades is a rather
long process involving regression testing, etc.

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

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/T2Az8+1vMONE2jsRAkELAJ9hlP4rAxtjagcTea1H9jXvxWNmoQCgm7it
8aM0oXu0z5HubEeJAmB/Rco=
=otdo
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
