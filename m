Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265039AbUELBMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbUELBMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUELBME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:12:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37315 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265016AbUELBK7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:10:59 -0400
Message-Id: <200405120110.i4C1AeLj024183@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matt Porter <mporter@kernel.crashing.org>
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support 
In-Reply-To: Your message of "Tue, 11 May 2004 18:01:44 PDT."
             <20040511180144.A4901@home.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040511170150.A4743@home.com> <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu>
            <20040511180144.A4901@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-452997504P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 21:10:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-452997504P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 18:01:44 PDT, Matt Porter said:

> Actually, OCP stands for On-Chip Peripheral and is the basic system
> we've used in ppc32 for some time now to abstract dumb peripherals
> behind a standard API.  BenH did yet another rewrite of OCP in 2.4
> sometime ago and I picked up that work to port to 2.6 and the new
> device model.  It is a software abstraction, and easily allows us to
> plug in SoC descriptors when new chips come out and use standard
> apis to modify device entries on a per-board basis during
> "setup_arch() time". It used to be PPC4xx-specific, but now is being
> used by PPC85xx, MV64xxx, and MPC52xx based PPC systems. "Now", meaning
> that the respective developers for those parts are using the OCP
> working tree to base their 2.6 ports off of.

Wrap a /* */ around that paragraph and add it to the top of ppc/syslib/ocp.c :)

--==_Exmh_-452997504P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoXmQcC3lWbTT17ARArj3AKC+ud9x2p3H3UfO0TmAlucKUcssogCcCXl/
Iu8Ezfg1j3rd15GA+U+oi7g=
=BFIL
-----END PGP SIGNATURE-----

--==_Exmh_-452997504P--
