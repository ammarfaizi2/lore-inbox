Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUAJGOt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 01:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUAJGOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 01:14:49 -0500
Received: from mail.intercable.net ([207.248.32.22]:27916 "EHLO
	macross.intercable.net") by vger.kernel.org with ESMTP
	id S265053AbUAJGOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 01:14:47 -0500
Message-ID: <3FFF970D.9000200@intercable.net>
Date: Sat, 10 Jan 2004 00:09:17 -0600
From: "Pablo E. Limon Garcia Viesca" <plimon@intercable.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bootup kernel panic 2.6.x
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Good night,
yesterday I got 2.6.0, configured it and compiled it, when I restarted
my computer, I got the following error:
VFS: Cannot open root device "305" or hda5
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on hda5

Hda5 IS the root partition, and it is an ext3 fs. The ext3 is compiled
within the kernel (not as a module). The chipset is correct (PIIXn) and
at boot time I can see that the Hard Disk is correctly recogniced.

Then, today, I downladed, configured and compiled kernel 2.6.1 but I got
the same problem.

In the machine Im talking about, (a Pentium 133) I have Debian with
kernel 2.4.18, and it boots well, but I cant make 2.6.x to work, so the
partition is well configured (it is hda5).

Something I noticed, is that when I boot with 2.4, after Hard Drive
recognition, this message appears:

Partition check:
~ hda: [DM6:DD0] [remap +63] [2480/255/63] hda1 hd
a2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >

But, in 2.6.x, exactly after recognition of the ide chanels (hda and hdc
that is a cdrom) the kernel panic happens.

I entered to an irc channel about kernel discusion, and I so someone
else having a similar problem, when I got out, no one could help us.

If you need any other info. (logs, or screen messages) pleas tell me
wich archive you need and Ill send it to you.

Thanks in advance
~  Pablo E. Limon
~  plimon@intercable.net
~  al279930@mail.mty.itesm.mx
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//5cNOGkG8a1Mf+oRAjcMAKCgPkD+tfmdOm+mZvyt6bVld7gKrACeITDp
qp1qD8KQg25HvQzglywA2ec=
=o0fT
-----END PGP SIGNATURE-----

