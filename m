Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCROp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCROp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCROp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:45:58 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:29355 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261617AbVCROpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:45:49 -0500
Date: Fri, 18 Mar 2005 15:45:46 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11: CDROM_SEND_PACKET as non-root?
Message-ID: <20050318154546.41b18776@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Fri__18_Mar_2005_15_45_46_+0100_O.Ec9sh_EGkJwP/r";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__18_Mar_2005_15_45_46_+0100_O.Ec9sh_EGkJwP/r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all!

I have a small question:
What do I have to do, to let the ioctl CDROM_SEND_PACKET work as a
non-root user under 2.6.11?

I try to burn a DVD with growisofs as a non-root user without success.

I know that there were some changes about access restriction (since
2.6.8), but I haven't found anything to get a clue about the current
status.

So is it just impossible to send a packet to the DVD burner without root
access? Do I have to use a wrapper that sets the effective user id to
root and then runs growisofs?


It's friday, so sorry for that stupid question, but a comment on that
would be fine :)

Regards,
Martin

--=20
MyExcuse:
Recursive traversal of loopback mount points

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Fri__18_Mar_2005_15_45_46_+0100_O.Ec9sh_EGkJwP/r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCOumcmjLYGS7fcG0RApuTAKCufMVhT1OzJ1yL2CqLRyLP8IPRoACgjaoI
QtISUm6olzobQ+8cOyasP+M=
=phI3
-----END PGP SIGNATURE-----

--Signature_Fri__18_Mar_2005_15_45_46_+0100_O.Ec9sh_EGkJwP/r--
