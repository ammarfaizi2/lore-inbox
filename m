Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUCODkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUCODkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:40:13 -0500
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:10418 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S262221AbUCODkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:40:07 -0500
Mail-Copies-To: never
To: Valdis.Kletnieks@vt.edu
Cc: Adam Jones <adam@yggdrasl.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
Keywords: config,valdis,regparm,nvidia
References: <405082A2.5040304@blueyonder.co.uk>
	<200403111326.08055.maxvalde@fis.unam.mx>
	<405112DD.2020009@blueyonder.co.uk>
	<adam.20040312182401$5015%samael.haus@yggdrasl.demon.co.uk>
	<200403130515.i2D5F7DG009253@turing-police.cc.vt.edu>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Valdis.Kletnieks@vt.edu, Adam Jones
 <adam@yggdrasl.demon.co.uk>,  linux-kernel@vger.kernel.org
Date: Mon, 15 Mar 2004 13:36:49 +1000
In-Reply-To: <200403130515.i2D5F7DG009253@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Sat, 13 Mar 2004 00:15:07 -0500")
Message-ID: <microsoft-free.87ad2ipyr2.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

  > On Fri, 12 Mar 2004 18:24:01 GMT, Adam Jones <adam@yggdrasl.demon.co.uk>  said:
  >> A quick thought - have you got CONFIG_REGPARM enabled in the kernel
  >> config?  If so, disable it and try again.  (It's almost certain to
  >> cause crashes with binary modules.)

  $ zgrep REGPARM /proc/config.gz
CONFIG_REGPARM=y

  $ grep nvidia /proc/modules
nvidia 2066568 22 - Live 0xe0b2d000

  $ uname -r
2.6.4-sy1

No problems here. :-)

  > Also, the NVidia driver uses a bit of kernel stack, so it's
  > incompatible with the CONFIG_4KSTACKS option in recent -mm
  > kernels...

Will have to remember that for 2.6.5, I'll let you know how it goes.
Thanks, Valdis.


-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkBVJNQACgkQHSfbS6lLMAMg9gCfVES0sdwpZqmtC13K7Ncsc0Ve
FugAoM3qFVK0yK31VOCwT1kzGaaIB5Hs
=NV6s
-----END PGP SIGNATURE-----
--=-=-=--
