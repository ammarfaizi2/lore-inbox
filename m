Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVBDCFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVBDCFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVBDCFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:05:16 -0500
Received: from smtp09.auna.com ([62.81.186.19]:54520 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261771AbVBDCEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:04:35 -0500
Date: Fri, 04 Feb 2005 02:04:28 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Strange problem with sensors: 0 RPMs ?
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1107479698l.5691l.0l@werewolf.able.es>
In-Reply-To: <1107479698l.5691l.0l@werewolf.able.es> (from
	jamagallon@able.es on Fri Feb  4 02:14:58 2005)
X-Mailer: Balsa ..
Message-Id: <1107482668l.6500l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-cI67PFytYy7dgQuxChzi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-cI67PFytYy7dgQuxChzi
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.02.04, J.A. Magallon wrote:
> Hi all...
>=20
> I have a dual Xeon box. I got tired of the noise of the Intel boxed
> fans and bought a couple of Swiftech 'hedegehogs' and two ThemalTake
> fans.
> Board is an Asus PCDL and sensors chip is a w83627hf (heavily modified by
> Asus, I suppose, because it has 5! fan sensors). With the Intel fans,
> I got both rpm measures OK. With the new fans, the CPU0 fan insists
> it is stopped at 0 RPM. And I see it spinning. It is correctly plugged
> and the Xeon temperature stays nicely at 32=BA C.
> And the more strange thing is that the hardware monitor in the BIOS
> tells me it is spinning at about 2500 RPM !!! And the own BIOS says
> at boot that my CPU FAN IS STOPPED.
>=20

Sorry for the noise. Some google results I have not found before and
fanN_div did the trick.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam7 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #3


--=-cI67PFytYy7dgQuxChzi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAtgsRlIHNEGnKMMRAkujAKCMqHduLdogP0pARFRI1sSzCBa3MwCfXmXA
NvXnSmLunT9lKV3WVmWYKY0=
=zPkX
-----END PGP SIGNATURE-----

--=-cI67PFytYy7dgQuxChzi--

