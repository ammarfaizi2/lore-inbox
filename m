Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVBPRgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVBPRgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVBPRgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:36:38 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54020 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262026AbVBPRgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:36:31 -0500
Message-Id: <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device 
In-Reply-To: Your message of "Wed, 16 Feb 2005 10:42:21 +0100."
             <20050216094221.GA29408@wszip-kinigka.euro.med.ge.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com> <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
            <20050216094221.GA29408@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108575364_12340P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Feb 2005 12:36:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108575364_12340P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Feb 2005 10:42:21 +0100, "Kiniger, Karl (GE Healthcare)" said:

> >    Have you tested the ISO on some *OTHER* hardware?  The impression I got
> >    was that the cd was *burned* right by ide-cd, but when *read back*, it
> >    bollixed things up at the end of the CD.....
> 
> Using ide-scsi is enough to get all the data till the real end of the CD.

OK, so the problem is that ide-cd is able to *burn* the CD just fine, but it
suffers lossage when ide-cd tries to read it back...

Alan - are the sense-byte patches for ide-cd in a shape to push either upstream
or to -mm?

--==_Exmh_1108575364_12340P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCE4SDcC3lWbTT17ARAvaYAJ9/w/Vnw8wHc+SsxSJ0cxlL1f/NkACg9hx3
Smz/3lB3J/uUQBRJT9nfSPs=
=ogKn
-----END PGP SIGNATURE-----

--==_Exmh_1108575364_12340P--
