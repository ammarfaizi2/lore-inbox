Return-Path: <linux-kernel-owner+w=401wt.eu-S1751917AbXAVPUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXAVPUa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbXAVPUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:20:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33306 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXAVPU3 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:20:29 -0500
Message-Id: <200701221520.l0MFKLdK032645@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
Cc: David Wagner <daw@cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Undo some of the pseudo-security madness
In-Reply-To: Your message of "Mon, 22 Jan 2007 02:23:30 +0300."
             <87r6toufpp.wl@betelheise.deep.net>
From: Valdis.Kletnieks@vt.edu
References: <87r6toufpp.wl@betelheise.deep.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1169479221_4202P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Jan 2007 10:20:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1169479221_4202P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 Jan 2007 02:23:30 +0300, Samium Gromoff said:
>
> not "core-dumps" but "core files", in the lispspeak, but anyway.
> 
> the reason is trivial -- if i can write programs enjoying setuid
> privileges in C, i want to be able to do the same in Lisp.

Go read up on how the XEmacs crew designed their "portable dumper",
specifically to get around a lot of these sorts of problems because the
old Emacs 'unexec' code was incredibly fragile.

> the only way to achieve this i see, is to directly setuid root
> the lisp system executable itself -- because the lisp code
> is read, compiled and executed in the process of the lisp
> system executable.

If that's the only way you can see to do it, maybe you should think a
bit harder before making kernel hacks to do something.





--==_Exmh_1169479221_4202P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFtNY1cC3lWbTT17ARAnZPAJ9WfSqrYVwRsGbB6H3Ata1ZH2NcvwCgnz/c
NGI9G3RajTN1ej0V9+GcBbs=
=+eMc
-----END PGP SIGNATURE-----

--==_Exmh_1169479221_4202P--
