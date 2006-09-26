Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWIZPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWIZPZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWIZPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:25:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13215 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932116AbWIZPZI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:25:08 -0400
Message-Id: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: Stupid kexec/kdump question...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159284306_3699P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 11:25:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159284306_3699P
Content-Type: text/plain; charset=us-ascii

OK, I'm running a Fedora Core 6 (rawhide actually) box with -18-mm1 kernel.
I've installed kexec-tools and similar, and am trying to get the kernels
built following the hints in Documentation/kdump/kdump.txt, but a few
questions arise:

1) Other than the fact that the Fedora userspace looks for a ${kernelvers}kdump
kernel, is there any reason the kdump kernel has to match the running one, or
can an older kernel be used?

2) I'm presuming that a massively stripped down kernel (no sound support,
no netfilter, no etc) that just has what's needed to mount the dump location
is sufficient?

3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
What will happen if I try '16M@16M' instead?  Just slower copying due to
a smaller buffer cache space, or something more evil?


--==_Exmh_1159284306_3699P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFGUZScC3lWbTT17ARAmxcAKCIn1KnHJiVcZ3jUlmpbUCMG37/2wCbBcIt
env++htSibVedprQNrG6Ayk=
=RxwW
-----END PGP SIGNATURE-----

--==_Exmh_1159284306_3699P--
