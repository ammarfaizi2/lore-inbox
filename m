Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUCPVTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUCPVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:19:22 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:18048 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261689AbUCPVTQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:19:16 -0500
Message-Id: <200403162119.i2GLJ9uY014711@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Steve Youngs <sryoungs@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4? 
In-Reply-To: Your message of "Tue, 16 Mar 2004 21:49:40 +0100."
             <200403162149.41018.dominik.karall@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <405082A2.5040304@blueyonder.co.uk> <200403130515.i2D5F7DG009253@turing-police.cc.vt.edu> <microsoft-free.87ad2ipyr2.fsf@eicq.dnsalias.org>
            <200403162149.41018.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_820877110P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Mar 2004 16:19:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_820877110P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Mar 2004 21:49:40 +0100, Dominik Karall <dominik.karall@gmx.net>  said:

> can you let me know how to compile the nvidia drivers for 4KSTACK? cause in 
> the 2.6.5-rc1-mm1 is no more option to deactivate 4KSTACK.

Get the 2.6.5-rc1-mm1-broken-out.tar.bz2, untar it, then

patch -p1 -R < broken-out/4k-stacks-always-on.patch

Yes, the *right* thing would be for NVidia to fix the binary.  However, this
is a lot more expedient than waiting. :)

--==_Exmh_820877110P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAV29NcC3lWbTT17ARAnZcAKCcOB/SPjJ5v/PSJetSwsIWosiuYACeKoLk
6Nz8PPi2FwQQFmse5vxBZfE=
=oEJZ
-----END PGP SIGNATURE-----

--==_Exmh_820877110P--
