Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbUAUTfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbUAUTfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:35:25 -0500
Received: from [128.173.54.129] ([128.173.54.129]:15232 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266101AbUAUTfN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:35:13 -0500
Message-Id: <200401211935.i0LJZ7Qd003905@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization 
In-Reply-To: Your message of "Wed, 21 Jan 2004 10:58:36 PST."
             <20040121105836.526c943b.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040120000535.7fb8e683.akpm@osdl.org> <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro> <20040121154627.GB10508@lsc.hu> <200401211659.i0LGxqHX002960@turing-police.cc.vt.edu>
            <20040121105836.526c943b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_673513238P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 14:35:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_673513238P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Jan 2004 10:58:36 PST, you said:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > On Wed, 21 Jan 2004 16:46:27 +0100, GCS said:
> > 
> > > > > CONFIG_IPV6_PRIVACY=y
> > >  Can you both try it without the above? At least it's solved my problem, 
and
> > > I can have 'CONFIG_IPV6=y' and ipv6 netfilter options as modules.
> > 
> > Confirm on that.  Same config, turn off CONFIG_IPV6_PRIVACY, and the
> > kernel boots just fine.  I'm willing to test patches if needed....
> > 
> 
> Which kernel fails to boot?  There were ipv6 fixes applied to 2.6.2-rc1.

2.6.1-mm4 worked, 2.6.1-mm5 failed, haven't tried 2.6.2-rc1 (will do so this evening).


--==_Exmh_673513238P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADtRrcC3lWbTT17ARAjSBAKDJjTS2IN2+lOw6Q7iScxf2JcHBfwCgsdJc
TkD1tYkRR4A6x/NEKdURg4g=
=JLTu
-----END PGP SIGNATURE-----

--==_Exmh_673513238P--
