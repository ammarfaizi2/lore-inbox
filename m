Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSLXX2T>; Tue, 24 Dec 2002 18:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbSLXX2T>; Tue, 24 Dec 2002 18:28:19 -0500
Received: from dialin-145-254-148-203.arcor-ip.net ([145.254.148.203]:45952
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S265960AbSLXX2S>; Tue, 24 Dec 2002 18:28:18 -0500
Date: Mon, 23 Dec 2002 23:24:41 +0000
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUGS/Problems] 2.5.52:modules,speedstep,orinoco_cs,apm
Message-ID: <20021223232441.GA355@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear diary,

   after trying the Linux kernel 2.5.52, I recognized the following problem=
s:

      - modules are named .ko instead of .o, is there a need for new moduti=
ls ?
        Didn't find anything until now in the Changelogs.
        A `cp find /lib/modules/2.5.52/kernel -name \*.o /lib/mo*/2.5.52/`
        let's RR module-init utils load the modules again.
      - inserting of orinoco_cs freezes the system [automaticly by cardmgr]
      - speedstep.o still does not support all P3s ?
   cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
         Do you need some more informations about this chip?

      - apm doesn't recognize when I close my notebook nor does it=20
        recognize Fn+F4 [suspend button]; Calling apm -s still does work
      - inserting apm.o causes kernel to printout the following:

Unable to handle kernel paging request at virtual address d8824000
 printing eip:
d8824000
*pde =3D 17d3f067
*pte =3D 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<d8824000>]    Not tainted
EFLAGS: 00010246
eax: 00000102   ebx: d88216a0   ecx: ffffffff   edx: ffffffff
esi: d8822097   edi: d6731664   ebp: 00000000   esp: d5ebffd0
ds: 0068   es: 0068   ss: 0068
Process kapmd (pid: 152, threadinfo=3Dd5ebe000 task=3Dd6731380)
Stack: d882172a c039b754 00000000 00000000 00000068 00000068 00000000 00000=
000
       c0107299 00000000 00000000 00000000
Call Trace: [<d882172a>]  [<c0107299>]
Code:  Bad EIP value.

If there are news with those problems / I can help fix them, please tell me.

Hopefully attached all relevant files.

Nico

p.s.: again, please cc me.

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+B5s5tnlUggLJsX0RAm3vAJwOIDEN2CV8t8QDpSAHdGjWfebYfgCdEA2S
Wp1JKCB0IejSfAwURX8tFwE=
=4q70
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
