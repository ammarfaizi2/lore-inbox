Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275418AbTHNT5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275459AbTHNT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:57:47 -0400
Received: from adsl-67-121-155-84.dsl.pltn13.pacbell.net ([67.121.155.84]:24233
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S275418AbTHNT5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:57:44 -0400
Date: Thu, 14 Aug 2003 12:57:42 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: Weird behavior of usblp
Message-ID: <20030814195742.GA30804@firesong>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Everytime I send a page to my printer connected to my USB hub for the=20
FIRST time on kernel 2.6.0-test3-mm1, this happens:

drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status received:=
 -104
drivers/usb/class/usblp.c: usblp0: error -84 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status

Turn it off, turn it on, try again, and it works. This used to not=20
break, and it still works in 2.4. Any ideas?

-Josh

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iQIVAwUBPzvptqOILr94RG8mAQIxoxAAxpynvFzmnOYd5R9SF+09JCO9vQdglOK4
csZphUo25ep9MWJ6GVS+/ShvsRZ4vr76fSIhVSxtzp9jno6T1qmVaHb3VHRG4d12
NuXeklw4OTl6iMTqQVmprNPW0tk/ZsLeX2raAtuq1zh5sBrYBydsrtNIiEloomgW
L0OUfSGMtgwbGWKGWHhifdrtJZNGdCz5oxZVGxYStFHqNrcmrRqAadwXUgajXmlI
CAd5X3MW5cCxab2403/CGNLLKVSX3BFToWST2q34dTYC+T7r2PJboV3g/Gbn12yH
/t2ywoNVNFL55sJTEc50Zm9mhJtIBChGp/qEjO4hxpiN1mOI9tlPswPVCJqKLRt6
XYH89agoP1bbewr/s6DtothbU0NaAwvMtiLnyHlKxAdLc8BJNp87K5oPT2fJ9U+d
obhQEco3BbRKT4zJfhUaatzPCIVNdd10rvDGWmWaGw6JM4Q+iJA6YrJA66nYwMAD
TJ6LYhoRjUvZVjNu5gEfGHQH0Gz9Hzt/6D8OSXZF1sjLR/IgmAIl0S77kiOaIdf9
pYzHapDWFW++nchs2H9GemNmDUHup7UKGIR716oa5kzXLSfxvU/YkvSyDFuQpUHI
+WHm+Pi2kdVczH6JHUE6eR3aT/jNUW/MjQEAmURhPg0DFECD0cX3/YARRHJH+8o/
wi8Ht1CUNaY=
=z3DA
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
