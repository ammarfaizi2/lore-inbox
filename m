Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUH0USz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUH0USz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUH0USW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:18:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267527AbUH0UIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:08:23 -0400
Date: Fri, 27 Aug 2004 22:08:15 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: drm fixup 2/2 - optimise i8x0 accesses..
Message-ID: <20040827200815.GE23505@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0408271512330.32411@skynet> <20040827130415.754d4451.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20040827130415.754d4451.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 27, 2004 at 01:04:15PM -0700, David S. Miller wrote:
> On Fri, 27 Aug 2004 15:13:54 +0100 (IST)
> Dave Airlie <airlied@linux.ie> wrote:
> 
> >    the patch below optimises the drm code to not do put_user() on memory the
> >    kernel allocated and then mmap-installed to userspace, but instead makes it
> >    use the kernel virtual address directly instead.
> 
> This might cause major problems on systems with virtually indexed
> caches if precautions are not made at buffer allocation time such
> that the virtual cache color of the kernel mapping is the same
> as the user mapping.

actually it's uncachable memory ;)

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBL5SvxULwo51rQBIRAv/fAJ912vHNc1nPrHHj4Pgp1u2XZevrrACghEwb
AnKUo5gU9ByzRV47ghETPSc=
=5r5C
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
