Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTJORc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTJORc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:32:26 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:10941 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S263747AbTJORcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:32:24 -0400
Date: Wed, 15 Oct 2003 19:32:02 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Javier Achirica <achirica@telefonica.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: airo regression with Linux 2.4.23-pre2
Message-Id: <20031015193202.54b5bb36.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__15_Oct_2003_19_32_02_+0200_hAPc+7RcK53D5/2Q"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__15_Oct_2003_19_32_02_+0200_hAPc+7RcK53D5/2Q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

My Cisco Aironet 350 Series PCMCIA network card does no longer work with the
latest 2.4 and 2.6 kernels. For 2.4.23 I have been able to identify the point
in time at which things broke. 2.4.23-pre1 still works and -pre2 does not.
The card is unable to acquire an IP address via DHCP and also doesn't seem to
receive any networking traffic at all with -pre2 and later.

Looking at the 2.4 changelog it seems that the following patch introduced
the problem.

MT> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
MT> ============================================
MT> <javier:tudela.mad.ttd.net>:
MT>   o [wireless airo] add support for MIC and latest firmwares

Do you have any idea what is going wrong here? If you need more information
to narrow down the problem, just ask.

Regards,
-Udo.

--Signature=_Wed__15_Oct_2003_19_32_02_+0200_hAPc+7RcK53D5/2Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/jYSWnhRzXSM7nSkRAlHzAJ4iRanMpdX1kqZT9PrVv/d/vIonZQCdFRe+
645TdWSbtwTob7bf40KPOPM=
=yoKC
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Oct_2003_19_32_02_+0200_hAPc+7RcK53D5/2Q--
