Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSHCLok>; Sat, 3 Aug 2002 07:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSHCLok>; Sat, 3 Aug 2002 07:44:40 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.149]:48866 "EHLO
	moutvdomng2.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317536AbSHCLoj>; Sat, 3 Aug 2002 07:44:39 -0400
Subject: Trivial Orinico_plx Patch
From: Ingo Rohlfs <irohlfs@irohlfs.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zvcRcV6q5aMhJOJOp/Fv"
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Aug 2002 15:48:29 +0200
Message-Id: <1028382510.8087.21.camel@lapkurs3.sit.fhg.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zvcRcV6q5aMhJOJOp/Fv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Heres is an trivial orinoco patch thats adding support for 3Com
AirConnect PCI

Greetings=20
Ingo Rohlfs



--- drivers/net/wireless/orinoco_plx.c	Sat Aug  3 15:15:05 2002
+++ drivers/net/wireless/orinoco_plx.c	Sat Aug  3 15:18:08 2002
@@ -103,6 +103,8 @@
 not have time for a while..
=20
 ---end of mail---
+
+08/03/2002 3COM AirConnect PCI Support added <ingo.rohlfs@sit.fraunhofer.d=
e>
 */
=20
 #include <linux/config.h>
@@ -381,6 +383,7 @@
 	{0x1638, 0x1100, PCI_ANY_ID, PCI_ANY_ID,},	/* SMC EZConnect SMC2602W,
 							   Eumitcom PCI WL11000,
 							   Addtron AWA-100*/
+	{0x10b7, 0x7770, PCI_ANY_ID, PCI_ANY_ID,},	/* 3ComAirConnect */
 	{0x16ab, 0x1100, PCI_ANY_ID, PCI_ANY_ID,},	/* Global Sun Tech GL24110P */
 	{0x16ab, 0x1101, PCI_ANY_ID, PCI_ANY_ID,},	/* Reported working, but unkno=
wn */
 	{0x16ab, 0x1102, PCI_ANY_ID, PCI_ANY_ID,},	/* Linksys WDT11 */



--=-zvcRcV6q5aMhJOJOp/Fv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9S98tG22x6f68wb8RAr6fAJ9fk3RfyWbaMgOEJ3pqyow3vsJrRQCfdvPP
ePIUDAWWDvQUmsc6mlZ0HoY=
=732l
-----END PGP SIGNATURE-----

--=-zvcRcV6q5aMhJOJOp/Fv--

