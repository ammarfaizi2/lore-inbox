Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSC1CgM>; Wed, 27 Mar 2002 21:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311530AbSC1CgD>; Wed, 27 Mar 2002 21:36:03 -0500
Received: from think.faceprint.com ([166.90.149.11]:49307 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S287817AbSC1Cfy>; Wed, 27 Mar 2002 21:35:54 -0500
Date: Wed, 27 Mar 2002 21:35:46 -0500
From: Nathan Walp <faceprint@faceprint.com>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj2
Message-ID: <20020328023543.GA28445@faceprint.com>
Reply-To: faceprint@faceprint.com
In-Reply-To: <20020328015928.A3607@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Compile error in 2.5.7-dj2, 2.5.7-dj1 compiled fine, has been running 7
days now. =20

make[4]: Entering directory `/usr/src/linux-2.5.7-dj2/drivers/scsi/aic7xxx'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.7-dj2/include -Wall -Wstrict-prototyp=
es -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common=
 -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -malign-functions=3D4  =
  -DKBUILD_BASENAME=3Daic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
aic7xxx_osm.c: In function `ahc_linux_setup_tag_info':
aic7xxx_osm.c:1036: warning: implicit declaration of function `strtok'
aic7xxx_osm.c:1036: warning: assignment makes pointer from integer without =
a cast
aic7xxx_osm.c: In function `aic7xxx_setup':
aic7xxx_osm.c:1068: warning: assignment makes pointer from integer without =
a cast
aic7xxx_osm.c:1068: warning: assignment makes pointer from integer without =
a cast
aic7xxx_osm.c: In function `ahc_platform_alloc':
aic7xxx_osm.c:1322: `AHC_LINUX_NOIRQ' undeclared (first use in this functio=
n)
aic7xxx_osm.c:1322: (Each undeclared identifier is reported only once
aic7xxx_osm.c:1322: for each function it appears in.)
aic7xxx_osm.c:1332: structure has no member named `runq_tasklet'
aic7xxx_osm.c: In function `ahc_platform_free':
aic7xxx_osm.c:1345: structure has no member named `runq_tasklet'
aic7xxx_osm.c:1349: `AHC_LINUX_NOIRQ' undeclared (first use in this functio=
n)
aic7xxx_osm.c: In function `ahc_linux_isr':
aic7xxx_osm.c:1849: structure has no member named `runq_tasklet'
aic7xxx_osm.c: In function `ahc_linux_release_sim_queue':
aic7xxx_osm.c:2460: structure has no member named `runq_tasklet'
aic7xxx_osm.c: In function `ahc_linux_queue_recovery_cmd':
aic7xxx_osm.c:2497: `io_request_lock' undeclared (first use in this functio=
n)
aic7xxx_osm.c: In function `ahc_linux_bus_reset':
aic7xxx_osm.c:2794: `io_request_lock' undeclared (first use in this functio=
n)
aic7xxx_osm.c: In function `ahc_linux_biosparam':
aic7xxx_osm.c:2833: warning: passing arg 1 of `scsi_partsize' from incompat=
ible pointer type
aic7xxx_osm.c: At top level:
aic7xxx_osm.c:2924: unknown field `use_new_eh_code' specified in initializer
make[4]: *** [aic7xxx_osm.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.5.7-dj2/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.5.7-dj2/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.7-dj2/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.7-dj2/drivers'
make: *** [_dir_drivers] Error 2


--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ooF/PkYs3Ekt234RAnC+AJ9UF1ElVfi3z7u4bmm2WxMLzccVBwCeLxxw
DjsmkANFoel8GYa6FykZS+k=
=5uMF
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
