Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTKHTNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKHTNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:13:09 -0500
Received: from adsl-67-124-156-138.dsl.pltn13.pacbell.net ([67.124.156.138]:1760
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262055AbTKHTNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:13:05 -0500
Date: Sat, 8 Nov 2003 11:13:04 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: pavel@suse.cz, jsimmons@infradead.org
Subject: 2.6.0-test9 status report
Message-ID: <20031108191304.GB956@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	pavel@suse.cz, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.6 is getting better! I only have two outstanding issues on my setup.
I've CC:d the appropriate maintainers:

1. Software suspend

This began actually working in -test9. However, if I S4 from within X,
it will never resume. In fact, it will begin resuming, but then it will
go 'Waiting for DMAs to calm down' or something, and then reboot, and
loop rebooting.

Also, my USB devices will not be re-enabled unless I unplug the hub and
replug it back in. Is there a way to kick my hotplug manager in the
shins on resume, or simulate a unplug/replug?

2. Radeon framebuffer

At boot time, since like kernel 2.5.59, there is a pile of random junk
on my framebuffer which scrolls away after a while with the boot
messages. It usually elicits weird questions from my Windows- and Red
Hat-using colleagues. "Whoa, pretty colors!" or "what the hell?" :)

Also only recently I am seeing some text clearing problems especially
when using mutt. Some characters will be stuck on the screen after
paging up and down, and sometimes when I hit the backspace i get a little
dot (like 'o') for each time i press the backspace but it seems to have
no effect on the text processed by programs.

Hoping that these two issues can be resolved.

--=20
Joshua Kwan

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP61AP6OILr94RG8mAQLcPxAApt9XB2nJmfxTgfCfaJuMKaoqIKp6VH9d
2sDeSubiTkSLKI2+FSkdkqDFh62hC9e4lkNOREP4xPhBBIN7spJRpr+SYVegtIdy
K+RSW54qx0oMcPpNVnq4i9CKraBScGCvCZGbBMeogCfgIcbEmwZ9lD/W5nWhOdvQ
lbLxf9WRZDpmzfOR7jMtztDCwz7yue8creycWx16O6AQZ868XQC1mQxvjgbXZ2K6
Sfys5gi/GEop6uEsYV0DAHt1TQt8nHjMihWoBc6i6q0VmD70s4vqxk4BaXNkFlrW
zJqJOHIc16qt8qVSUVJ9t7xYX6UQch+Rl82u4xcBZjHlq5fNwOeVQUgGs4TkcGCO
Q8971CfsmUt3LXQo+/jyT3YVqewKTdkRWxmSteQ7nYuIiKdcY9YlGl41+opreLpo
E4buq7ipoVTCGdXQbspCuOKXV7tbBXIslnIgCpMhKQz70G+YnIQUT81LalNvCN0x
t3NX/qaQczWT6GcabDJCxp8P9Fr/T/9G/edK4ULdNw2QYTsSOungEVZT6QQfunfg
fZDZ6+X6U/sQMvdpNQ5gxbYBm7DCx/Bxk9GJVbBNsxfV1/vxk/4gFJPTnFk0FI2o
/sscx7j9YujR+Is/d+kBlLNUfi3S1Vsh6+K/nPr7XBfsdNgZgBg+zL+2smu3QTy8
2DVLa1KkL+0=
=d+5A
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
