Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTJHWtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTJHWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:49:07 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:48768 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261439AbTJHWtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:49:03 -0400
Date: Wed, 8 Oct 2003 18:49:03 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test6 NFS?
Message-ID: <20031008224903.GA1464@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I've been trying to run my NFS server on 2.6 kernels for a while now.
My desktop and my Firewall are both 2.6 already and happy.  My
fileserver though is giving me an ulcer.

  I have nfs server compiled into the kernel and the client as a module.
I've tried both with and without NFSv4 (with NFSv3 definitely).  No
matter what I try though my client machines keep getting stale
filehandles.  I can cd ~ and do an "ls -la", if I get much more complex
and try something such as=20

cd ~/.spamassasin=20
ls -la
ls -la

  I get the stale handles.  Reverting back to 2.4 and all is well on the
same export and mount configs.

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

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hJRf8+1vMONE2jsRAjMtAJ9FiCbeNvWAugT9vEvlgJT41ncPpgCdFZEK
WYIvykpwRZnAvD3Ph28h2xU=
=CAwV
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
