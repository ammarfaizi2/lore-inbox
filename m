Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTGBRIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTGBRH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:07:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7050 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264218AbTGBRGg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:06:36 -0400
Message-Id: <200307021719.h62HJw7i005423@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: about send task 
In-Reply-To: Your message of "Wed, 02 Jul 2003 14:03:38 -0300."
             <000701c340bb$e48b43e0$19dfa7c8@bsb.virtua.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <000701c340bb$e48b43e0$19dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_293004168P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jul 2003 13:19:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_293004168P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Jul 2003 14:03:38 -0300, Breno <brenosp@brasilsec.com.br>  sai=
d:

> if it busy , free the memory of these virtual addresses.
> - get structs mm , vma , task , zone , page
>   and copy all buffers existing in the

> Please , i=B4d like some comments/ideas about this.

1) You forgot little details like "current working directory", "open file=
s",
"file locks", "open TCP connections" and all the other process-state issu=
es.
These turn out  to be the real problems in migration.

2) http://www.mosix.org - it's not as easy as it looks.

--==_Exmh_293004168P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/AxQ9cC3lWbTT17ARAphXAJ9L+OKP4pf6etnMs07l0B/J9ZBqZwCfTlkD
DwUXl/nKyizF+eAg5Ho7dPs=
=kfYq
-----END PGP SIGNATURE-----

--==_Exmh_293004168P--
