Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTIVSC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTIVSC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:02:58 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:37546 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261353AbTIVSC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:02:56 -0400
Date: Mon, 22 Sep 2003 14:02:54 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Freeswan 2.02 + 2.4.22-bk22 problem
Message-ID: <20030922180254.GC28020@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I'm trying to buildout a 2.4.22-bk22 + freeswan 2.02 setup to replace a
system vulnerable to the ptrace exploit.  Downloaded the sources,
patched and built it with the "make oldgo" since the kernel was
configured right otherwise (no modules, all compiled in).  Installed my
binaries and the new kernel and rebooted.

It looks very happy execpt if I do a "ifconfig ipsec0 down".  This will
hang up and never go away, a reboot is required to clear it.  No error
messages or output.  Running an strace against the ifconfig doesn't even
attatch it seems.

I can't currently search the freeswan archives or subscribe to the lists
due to problems with connecting to the servers but I'm not giving up on
that route either.

Any thoughts or theories?

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bzlO8+1vMONE2jsRArRuAJ0fPs2wsddb+qNZygO6WCGA9xpWxgCg56iC
gFeGMaDuVymAIpgigzQmBow=
=Mgqb
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
