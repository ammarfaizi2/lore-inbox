Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTDYQHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTDYQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:07:18 -0400
Received: from wsip-68-96-149-130.no.no.cox.net ([68.96.149.130]:44757 "EHLO
	resonant.org") by vger.kernel.org with ESMTP id S263358AbTDYQHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:07:17 -0400
Date: Fri, 25 Apr 2003 11:19:27 -0500
From: Zed Pobre <zed@resonant.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030425161927.GA31922@singularity.resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just so people are aware, I am still seeing kswapd runaways (99% cpu
usage for a number of hours, causing other processes to go into tight
loops as well) with this kernel version (whether or not swap exists)
when updatedb runs in the mornings.  The machine exports both Samba
and NFS shares, and the kernel is configured for high memory (4GB), so
the conditions are similar to the previous examples of this behaviour.

I remember that someone at some point had an alternative VM
implementation that was supposed to correct this problem.  Does anyone
know who that was and if there are any patches that would apply
against 2.4.21-rc1?

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPqlgDx0207zoJUw5AQHObgf/Tkdt1joyNiK+4crB2VRzo/7eYMRsnRLN
dWngd68NcIAwI1eIos7MNqEhOYzcZHQS5Kt9a2pyBeyduCmEmx620YegtsdBq8yB
sA383s5/qzTKMlBzkaqe4f52j5IysmCD39dE0YErF82C9qqlnlnkLEHgXrB/dkLb
JacEQQ9vS7kY8lNHMUYQ8YiguXtvLbH0wrUdvgZGkeBFo+dFU+hcmby3bIKFw4Ua
DYwig6R0Pio6cYrhMgjUVmi+M63B1ZMbPinR/kfGPTczuRLv2Suo3/YcmBlegO81
vs4g/zI62BfLhAgU90rLcQjCIhZ/LFKTfK/tFFtcIbrIgwWNFUzWmA==
=L5ki
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
