Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVFWIIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVFWIIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVFWIFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:05:41 -0400
Received: from [213.33.64.140] ([213.33.64.140]:2345 "EHLO
	vi-edv003.villach.lkh.at") by vger.kernel.org with ESMTP
	id S262498AbVFWGaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:30:12 -0400
Date: Thu, 23 Jun 2005 08:30:10 +0200
To: linux-kernel@vger.kernel.org
Subject: Adaptec AIC7902B Dual Channel question
Message-ID: <20050623063010.GA7260@tuxx-home.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Alexander Griesser <tuxx@tuxx-home.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks!

I bought an IBM xSeries 346 server which is equipped with an onboard
Adaptec AIC7902B SCSI Raid Hostbus Controller. This controller is driven
by the aic79xx driver but a quick look over the source code showed me,
that it seems to only supports the channel 'A' (it is hardcoded on many
places).

The xSeries 346 has only one connector on the motherboard which allows
me to connect my disks to channel 'B' only. At system boot, the
controller is recognized by the driver, but no disks are available here.=20
dmesg output only states, that channel 'A' has been scanned for SCSI
devices.

So my question is: Is there a way to get my Host RAID on channel 'B'
to work?
Does it help to change all occurences of the hardcoded 'A' in the driver
with a 'B'?

As I am not subscribed to the list, please CC me in all answers.

Thanks in Advance,
--=20
|   .-.  |    Alexander Griesser -- <private@tuxx-home.at>     | .''`. |
|   /v\   \              http://www.tuxx-home.at/             / : :' : |
| /(   )\  |              GPG-KeyID: 0xA2949B5A              |  `. `'  |
|  ^^ ^^   `-------------------------------------------------'    `-   |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCulby66HVD6KUm1oRAq5uAJ9IlwTSs76Sg5eUPRaFLYo2YD/6UgCdHlmL
2CzSDpMKUzdJbgkLJfwA3ls=
=Rjn0
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
