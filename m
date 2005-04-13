Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVDMF3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVDMF3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 01:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVDMF3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 01:29:05 -0400
Received: from h80ad24dc.async.vt.edu ([128.173.36.220]:28679 "EHLO
	h80ad24dc.async.vt.edu") by vger.kernel.org with ESMTP
	id S262197AbVDMF26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 01:28:58 -0400
Message-Id: <200504130528.j3D5Sj2u015960@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John M Collins <jmc@xisl.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels 
In-Reply-To: Your message of "Tue, 12 Apr 2005 22:32:59 BST."
             <1113341579.3105.63.camel@caveman.xisl.com> 
From: Valdis.Kletnieks@vt.edu
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net>
            <1113341579.3105.63.camel@caveman.xisl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1113370124_3658P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Apr 2005 01:28:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1113370124_3658P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Apr 2005 22:32:59 BST, John M Collins said:

> I wish some kind soul would speak nicely to Nvidia and get them to see
> reason on the point but I suspect I'm not the first person to wish that.

NVidia is aware, and they're doing the best they can under the circumstances
(no, they can't opensource it all, there's other people's intellectual property
in there that they licensed...)

> (Or is there a sneaky way of patching the modules so they'll work in
> another kernel without tainting it?).

Patching it so it won't taint is a one-line patch.  However, it's so
morally bankrupt that I'm not giving any more hints.

Much trickier is doing it so the same module will insmod into multiple
kernels without screwing the pooch.  If you look around in nv-linux.h and
nv.c, there's a number of checks of KERNEL_VERSION, and they're all there
for a reason.

--==_Exmh_1113370124_3658P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCXK4McC3lWbTT17ARAuNlAKCdXE3WCG+rrHSjLLNjbHIJv7q6NgCgpIy5
WBaoLUuWFxQkQnTdf3eHKfE=
=imXL
-----END PGP SIGNATURE-----

--==_Exmh_1113370124_3658P--
