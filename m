Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269948AbRHEMTL>; Sun, 5 Aug 2001 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHEMTA>; Sun, 5 Aug 2001 08:19:00 -0400
Received: from mgate2.uni-hannover.de ([130.75.2.5]:50840 "EHLO
	mgate2.uni-hannover.de") by vger.kernel.org with ESMTP
	id <S269948AbRHEMS6>; Sun, 5 Aug 2001 08:18:58 -0400
Date: Sun, 5 Aug 2001 14:09:42 +0200
From: Lukas Dobrek <dobrek@itp.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: HOWTO hide a process.
Message-ID: <20010805140941.A23189@spica.itp.uni-hannover.de>
User-Agent: Mutt/1.2.5i
MIME-version: 1.0
Content-type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ"; micalg="pgp-md5"; protocol="application/pgp-signature"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
I am very new in kernel stuff, so I dont know if it is a feature or
a some kind of bug, but using several line code one can somhow hide a
proces. The process is not visible for any known me ps tool.=20
If I lode the module:

struct task_struct * task;
task=3Dfind_task_by_pid(<pid>);
task->pid=3D0;

I can not see this task using ps, top, pstree but it is running.=20
I know that if one is able to load modules one can do a lot,
but I was just suprise that it is so simple.=20

Perhaps it will cause problems letter but now it works.=20

Best regards
Lukasz


--=20
=A3ukasz Dobrek
Institut f=FCr Theoretische Physik
Appelstra=DFe 2, 30167 Hannover, Germany
e-mail:dobrek@itp.uni-hannover.de

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bTeEEMOMSYY3nYoRAuYtAJwK6HQqJE3gQlKNIzh3GM7alxlUYACfQz7p
plyP2AzoGRf3bCUnJbup8dQ=
=tG7H
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
