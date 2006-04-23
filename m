Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWDWPtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWDWPtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 11:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDWPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 11:49:49 -0400
Received: from imap1.unet.univie.ac.at ([131.130.1.182]:4606 "EHLO
	imap1u.univie.ac.at") by vger.kernel.org with ESMTP
	id S1751412AbWDWPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 11:49:49 -0400
Message-ID: <444BA1E8.5080001@xover.htu.tuwien.ac.at>
Date: Sun, 23 Apr 2006 17:48:56 +0200
From: Fabian Zeindl <fabian@xover.htu.tuwien.ac.at>
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpu frequency scaling on celeron laptop
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66BCD17C35C1EB43ACC730AE"
X-DCC-ZID-Univie-Metrics: mx8 4248; Body=0 Fuz1=0 Fuz2=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66BCD17C35C1EB43ACC730AE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

 I have cpu frequency scaling with p4-clockmod in my kernel, and until
v2.6.15 I was possible to set governors and custom frequencies at
/sys/devices/system/cpu/cpu0/cpufreq/*.
When I changed the governor or the frequency scaling_cur_freq
represented the change.

With 2.6.16 this isn't possible anymore, I didn't change anything in the
kernel .config, just did 'make oldconfig'. There is no 'cpufreq'
subdirectory in /sys/devices/system/cpu/cpu0/ anymore.

I think this user has the same problem: http://lkml.org/lkml/2006/3/21/44=


greetings
fabian zeindl

PS: Please CC me on replies, as I'm not subscribed at lkml.



--=20
What if all the world's inside of your head
Just creations of your own?
Your devils and your gods
All the living and the dead
And you're really all alone?


--------------enig66BCD17C35C1EB43ACC730AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFES6HthZkP+fFMe7kRAiHCAJ9Lv77HnP6q5Cd4l4Q5H4lRLy9wxwCeJr3N
VPqhZ93lOotnUUhdooEGuz0=
=l5tY
-----END PGP SIGNATURE-----

--------------enig66BCD17C35C1EB43ACC730AE--
