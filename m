Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUAURAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUAURAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:00:10 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5760 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265972AbUAURAE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:00:04 -0500
Message-Id: <200401211659.i0LGxqHX002960@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: GCS <gcs@lsc.hu>
Cc: Catalin BOIE <util@deuroconsult.ro>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization 
In-Reply-To: Your message of "Wed, 21 Jan 2004 16:46:27 +0100."
             <20040121154627.GB10508@lsc.hu> 
From: Valdis.Kletnieks@vt.edu
References: <20040120000535.7fb8e683.akpm@osdl.org> <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro>
            <20040121154627.GB10508@lsc.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1558582688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 11:59:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1558582688P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Jan 2004 16:46:27 +0100, GCS said:

> > > CONFIG_IPV6_PRIVACY=y
>  Can you both try it without the above? At least it's solved my problem, and
> I can have 'CONFIG_IPV6=y' and ipv6 netfilter options as modules.

Confirm on that.  Same config, turn off CONFIG_IPV6_PRIVACY, and the
kernel boots just fine.  I'm willing to test patches if needed....

--==_Exmh_1558582688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADrAIcC3lWbTT17ARAqmlAJ9uTg8ICJfN/OrhCyVDFhLdVEE1+ACgpY7k
u5KOhT+V0KWSWUJ7vr1Lxlc=
=OcW5
-----END PGP SIGNATURE-----

--==_Exmh_1558582688P--
