Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135516AbRDSCG1>; Wed, 18 Apr 2001 22:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135513AbRDSCGS>; Wed, 18 Apr 2001 22:06:18 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:16400 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S135516AbRDSCGG>; Wed, 18 Apr 2001 22:06:06 -0400
Date: Thu, 19 Apr 2001 04:02:15 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: APIC errors ...
Message-ID: <20010419040215.B16476@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010406005014.B9058@garloff.etpnet.phys.tue.nl> <Pine.LNX.4.33.0104181516030.16915-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104181516030.16915-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Wed, Apr 18, 2001 at 03:21:17PM -0700
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2001 at 03:21:17PM -0700, Dr. Kelsey Hudson wrote:
> Um... Looks like when you clock the BX-chipset out of spec (>100MHz FSB)
> you get the error. Since BX wasn't ever designed to be run at >100MHz
> these errors are *expected*.

No, the APIC errors also occur at exactly 100MHz.
Unfortunately, my MoBo does not offer 95MHz, so I'm running 75MHz now :-(

Reading APIC specs and errata now.=20
The funny thing is that the errors occur on the APIC bus, which runs
independently @ 33MHz, no matter if the FSB is 66 or 100 MHz, if I
understand the docs well. Maybe some timing stuff at the local APICs ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4g (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63kcmxmLh6hyYd04RAs9gAKCS5JUtxzDB2NGJefrkzemMVdxzgwCfV0oI
6QXb1nzylgwks0bA+8oAHXg=
=7zt4
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
