Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262766AbSIUSQd>; Sat, 21 Sep 2002 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275931AbSIUSQd>; Sat, 21 Sep 2002 14:16:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:39934 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262766AbSIUSQc>; Sat, 21 Sep 2002 14:16:32 -0400
Date: Sat, 21 Sep 2002 20:21:27 +0200
From: Martin Hermanowski <martin@martin.mh57.net>
To: linux-kernel@vger.kernel.org
Subject: UML error message clone failed/new thread failed
Message-ID: <20020921182127.GK15310@martin.mh57.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I got the following log messages inside an user mode linux:
,----
| kernel: copy_thread : clone failed - errno = 1
| kernel: flush_thread : new thread failed, errno = 1
| kernel: flush_thread : new thread failed, errno = 1
| kernel: copy_thread : clone failed - errno = 1
`----

No new processes could be started in the uml, but why?

Is this a problem with the process limits of the host linux?

Regards,
Martin

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9jLimV3BRtc7IW1wRAmSGAJ0UnP3X9ivItxIvdG8gv226V7mJvwCdFeHK
WQMFKpep8sy8EPCxAryNlhA=
=t08P
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
