Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTEPQp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTEPQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:45:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22916 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264494AbTEPQpz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:45:55 -0400
Message-Id: <200305161658.h4GGwicx008647@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm6 
In-Reply-To: Your message of "Fri, 16 May 2003 16:37:43 BST."
             <1053099462.5599.1.camel@dhcp22.swansea.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030516015407.2768b570.akpm@digeo.com> <20030516100432.GA21627@outpost.ds9a.nl>
            <1053099462.5599.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-739122368P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 May 2003 12:58:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-739122368P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 May 2003 16:37:43 BST, Alan Cox said:
> All of this stuff should be disablable and far more. It probably all
> wants hiding under a single "Shrink feature set" type option most people
> can skip over as they do with kernel debugging.

No, this sort of thing should be in the .config file, but NOT accessible
via the point-and-drool interface.  Make them vi it and do it the hard way...

The difference being that if you turn on kernel debugging, there's less chance
of random program XYZ you download from someplace throwing an ENOSYS because
some syscall is missing/broken, with the ensuing hilarity of debugging (since
the actual problem might be in some library rather than in the code you
downloaded).

Of course, I may just be jaded - I've gotten too many reports from bozos with
firewalls that read "ntp-1.vt.edu is portscanning from port 123, please stop it
right now or I'm calling the FBI".  But although most people that build their
own kernels can reason through "maybe my FooBar2003 would work better if I
included the driver for it",  but figuring that Frobozz isn't working because
libgronk is broken because somebody removed futexes because they thought they
sounded futile.....


--==_Exmh_-739122368P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+xRjDcC3lWbTT17ARAgBuAJ0f880Emm//ZDhJAy7PNYXc9FJknQCeP3y3
rgcA4BAy/iJh35mEe2sMI3M=
=he8o
-----END PGP SIGNATURE-----

--==_Exmh_-739122368P--
