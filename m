Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270712AbUJUOdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbUJUOdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270679AbUJUO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:29:24 -0400
Received: from ftp.nuit.ca ([66.11.160.83]:57744 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S270465AbUJUOYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:24:36 -0400
Date: Thu, 21 Oct 2004 10:24:31 -0400
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: framebuffer freeze on 2.6.9?
Message-ID: <20041021142430.GB14128@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CKdrj-0005Oy-5X 85cf98ac22aec98625e195cb47d9a901
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: multipart/mixed; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi,

i've built 2.6.9 from mainline source, and as soon as my framebuffer
comes up (according to the boot messages i see) the whole thing locks up
hard.

the framebuffers in question are controlfb and atyfb. atyfb is device 0,
and controlfb is set to 1.=20

at boot, i see atyfb messages
then i see controlfb messages.

no warnings or anything it just sits there glaring at me.

cat /proc/fb
0 ATY Mach64
1 control

cat /proc/cpuinfo                                                          =
  =20
processor       : 0
cpu             : 740/750
temperature     : 31-33 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 602.11
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
detected as     : 16 (PowerMac 8500/8600)
pmac flags      : 00000000
memory          : 496MB
pmac-generation : OldWorld

attaching config.gz

--=20
 ,''`.   http://www.debian.org/    http://www.nuit.ca/
 : :' :  Debian GNU/Linux          http://simonraven.nuit.ca/
 '
   `-
 ---------------------------------------------------------------
  GPG Print: 7C49 FD9C 1054 7300 3B7B 8BF4 6A88 7AE2 711D F097

--cvVnyQ+4j833TQvp
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--cvVnyQ+4j833TQvp--

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQXfGnWqIeuJxHfCXAQIXZwv/YXvjTNOuYXrSLlUfKsJJ44IpCZERKwyf
uZaSgAWZ/7Qq26Cb12rPq7BL3ihOSAuOy4bXY4xpu/1IJceYh2NMjTzmTIr1nqiv
kROmmiENOqRRydJKpgWAqtYOILCRHduVHolqkgWmrVlvKWpZlt3diN8J7eWUW8jL
9mdSdsSKZs3DZAAV+NqntZjRRKJDHuX6tYcTqb18QEKp0vA7CXkxRd4iKMfR06+l
f2vDa6arcaTMC06M2lR7VIWLpd5r2QmlJR3SXRMsrwxjDxKhBzSXX6fhdHX7fXFn
Rm3E8tuSlBWtOwrdZboWOfVaop2ZlOTq7W0d1LMZfJ4+99cX5dtp32m4G+G5lcXt
UHZpMA1KfpabqcgxJ3bO+reGC05kTsKVYSJzfXRviwYB0SJyWAiawvyChRDYL4Cy
1aTz7HWD7XtxgJaXQ5waA0Zvo/KTgkRYKpnSZM1db+QtXzGAraBe8mt0kH/+nLMe
ul4cJHcyHO53mFaDQi/1WGkVv3l0HCna
=maP3
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
