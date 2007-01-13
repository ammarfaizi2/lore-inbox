Return-Path: <linux-kernel-owner+w=401wt.eu-S1161250AbXAMDis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbXAMDis (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbXAMDis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:38:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48360 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161250AbXAMDir (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:38:47 -0500
Message-Id: <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
In-Reply-To: Your message of "Fri, 12 Jan 2007 10:03:49 EST."
             <20070112150349.GI17269@csclub.uwaterloo.ca>
From: Valdis.Kletnieks@vt.edu
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
            <20070112150349.GI17269@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168659523_24213P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jan 2007 22:38:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168659523_24213P
Content-Type: text/plain; charset=us-ascii

On Fri, 12 Jan 2007 10:03:49 EST, Lennart Sorensen said:
>
> I would expect any distribution should work on these (as long as the
> kernel they use isn't too old.).  Of course if it is a Mac, you need a
> distribution that supports their firmware (which is of course not a PC
> bios).  As long as you can boot it, any i386 or amd64 kernel with smp
> enabled should use all the processors present (well amd64 on the
> core2duo and on the p4 if it is em64t enabled).

amd64 will only work on a core2duo if it's a T7200 or higher - the
lower numbers are 32-bit-only chipsets.  I admit not knowing what
exact variant the Mac has.

> I believe the closest optimization for a Core2 is probably the Pentium M
> (certainly not the P4/netburst).  Not entirely sure though.

CONFIG_MCORE2=y

That's probably even closer :)  At least in 2.6.20-rc4-mm1.  

--==_Exmh_1168659523_24213P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFqFRDcC3lWbTT17ARAuwtAJ90Qw6x11VNC159ImHSHetiHqONXACcDthm
hrVcKEZmOpXJwxMsuRkybLM=
=X+PR
-----END PGP SIGNATURE-----

--==_Exmh_1168659523_24213P--
