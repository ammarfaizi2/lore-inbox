Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVAGXnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVAGXnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVAGXmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:42:37 -0500
Received: from gamma.sinetgy.com ([212.85.33.222]:56285 "EHLO
	mailer.barrapunto.com") by vger.kernel.org with ESMTP
	id S261719AbVAGXl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:41:26 -0500
Subject: Re: [PATCH] USB storage: Make Pentax *ist DS works
From: Miquel Vidal <miquel@barrapunto.com>
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41D7990C.4020802@ipom.com>
References: <1104371242.4557.53.camel@kusanagi>  <41D7990C.4020802@ipom.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eOJWrtJNA1GZVLNfAfxj"
Message-Id: <1105141272.3538.141.camel@kusanagi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 08 Jan 2005 00:41:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eOJWrtJNA1GZVLNfAfxj
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El dom, 02-01-2005 a las 07:47, Phil Dibowitz escribi=F3:
> Miquel Vidal wrote:
> > Hi All,
> >=20
> > The change below in unusual_devs entries is needed to get the new Penta=
x
> > SLR *ist DS camera working.=20
>=20
> Can you please include the output of "cat /proc/bus/usb/devices" ? Thanks=
.
>=20

miquel@kusanagi:~$ cat /proc/bus/usb/devices

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.10 uhci_hcd
S:  Product=3DIntel Corp. 82801BA/BAM USB (Hub #1)
S:  SerialNumber=3D0000:00:1f.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a17 ProdID=3D0021 Rev=3D 1.00
S:  Manufacturer=3DPENTAX Corporation
S:  Product=3DPENTAX *ist DS
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  2mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50
Driver=3Dusb-storage
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms


miquel

--
Miquel Vidal          ::  Using Debian GNU/Linux
BarraPunto SysAdmin   ::  yonderboy@barrapunto.com
http://barrapunto.com ::  http://barrapunto.com/~yonderboy/bitacora
GnuPG public key available at http://sinetgy.org/~miquel


--=-eOJWrtJNA1GZVLNfAfxj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: quis custodiet ipsos custodet

iD8DBQBB3x4YjNBvGvckJE8RAnpAAKCZWqdijbqxaytRdnpQXwg/vfb+tgCfVVho
r57VXflidlc7vgKsMA2E/E8=
=2LKJ
-----END PGP SIGNATURE-----

--=-eOJWrtJNA1GZVLNfAfxj--

