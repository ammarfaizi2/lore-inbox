Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVD2X7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVD2X7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVD2X7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:59:21 -0400
Received: from main.gmane.org ([80.91.229.2]:17583 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263075AbVD2X7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:59:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Problems with Centrino frequency modulation
Date: Fri, 29 Apr 2005 16:58:30 -0700
Message-ID: <d4uhce$hme$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E94B1A14BC75C17633A0A26"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-194-180.dsl.pltn13.pacbell.net
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.91.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E94B1A14BC75C17633A0A26
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

I'm running 2.6.11.7 on an IBM Thinkpad T42. APM is working out very
nicely in everything except clock modulation, which seems to require
ACPI before speedstep-centrino will see it. p4-clockmod is able to
wrangle the CPU, but it warns that I should really be using
speedstep-centrino as p4-clockmod can't change the CPU voltage.

My CPU is family 6 / model 13 / stepping 6 (CPU_DOTHAN_B0 in
speedstep-centrino.c.) Is there a way to get speedstep-centrino working
without having to use the wretched ACPI (which, among other things,
prevents -- or at least makes it a large magnitude harder to -- sleep.
If I do echo 3 > /proc/acpi/sleep or echo mem > /sys/power/state, it
sleeps correctly, but will wake up with a blank screen or a completely
white one. [Observant readers will notice this is exactly what I
reported with my last laptop and I'm disappointed to notice that the
problem is not restricted to that POS.]) Therefore, I really, really
don't want to use ACPI.

Any suggestions?

Thanks.

--
Joshua Kwan

--------------enig8E94B1A14BC75C17633A0A26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQnLKKKOILr94RG8mAQKXYw//X2QD9Nuf4Vd2+GtXPn2yNJFL2UsK6E96
5MEt7yx0mcR3KOuvSudRzrfmJ6Sr1HZEkck2VkAxN2UScnxphevv50Le73+g7jKs
Ar1s6v1twezYJLokW0sL3rjGH4LMswiHBoPprsP4bbtsMiZJ/iVy/bsN0z7X2a3y
yqruWvnb64RKViPsHaXV8Aogx4AMa+d00k5ezrz47CClewbBEMmRSOnX3P/AehpG
JpoepfxPb2Hp5JTp54EbwCSGwe+W6V/mCou6X1EnvgLONIJSiaG5yMB0Cv8Z7PmY
bi1VY8XOPyI9Rn6KE4rtZGzFY4ATdy+6GmvaOUX5tRPMaGB7oh1/Xje2maULdC0F
fdhMbjiaYrRobWQNFn9PSgriF4FjgXKSZDBA3GuXOGEWs2JENpTn8KK9B+n4WXM7
vwi1fX1JGRq6B48jbIDz22wU1euJafZxUlRlFxa7QHC/AnM75t+a2DbddCFzbQHq
hOBtDnSkI401dl4PH8jFKmuLsvUHhJLY+HYSTahevRdGekUvfT3L4ALfHQdjq+Nk
ut+izwqxWaPoMDS9bPQOULYn6Ln9p3wxePRg9NazC58h/Il7UNKS0Zt0Zv4qwsXm
NggHmu2bxGbMB0yf+SGOz6IahttXck33sCONv6IOIOOQmqH3qwiy8/vBuO3pI27H
nlUAImjsqMM=
=nQ+4
-----END PGP SIGNATURE-----

--------------enig8E94B1A14BC75C17633A0A26--

