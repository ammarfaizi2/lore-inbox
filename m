Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFXQcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTFXQcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:32:16 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:39100 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S262431AbTFXQcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:32:14 -0400
Date: Tue, 24 Jun 2003 11:46:23 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7[123] PS/2 issues (synaptics mouse and laptop keyboard)
Message-ID: <20030624164623.GL30282@lostlogicx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Afternoon kernel-gurus :)

Every 2.5 kernel since 2.5.70-mm9 that I have tried to use has failed to
work properly. =20
The primary issue is as mentioned elsewhere that the synaptics touchpad
simply doesn't work when psmouse is loaded.  The psmouse_noext option
results in behaviour worse than the old default where no tap-to-click
works at all. =20

However, there are other issues with the new ps/2 code, the keyboard
appears to get interrupt stormed at sometimes (or something) and I find
that letters either appear repeated (once for each keystroke after the
offending letter) or the keyboard response rate drops so low that I have
to type like a hunt-and-pecker in order to ensure that all of my
characters are captured.

I am up for any troubleshooting projects you wish to send me on, but I
don't know enough about kernel drivers to hunt down these issues in the
ps/2 code myself.

Thanks much for any help,

Brandon Low

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++IBfHCCPbR8BLcYRApvCAJ483IAOiU+Ml7GwnHfaBSHiMvKU+ACfbV2t
YUVTe3OUuBSRpZQv6KSNx64=
=cJAZ
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
