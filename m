Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUFBSEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUFBSEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUFBSBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:01:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55005 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263795AbUFBR7D (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:59:03 -0400
Message-Id: <200406021759.i52Hx00N022255@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: FabF <fabian.frederick@skynet.be>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Wed, 02 Jun 2004 07:38:41 +0200."
             <1086154721.2275.2.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
            <1086154721.2275.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1356624104P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 13:59:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1356624104P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 07:38:41 +0200, FabF said:

> > Yes but: your wm is so  often used/activated it will not get swaped  out. 
> > But if your mouse passes over mozilla and tries to focus it, then you will
> > feel the pain of a swapped-out x program.
> > 
> Exactly !
> Does autoregulated VM swap. patch could help here ?

Con's auto-adjusting swappiness patch did in fact help that quite a bit,
especially for the case of heavy file I/O causing process images to be swapped
out.  I need to do some comparisons of that to Nick's MM work...

--==_Exmh_1356624104P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvhVkcC3lWbTT17ARAqWZAJ0Sgzjs5eI+DL2G+1ElpUDteEaSSACfdKqY
vC9QfWNp7tb0COBUva4b8E8=
=xbt4
-----END PGP SIGNATURE-----

--==_Exmh_1356624104P--
