Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVJITvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVJITvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJITvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:51:13 -0400
Received: from zoidberg.gaast.net ([64.233.13.23]:7175 "EHLO
	zoidberg.gaast.net") by vger.kernel.org with ESMTP id S932174AbVJITvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:51:11 -0400
Date: Sun, 9 Oct 2005 21:50:57 +0200
From: Wilmer van der Gaast <wilmer@gaast.net>
To: thockin@hockin.org
Cc: linux-kernel@vger.kernel.org
Subject: Problems with NS83815 on WinTerm hardware
Message-ID: <20051009195057.GE11782@gaast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
X-Operating-System: Linux 2.6.13.2-skas3-v9-pre7 on a i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This weekend I finally got Linux to boot on WYSE WinTerm hardware
(WT3320SE). However, things aren't completely smooth yet with recent
kernels. With 2.4.31 things seem to work quit well, but with 2.6 kernels
there are still some problems.

To make a long story quick, I tried 2.6.14-rc3 before writing this post
and it seems to work better. I can boot, use my NFS-root and work, but
every five seconds I get some error/warning messages from the driver:

eth0: DSPCFG mismatch after retrying for 4000 usec.
eth0: Wake-up event 0x80000a
eth0: Setting full-duplex based on negotiated link capability.

Basically that's the only problem left. I put some more info about the
problems with some kernel versions here:

http://tosca.kabel.utwente.nl/~wilmer/natsemi.txt

I might have to generate some more debugging information, I'd be happy
to do that if someone can tell me what exactly could be useful.


Greetings,

Wilmer van der Gaast.

--=20
+-------- .''`.     - -- ---+  +         - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  |         Currently playing         |
|   at   `. `~'  debian.org |  |     DreamTheater:PullMeUnder      |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -         +

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDSXSheYWXmuMwQFERAp2vAJ4zF+xk3sRffOX8g9B+WwRNS7HvoQCglIYB
HAIiJvoLTzFPD08iwoCpmy0=
=9BPr
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
