Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUAFNbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbUAFNbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:31:51 -0500
Received: from h80ad2652.async.vt.edu ([128.173.38.82]:7552 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262153AbUAFNbt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:31:49 -0500
Message-Id: <200401061331.i06DVQF2016758@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Dax Kelson <dax@gurulabs.com>, Andrew Morton <akpm@osdl.org>,
       "Yu, Luming" <luming.yu@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@intel.com
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch 
In-Reply-To: Your message of "Tue, 06 Jan 2004 03:23:13 EST."
             <1073377393.3910.0.camel@idefix.homelinux.org> 
From: Valdis.Kletnieks@vt.edu
References: <1073354003.4101.11.camel@idefix.homelinux.org> <20040105180859.7e20e87a.akpm@osdl.org> <200401060259.i062xrb3002240@turing-police.cc.vt.edu> <1073370806.2687.18.camel@mentor.gurulabs.com>
            <1073377393.3910.0.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1405945126P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jan 2004 08:31:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1405945126P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Jan 2004 03:23:13 EST, Jean-Marc Valin said:
> > > As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show=_bug.cgi?id=3D1766
> > > is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:
> >
> > Just confirming that the same patched fixed up the battery reporting
> > problems on my laptop as well.
> 
> Works for me too. Case closed?

I admit that although *my* configuration works now, somebody else who understands
the code better (Yu Luming and Len Brown, probably) get to decide if it's an "obvious"
fix or something that introduces other issues.  I know back around 2.5.68, there was a
2-line change to the Cardbus support that broke my Xircom card, but backing it out
was technically wrong as well - the proper fix involved a complete re-write of the Yenta
stuff.

--==_Exmh_1405945126P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+ritcC3lWbTT17ARAk2mAKCvC0o73VbDaByQ3kS5xOKNMLn7+ACg0r7+
HA2h/0c3jgfBdVLEuQYFC00=
=743F
-----END PGP SIGNATURE-----

--==_Exmh_1405945126P--
