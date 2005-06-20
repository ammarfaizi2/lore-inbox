Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFTUg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFTUg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFTUdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:33:24 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12810 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261577AbVFTUcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:32:20 -0400
Message-Id: <200506202032.j5KKW6r7022159@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Pavel Machek <pavel@ucw.cz>
Cc: Philippe Gerum <rpm@xenomai.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] I-pipe: Core implementation 
In-Reply-To: Your message of "Sat, 18 Jun 2005 19:01:40 +0200."
             <20050618170139.GA477@openzaurus.ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <42B35B07.7080703@xenomai.org>
            <20050618170139.GA477@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119299524_19943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 16:32:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119299524_19943P
Content-Type: text/plain; charset=us-ascii

On Sat, 18 Jun 2005 19:01:40 +0200, Pavel Machek said:
> Hi!
> 
> >  linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig         |   12
> >  linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile        |    9
> >  linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c       |  265 ++++++++++++
> 
> Top-level directory for 3 files seems a bit excessive to me...

I'm thinking it might make more sense to make this 2 patches against
kernel/Kconfig and kernel/Makefile, and rename the .c to kernel/ipipe.c,
and stick the arch-dependent chunk down in arch/<whatever>/kernel/

Unless somebody has a better idea?

--==_Exmh_1119299524_19943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtyfEcC3lWbTT17ARAjHFAJ0T8UQitP66EsCZmKGV10QFm/mGFQCbB44A
TYtnDwudY1YItrTl6fQmPnI=
=EIJn
-----END PGP SIGNATURE-----

--==_Exmh_1119299524_19943P--
