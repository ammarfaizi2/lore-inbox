Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTKAMTH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 07:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTKAMTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 07:19:06 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:2197 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S263762AbTKAMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 07:19:02 -0500
Date: Sat, 1 Nov 2003 13:18:14 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6 on my Laptop little report
Message-ID: <20031101121814.GA22742@puettmann.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1AFuhq-0005w4-00*E79a0ZVIvJ.* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



	hy,

I hope I can give with this little document a little overview about the pro=
blem
=66rom 2.6 with some of the new IBM Thinkpad laptops. My english is not the=
 best
but I hope that it will help the people to see what's going wrong.

First: cpufreqd

If I boot with AC connectet the cpu will be detected with 1499 Mhz max.
If I boot from akku only 599 Mhz max will be detected.=20

Second: ACPI

complete broken some fixes you can find in :
http://bugme.osdl.org/show_bug.cgi?id=3D1038

But It fixes not al error's and problems.

Third : APM and suspend

apm work fine but there are many problems with suspend.=20

Usb is not suspend save. You must stop hotplug, rmmod all modules for
Suspending

XFree is not suspend save. You must change to an text base console stoping X
and then suspend

If I activate the two synaptic devices the thinkpad has after resume the
synaptics is broken. I have disabled the touchpad in bios and use only the
litte red pad in teh keyboard suspend and resume works fine.

On windows I can sit in the garden from my parents surfing via wlan the akku
keeps the laptop running nearly 6 hours. On linux the max time I reached wa=
s 4
hours with the cpu @ 74 Mhz.

There are many debug messages on suspending und resume. Do we need them all?

The problems are all with 2.6.0-tes8-bk1.

Many people found the same errors on the laptop's not only on Thinkpads. Th=
e X
problem was found on ati radeon at 128 and the intel graphic boards so that=
 it
seems that it is not an bug in one driver.

Is there some work in progess? Are some patches outside I can test?

Ruben
	=09
--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/o6SGgHHssbUmOEIRAj+AAJ9baLN6O/tNhx5u1ln0gMVKItMbrgCg4H/K
tyKgZhzqfmEYYl5fw5DwtnM=
=DF25
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
