Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTKRQZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTKRQZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:25:33 -0500
Received: from h80ad25f9.async.vt.edu ([128.173.37.249]:25991 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263717AbTKRQZa (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:25:30 -0500
Message-Id: <200311181625.hAIGPHB8009202@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: cijoml@volny.cz
Cc: Frank =?iso-8859-1?q?B=FCttner?= <frank-buettner@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: AW: HT enable on BIOS which doesn't supports it? 
In-Reply-To: Your message of "Tue, 18 Nov 2003 17:07:29 +0100."
             <200311181707.29057.cijoml@volny.cz> 
From: Valdis.Kletnieks@vt.edu
References: <00e001c3adec$58762250$0200a8c0@netzvonfrank>
            <200311181707.29057.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2143884384P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Nov 2003 11:25:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2143884384P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2003 17:07:29 +0100, "Michal Semler (volny.cz)" said:
> Hmm..so why "ht" flag is detected?
> =

> This chip is really strange. It looks like only renamed real P4/XEON,
> coz through CPUFREQ I got it to work on lower frequencies:

Not really.  Here's mine (Dell Latitude C840):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
stepping        : 4
cpu MHz         : 1595.776
=2E...
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmo=
v pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm

Wow.. HT-enabled. However, if I build an SMP-enabled kernel, it turns out=
 that
there's only one sibling...


--==_Exmh_2143884384P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ukfscC3lWbTT17ARAtvBAKCpLW9TCFUzZ5zHEwPm8LPWoVLijgCgt/jJ
vesn6Amrr7+ZD2uEvFIbSX0=
=yu/K
-----END PGP SIGNATURE-----

--==_Exmh_2143884384P--
