Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCaLLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCaLLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCaLLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:11:17 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:44502 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261327AbVCaLLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:11:09 -0500
Date: Thu, 31 Mar 2005 21:10:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Kleen <ak@suse.de>
Cc: blaisorblade@yahoo.it, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 2/3] x86_64: remove duplicated sys_time64
Message-Id: <20050331211059.0ddc078c.sfr@canb.auug.org.au>
In-Reply-To: <20050331103834.GC1623@wotan.suse.de>
References: <20050330173216.426CFEFECF@zion>
	<20050331103834.GC1623@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__31_Mar_2005_21_10_59_+1000_wpXNfHsnfN7QMpsR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__31_Mar_2005_21_10_59_+1000_wpXNfHsnfN7QMpsR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Mar 2005 12:38:34 +0200 Andi Kleen <ak@suse.de> wrote:
>
> Nack. The generic sys_time still writes to int, not long.
> That is why x86-64 has a private one. Please keep that.

It writes to a time_t which is a __kernel_time_t which is a long on
x86-64, isn't it?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__31_Mar_2005_21_10_59_+1000_wpXNfHsnfN7QMpsR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCS9rI4CJfqux9a+8RAuMdAKCNXShwuUo83cma2Q6KFuo1h/kKKQCdEw8I
Ly3toM5drcwLwxJPLAT44pk=
=n49y
-----END PGP SIGNATURE-----

--Signature=_Thu__31_Mar_2005_21_10_59_+1000_wpXNfHsnfN7QMpsR--
