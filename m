Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263316AbVBDBdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbVBDBdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBDB2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:28:38 -0500
Received: from smtp08.auna.com ([62.81.186.18]:41891 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261194AbVBDBO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:14:59 -0500
Date: Fri, 04 Feb 2005 01:14:58 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Strange problem with sensors: 0 RPMs ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa ..
Message-Id: <1107479698l.5691l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-WiqthHzfRmWqapQm3IRv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-WiqthHzfRmWqapQm3IRv
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all...

I have a dual Xeon box. I got tired of the noise of the Intel boxed
fans and bought a couple of Swiftech 'hedegehogs' and two ThemalTake
fans.
Board is an Asus PCDL and sensors chip is a w83627hf (heavily modified by
Asus, I suppose, because it has 5! fan sensors). With the Intel fans,
I got both rpm measures OK. With the new fans, the CPU0 fan insists
it is stopped at 0 RPM. And I see it spinning. It is correctly plugged
and the Xeon temperature stays nicely at 32=BA C.
And the more strange thing is that the hardware monitor in the BIOS
tells me it is spinning at about 2500 RPM !!! And the own BIOS says
at boot that my CPU FAN IS STOPPED.

Any idea ? Apart from the BIOS POST message, the problem related to kernel
is: why bios monitor gives 2500 and sensors 0 ?

TIA

Ah, as a collateral damage, I also have one other fan connected to
SYS_FAN1, for which lm_sensors never gave me an speed, always 0. :(
What a mess...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam7 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #3


--=-WiqthHzfRmWqapQm3IRv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAsySRlIHNEGnKMMRAlp0AJsH6eMxfd3FcLz/YbPUw8leIBThmACggcFK
/kkglJGiVMF0c4YMtRUxyI8=
=SGY0
-----END PGP SIGNATURE-----

--=-WiqthHzfRmWqapQm3IRv--

