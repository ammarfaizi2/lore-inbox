Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRDIQKK>; Mon, 9 Apr 2001 12:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132790AbRDIQJM>; Mon, 9 Apr 2001 12:09:12 -0400
Received: from air.lug-owl.de ([62.52.24.190]:36370 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S132786AbRDIQHT>;
	Mon, 9 Apr 2001 12:07:19 -0400
Date: Mon, 9 Apr 2001 18:07:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.2] ne.c: Add to bad_clone_list
Message-ID: <20010409180716.B4188@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux air 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: multipart/mixed; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This allows me to use some (old and broken) AT/LANTIC boards.

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-172-7608481 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ne2k-diff

--- drivers/net/ne.c.orig	Mon Apr  9 18:01:01 2001
+++ drivers/net/ne.c	Mon Apr  9 18:03:37 2001
@@ -101,6 +101,7 @@
     {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
     {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
     {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
+    {"AT/Lan.", "AT/Lantic", {0x08, 0x00, 0x06}}, /* Broken DP83905 clone */
     {0,}
 };
 #endif

--98e8jtXdkpgskNou--

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrR3jQACgkQHb1edYOZ4bvzbwCfdq8zdr3DR+mDxSIrjN3xf6EJ
3TQAnjxiUcLoMzwBXGreU4n5+DW6kMWW
=kNuF
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
