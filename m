Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUE0L5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUE0L5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUE0L5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:57:16 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:8779 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261984AbUE0L5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:57:13 -0400
Message-ID: <40B5D79C.6000600@reolight.net>
Date: Thu, 27 May 2004 13:57:16 +0200
From: Auzanneau Gregory <mls@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040526 Debian/1.6-6
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: idebus setup problem (2.6.7-rc1)
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig844CD5F8475FA571B6BE3ADC"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig844CD5F8475FA571B6BE3ADC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit


Hello,

It seems there is a problem with idebus parameter with 2.6.7-rc1.
Indeed, it doesn't take into account lilo append.

With 2.6.7-rc1-mm1, i've got:
Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

With 2.6.6-mm3, i've got:
May 24 11:37:43 greg-port kernel: Kernel command line:
BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
May 24 11:37:43 greg-port kernel: ide_setup: idebus=66
May 24 11:37:43 greg-port kernel: ide: Assuming 66MHz system bus speed
for PIO modes

I tried to seek in the code, but my level is not as good as I would like
it. :)


Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE

--------------enig844CD5F8475FA571B6BE3ADC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAtdef3H6YHZkTe+4RApAHAJ9Qg94iQ5w9Qd+vEsF5uvLrLAIP9ACgvSCF
3Pt9kcOHIOygoqN/v83ngyY=
=xkxS
-----END PGP SIGNATURE-----

--------------enig844CD5F8475FA571B6BE3ADC--
