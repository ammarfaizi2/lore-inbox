Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUDRUEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUDRUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 16:04:16 -0400
Received: from pD9FFA1BA.dip.t-dialin.net ([217.255.161.186]:54691 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S263711AbUDRUEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 16:04:14 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: <linux-kernel@vger.kernel.org>
Subject: screen garbage with radeonfb on 2.6.5-mm6
Date: Sun, 18 Apr 2004 22:03:53 +0200
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_w8tgAS65KVMc4H4";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404182204.12037@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_w8tgAS65KVMc4H4
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm using radeonfb on an IBM Thinkpad, Ati Radeon M9
After booting it looks like the radeonfb doesn't clear or reset the screen=
=20
correctly
(see http://zodiac.dnsalias.org/images/garbage.jpg )
The area below the tux is cleared when text scrolls along.
relevant dmesg output:
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D252.00 Mhz, System=
=3D200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB

I'm using 2.6.5-mm6.

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary-03=_w8tgAS65KVMc4H4
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAgt8w/aHb+2190pERAhLzAKCZEjVXndLeMCk/qT26tki4bhG47gCgsXb3
u6uNPPIePSblxZSwQvM3FuE=
=1wQ9
-----END PGP SIGNATURE-----

--Boundary-03=_w8tgAS65KVMc4H4--
