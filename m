Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWIABxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWIABxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWIABxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:53:38 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:6037 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S964899AbWIABxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:53:37 -0400
Date: Fri, 1 Sep 2006 11:53:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josef Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
 Filesystem
Message-Id: <20060901115327.80554494.sfr@canb.auug.org.au>
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Sep_2006_11_53_27_+1000_DqqyX4kmfAGTYogt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__1_Sep_2006_11_53_27_+1000_DqqyX4kmfAGTYogt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Aug 2006 21:35:13 -0400 Josef Sipek <jsipek@cs.sunysb.edu> wrote:
>
> This set of patches constitutes Unionfs version 2.0. We are presenting it=
 to
> be reviewed and considered for inclusion into the kernel.

Small nit: is it possible to order these patches so that the kernel
builds at each intermediate point (so we can use git bisect).  The
easiest way to achieve this would be to do the Kconfig and Makefile
updates last.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Sep_2006_11_53_27_+1000_DqqyX4kmfAGTYogt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE95KXFdBgD/zoJvwRAg5GAJ9lSTaWIz4ZQWumd+o+ENPx1HV5iwCfc4oL
Rxa7bLZca9/kqW8KtFfBicw=
=CMsi
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Sep_2006_11_53_27_+1000_DqqyX4kmfAGTYogt--
