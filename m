Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265803AbUFIR3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUFIR3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUFIR3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:29:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28288 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265798AbUFIR3i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:29:38 -0400
Message-Id: <200406091729.i59HTgHT021011@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Your message of "Wed, 09 Jun 2004 19:12:09 +0200."
             <xb7smd4u046.fsf@savona.informatik.uni-freiburg.de> 
From: Valdis.Kletnieks@vt.edu
References: <xb7oenxyqly.fsf@savona.informatik.uni-freiburg.de> <200406071551.i57Fpl89023562@turing-police.cc.vt.edu> <xb7zn7fwdia.fsf@savona.informatik.uni-freiburg.de> <200406071636.i57Gafh7024942@turing-police.cc.vt.edu> <xb7r7sqwncc.fsf@savona.informatik.uni-freiburg.de> <200406081502.i58F2gF3013622@turing-police.cc.vt.edu> <xb765a1uovz.fsf@savona.informatik.uni-freiburg.de> <200406091656.i59GuDeH019833@turing-police.cc.vt.edu>
            <xb7smd4u046.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_730698817P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Jun 2004 13:29:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_730698817P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jun 2004 19:12:09 +0200, Sau Dan Lee said:

> A person trying to upgrade from 2.4 would suppose that the 2.4 .config
> won't work and  would likely start with "make  allmodconfig", and then
> "make {menu/x}config".   With 100s (or 1000s)  of configuration items,
> it is not easy for a 2.4-er to discover that one now has to explicitly
> enable i8042 and atkbd.  So, it is likely for him to have:
> =

>         CONFIG_SERIO=3Dm
>         CONFIG_KEYBOARD_ATKBD=3Dm

*plonk* <add to killfile>

OK. You proved that it's possible to create a kernel configuration that w=
on't
boot on your hardware (hey, people who boot off IDE or SCSI and build tho=
se
drivers as modules have to play initrd games too).

Let me know when you actually answer the question - which was "Why does t=
hat
mean it's OK to break users who *do* answer with 'y' for those options?" =
(An
alternate way of looking at it is that you will mandate a situation where=
 the
only *useful* values are equivalent to 'm' and 'n' - either you don't hav=
e it
at all (n) or you need userspace assistance before you have it (m).


--==_Exmh_730698817P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAx0kFcC3lWbTT17ARAp20AKCc/vBtgF2/0qCeNvDS+7TV28QCVQCfcTqK
BRcow1Ffq7BsM25Kk3Ih08E=
=flPU
-----END PGP SIGNATURE-----

--==_Exmh_730698817P--
