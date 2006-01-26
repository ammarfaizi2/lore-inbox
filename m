Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWAZLwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWAZLwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWAZLwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:52:07 -0500
Received: from sipsolutions.net ([66.160.135.76]:65285 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750817AbWAZLwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:52:06 -0500
Subject: [PATCH] ieee1394: allow building with absolute SUBDIRS path
From: Johannes Berg <johannes@sipsolutions.net>
To: linux1394-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YljqWR3vK9mafHtCUYRr"
Date: Thu, 26 Jan 2006 01:19:03 +0100
Message-Id: <1138234743.10202.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YljqWR3vK9mafHtCUYRr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch allows building the modules with an absolute SUBDIRS path,
especially for building them out of tree.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- a/drivers/ieee1394/Makefile
+++ b/drivers/ieee1394/Makefile
@@ -18,7 +19,7 @@ obj-$(CONFIG_IEEE1394_AMDTP) +=3D amdtp.o
 obj-$(CONFIG_IEEE1394_CMP) +=3D cmp.o
=20
 quiet_cmd_oui2c =3D OUI2C   $@
-      cmd_oui2c =3D $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
+      cmd_oui2c =3D $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
=20
 targets :=3D oui.c
 $(obj)/oui.o: $(obj)/oui.c


--=-YljqWR3vK9mafHtCUYRr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ9gVdaVg1VMiehFYAQIVFQ//Y8B+Y+VILsD4bz9HxfUZ4EcaZ0LLxMFW
FFUGmhd+/PduJdk04Zxou9cTMqydAesyJxBdcuapgrr6BhMUJ+VhMg9kyr56PW68
/LZmZnl5b1vnbSNOS39xbUKMZv1t1/n+8QIqPD3XT/mRPnuWYolJL4XTKrpSiKvl
n+PSo7iorGHeJSo05VM+/woKucElK0kEm6alYRvgd8r8O4uD3+bxJWyrROsd2jXH
hRXm7o38OlwL6alNh9dzPzmjCwfCczEQyC4zcMGisqPOqfB0kp9xwQiwIIWPFiIQ
kCsbCRavlVa2xecaSjn2C0/z6fNyOMY/TzxtdH7n2ks2eB0nzyIvDPKoWEWsAKTk
9LBKEFbO0anjszG7Z6jERRlZ9NHDlTltnhHoceySDkIvnyTrfIl6dAbybANeaqB0
V/Kr2E7THEzA2qJ8hHTjIV2jtJ9XieXh+UkVmb7QuQbdSHcDmjX/tOxTFDG3bFZp
eGwNlGokoKEtcjOhnKdenisdQeGv+ixXRSoxGS6xambwVbYUZzch/ejnqEeJae26
8NySv/6jrQvev9vDl18E93+OfEHYbvhRhjsR5M1qFJqJuQ1qeROQxagBftz87Wqr
2M8kGhCEEmVgAPy1ABaYxcwcFrj4LHE2bj24ijZy8QtWwAm4le7Na4k3y+JdLTKE
MzcKLT7z9bg=
=k5ng
-----END PGP SIGNATURE-----

--=-YljqWR3vK9mafHtCUYRr--

