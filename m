Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbTIENAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIENAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:00:18 -0400
Received: from [24.241.190.29] ([24.241.190.29]:23744 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262481AbTIENAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:00:13 -0400
Date: Fri, 5 Sep 2003 09:00:07 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-bk10 and ALSA 0.9.6
Message-ID: <20030905130007.GE9634@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I've been using Alsa 0.9.6 for the last few kernels and it has been
working great.  I just tried to install it on the 2.4.22-bk10 kernel
with the same Configure command as always:

./configure --with-oss=yes --with-kernel=/usr/src/kernels/2.4.22/Desktop/linux-2.4.22/ \
--with-cards=dummy,virmidi,serial-u16550,mtpav,mpu401,als100,azt2320,cmi8330,dt019x,es18xx,opl3sa2,sgalaxy,sscape,ad1816a,ad1848,cs4231,cs4232,cs4236,es1688,gusclassic,gusmax,gusextreme,interwave,interwave-stb,opti92x-ad1848,opti92x-cs4231,opti93x,sb8,sb16,sbawe,es968,wavefront,als4000,azt3328,cmipci,cs4281,ens1370,ens1371,es1938,es1968,fm801,intel8x0,maestro3,rme32,rme96,sonicvibes,via82xx,ali5451,cs46xx,emu10k1,ice1712,ice1724,korg1212,nm256,rme9652,hdsp,trident,vx222,ymfpci,powermac,sa11xx-uda1341,usb-audio,harmony,vxpocket,vxp440,pdplus,mixart,msnd-pinnacle,pdaudiocf

(building a distribution kernel for multiple desktops)

I get this:

make[1]: Entering directory
`/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/acore'
gcc -D__KERNEL__ -DMODULE=1
-I/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include
-I/usr/src/kernels/2.4.22/Desktop/linux-2.4.22//include -O2
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c
hwdep.c
In file included from
/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include/sound/driver.h:42,
                 from hwdep.c:22:
/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/include/adriver.h:200:
redefinition of `irqreturn_t'
/usr/src/kernels/2.4.22/Desktop/linux-2.4.22/include/linux/interrupt.h:16:
`irqreturn_t' previously declared here
make[1]: *** [hwdep.o] Error 1
make[1]: Leaving directory
`/exp/src1/kernels/2.4.22/Desktop/alsa-driver-0.9.6/acore'
make: *** [compile] Error 1

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/WIjX8+1vMONE2jsRAt4fAKDAkPf3xOeMCOKHtxAg5i06JcNwuQCfTH41
Qxv4KucAohXxspubDvP888c=
=bb+b
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
