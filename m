Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUBZHxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUBZHxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:53:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:22691 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262721AbUBZHxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:53:20 -0500
Date: Thu, 26 Feb 2004 18:52:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040226185248.5cfce622.sfr@canb.auug.org.au>
In-Reply-To: <403DA056.8030007@pobox.com>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<403DA056.8030007@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__26_Feb_2004_18_52_48_+1100_NcYlsBgZLjb=qjJ_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__26_Feb_2004_18_52_48_+1100_NcYlsBgZLjb=qjJ_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Jeff,

Thanks for your comments, sorry I missed you first time around.

Firstly, even considering your comments below, would you object to
the driver being included now and being fixed up later?

On Thu, 26 Feb 2004 02:29:26 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>
> 1) return an error instead of BUG() (and no error return) in the generic 
> DMA routines that can return a meaningful value

These routines are a work in progress and arch specific. The current
version is enough to get all the current supported drivers working.
There will be updates in due course.

I will address the rest later - I am late for dinner/LUG meeting.

> Hey, I just merged iSeries veth, so I had to give you some more work... ;-)

Thanks, its just what I needed :-(

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__26_Feb_2004_18_52_48_+1100_NcYlsBgZLjb=qjJ_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPaXQFG47PeJeR58RArVMAKCZOMbVoZB58k2iyn5o67KQfw0d0gCdGSqh
ncCdV1aqGpyyh8PSD4jDtHk=
=Fnmi
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Feb_2004_18_52_48_+1100_NcYlsBgZLjb=qjJ_--
