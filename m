Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVLNNck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVLNNck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVLNNck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:32:40 -0500
Received: from mx02.qsc.de ([213.148.130.14]:22996 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S932468AbVLNNci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:32:38 -0500
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cs5536 ID for cs5535audio
Date: Wed, 14 Dec 2005 14:31:29 +0100
User-Agent: KMail/1.8.3
Cc: alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1395271.pGEIAZl7uB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512141431.32685.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi all, relative to 2.6.15-rc5-mm2 / alsa-cvs, works for
	me: Added AMD CS5536 to the cs5535audio driver. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1395271.pGEIAZl7uB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:

Added AMD CS5536 to the cs5535audio driver.

Signed-off-by: Ren=C3=A9 Rebe <rene@exactcode.de>

=2D-- sound/pci/cs5535audio/cs5535audio.c.orig	2005-12-14 14:39:11.00000000=
0 +0100
+++ sound/pci/cs5535audio/cs5535audio.c	2005-12-14 14:29:23.000000000 +0100
@@ -46,8 +46,10 @@
 static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
 static struct pci_device_id snd_cs5535audio_ids[] =3D {
=2D	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
=2D		PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{}
 };
=20


=2D-=20
Ren=C3=A9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1395271.pGEIAZl7uB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDoB60QuICExGFvYIRAnKqAJ44SL+prO5sQprQlQGo3U5dPvo5pACfYKoN
kbzHw3hcCRjARy840e/qYp4=
=EPOe
-----END PGP SIGNATURE-----

--nextPart1395271.pGEIAZl7uB--
