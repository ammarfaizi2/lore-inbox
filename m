Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVEJTUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVEJTUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEJTUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:20:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261752AbVEJTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:18:02 -0400
Message-Id: <200505101917.j4AJHYd2019804@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation 
In-Reply-To: Your message of "Tue, 10 May 2005 11:39:45 PDT."
             <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407> 
From: Valdis.Kletnieks@vt.edu
References: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115752651_8169P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 May 2005 15:17:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115752651_8169P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 May 2005 11:39:45 PDT, "Perez-Gonzalez, Inaky" said:
> >From: Oleg Nesterov
> >"Perez-Gonzalez, Inaky" wrote:

> Errr....shut, that was my or your email program screwing
> things up...that =20, I mean, that's MIME for line break.

Dug a bit further...

There was a trailing blank in Inaky's note as it arrived here, but it was
traveling with a Content-Type-Encoding: 8bit.  My guess is that some mail
software between vger and Oleg's inbox down-converted to 7bit.  Either that
mailer failed to insert a 'Content-Type-Encoding: quoted-printable' header when
it applied the quoted-printable )changing a trailing blank to =20) when
down-converting, or Oleg's mail reader (apparently Mozilla?) failed to heed the
C-T-E and convert the =20 back to the trailing blank it should have been.

I was there when all this MIME stuff was designed, and we covered all the
failure modes of stupid designers of mail software that we could think of.
We never considered the sorts of whitespace screw-ups we actually see today -
I think there was a "No designer could be THAT daft" blind-spot....

--==_Exmh_1115752651_8169P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCgQjLcC3lWbTT17ARAsd1AJ4oZa/eDOO6G1A0BTRS2jmt6wConwCg8XOv
PXNI2qnEOsztqpr55YjQY/o=
=yFro
-----END PGP SIGNATURE-----

--==_Exmh_1115752651_8169P--
