Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUFIBeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUFIBeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUFIBeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 21:34:10 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:26873 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265361AbUFIBd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 21:33:57 -0400
Date: Wed, 9 Jun 2004 11:30:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] PPC64 iSeries virtual DVD-RAM
Message-Id: <20040609113006.398e4307.sfr@canb.auug.org.au>
In-Reply-To: <40C5E0CD.8060107@pobox.com>
References: <20040608224646.529860f4.sfr@canb.auug.org.au>
	<40C5E0CD.8060107@pobox.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__9_Jun_2004_11_30_06_+1000_AxnlQ8t4+39tD3Yr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__9_Jun_2004_11_30_06_+1000_AxnlQ8t4+39tD3Yr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 08 Jun 2004 11:52:45 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:
>
> I'm a bit curious why you handle GPCMD_READ_DISC_INFO and not let the
> underlying device handle it, for example.

Because the underlying *virtual* device doesn't handle it ... in fact
doesn't handle anything but open/close/read/write ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jun_2004_11_30_06_+1000_AxnlQ8t4+39tD3Yr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxmgqFG47PeJeR58RAhrKAKCa5wfPE4zhs8KCTCgGKvdzWHPAYACdHfts
cJaInEF21ZJTSxcDAxoJT44=
=/fcc
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jun_2004_11_30_06_+1000_AxnlQ8t4+39tD3Yr--
