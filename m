Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271207AbTG2IYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTG2IYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:24:40 -0400
Received: from hmbg-d9ba879c.pool.mediaWays.net ([217.186.135.156]:29449 "EHLO
	streik.no-ip.org") by vger.kernel.org with ESMTP id S271207AbTG2IYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:24:39 -0400
Date: Tue, 29 Jul 2003 10:24:32 +0200
From: Groove Over <groove.over@blankenese.de>
To: linux-kernel@vger.kernel.org
Subject: Re: rivafb
Message-Id: <20030729102432.58cf7d21.groove.over@blankenese.de>
Reply-To: Groove.Over@blankenese.de
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.WJDaGh_tFlOXs("
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.WJDaGh_tFlOXs(
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi...
The rivafb and the nvidia-accelerated drivers conflict, yes, but you can own situation if you tell X to use the rivafb-framebuffer instead the nvidia-one.

Section "Device"
        Identifier      "GeForce"
        Driver          "nvidia"
        BusID           "1:0:0"
        Option          "UseFBDev"      "true"
EndSection

This should fix the problem.

And, I have my own question, too... How do I switch my resolution?

"kernel /boot/gentoo-2.4.20-r5-bo.nvidia root=/dev/hda3 video=rivafb:1280x1024-32@100" doesn't work for me.
What is wrong? 

Thanks a lot for solutions, 

kraM

--=.WJDaGh_tFlOXs(
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ji9EX39/uNMye18RAqpzAJ44Qi7ac33Ak9fvmUe7FM9rDeh+qACeKsWT
xVXmpuUk79ZonbakcsoliHI=
=vOBj
-----END PGP SIGNATURE-----

--=.WJDaGh_tFlOXs(--
