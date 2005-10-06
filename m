Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVJFTZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVJFTZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVJFTZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:25:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53707 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751328AbVJFTZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:25:33 -0400
Message-Id: <200510061925.j96JPWdA027095@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: umesh chandak <chandak_pict@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about FC3 2.6.10 .......... 
In-Reply-To: Your message of "Thu, 06 Oct 2005 11:59:22 PDT."
             <20051006185922.81946.qmail@web35912.mail.mud.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20051006185922.81946.qmail@web35912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128626732_4764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Oct 2005 15:25:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128626732_4764P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Oct 2005 11:59:22 PDT, umesh chandak said:
> Hi,
>              I have compiled a 2.6.10 on FC3.It
> compiled successfully .But When i boot to this option
> ,it gives me warning 
>         Warning: unable to open an initial console
> I know this is due to something genromfs . I also read
> about romfs in documentation .

(Not a kernel question - next time, ask on one of the Fedora lists at redhat.com)

Getting FC3 to run on on a romfs based system will be a challenge.  In any
case, romfs has approximately zero to do with your problem.

What you've almost certainly done is forgotten to do a proper 'mkinitrd' -
FC3 and later need an initrd to get going in most cases.  (Specifically,
your initrd image needs to have a /dev/console entry in the /dev on the
initrd filesystem, and you don't have one).

--==_Exmh_1128626732_4764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDRXoscC3lWbTT17ARAgxIAJ9sHgXyG7WDHvLpTb1iAHEFRoJ6WwCeIiLX
8qE19mBCCaZym4262cIZ4l4=
=Akyl
-----END PGP SIGNATURE-----

--==_Exmh_1128626732_4764P--
