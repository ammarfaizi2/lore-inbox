Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316943AbSE1UyB>; Tue, 28 May 2002 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316934AbSE1UwG>; Tue, 28 May 2002 16:52:06 -0400
Received: from dhcp024-210-218-255.woh.rr.com ([24.210.218.255]:38578 "HELO
	hoho.shacknet.nu") by vger.kernel.org with SMTP id <S316915AbSE1Uvo>;
	Tue, 28 May 2002 16:51:44 -0400
Subject: Sony DSC-P71 Camera
From: Colin Slater <hoho@binbash.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-cVf/4gvV2gFWz4AYypY9"
X-Mailer: Ximian Evolution 1.0.3 
Date: 28 May 2002 16:50:53 -0400
Message-Id: <1022619053.894.35.camel@neptune>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cVf/4gvV2gFWz4AYypY9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,=20
 I just got a Sony DSC-P71 digital camera (wonderful), but it doesn't
seem to be working in linux. I beleive it uses the usb mass storage
driver, it seems to use an equivilent driver in windows. I have scsi,
usb, usb mass storage modules all loaded.=20
dmesg after I load the usb-storage module, and then plug the camera in:

Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub.c: USB new device connect on bus1/1, assigned device number 3
scsi0 : SCSI emulation for USB Mass Storage devices

I am useing devfs, and /dev/scsi is empty.

cat /proc/bus/usb/devices:
<snip>
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D054c ProdID=3D0010 Rev=3D 4.10
S:  Manufacturer=3DSony
S:  Product=3DSony DSC
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  2mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3D08(stor.) Sub=3Dff Prot=3D01 Driver=
=3D(none)
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D  0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D  0ms
E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
<snip>

All this happens regardless of NVdriver being loaded or not.

If someone with one of these cameras or the nearly identical DSC-P31
could help me, it would be appreciated

Colin


--=20
-----
GPG Key 0x7E959232; wwwkeys.pgp.net
861C AE70 158F C440  EEE1 397C 7CBD 1148 7E95 9232=20
0x626FD58E Revoked, see keyserver.

--=-cVf/4gvV2gFWz4AYypY9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA88+2tfL0RSH6VkjIRAh0BAJ9GlDnmPytMJmxCY8X2bLblUJj6SwCeMc9f
MHN4uiMZHGlimNCMFkQP4vI=
=l2rX
-----END PGP SIGNATURE-----

--=-cVf/4gvV2gFWz4AYypY9--
