Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTFIACg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTFIACf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:02:35 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:17024 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S264085AbTFIACe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:02:34 -0400
Date: Mon, 9 Jun 2003 02:16:09 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: USB Scanner Problem
Message-Id: <20030609021609.2722ebe1.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="ZkejlJ?)_Jk/b,=."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--ZkejlJ?)_Jk/b,=.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi,

Powering up my Epson USB scanner under 2.5.70, I got the following strange
output in dmesg:

hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 4
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x0110) now attache=
d to @=E8^=CA@=E8^=CA=80

See the end of the "now attached to message". It just doesn't look right.

Device is:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  4 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.00 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D04b8 ProdID=3D0110 Rev=3D 1.10
S:  Manufacturer=3DEPSON
S:  Product=3DEPSON Scanner
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  2mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dusbscanner
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms

Regards,
-Udo.

--ZkejlJ?)_Jk/b,=.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+49HJnhRzXSM7nSkRAuxzAJ9+YR7kBKcVs/ViDshnBhQyK00IggCfTJG5
aMAha+vBywgMNsa7GEyXRyc=
=Xhk1
-----END PGP SIGNATURE-----

--ZkejlJ?)_Jk/b,=.--
