Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264188AbUEXIzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUEXIzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUEXIxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:53:55 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:13776 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264138AbUEXIl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:41:58 -0400
Date: Mon, 24 May 2004 18:41:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524184126.11aeffd3.sfr@canb.auug.org.au>
In-Reply-To: <20040523232920.2fb0640a.akpm@osdl.org>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_18_41_26_+1000_z_qu.9PFKAzRKivw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_18_41_26_+1000_z_qu.9PFKAzRKivw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 23 May 2004 23:29:20 -0700 Andrew Morton <akpm@osdl.org> wrote:
>
> Or to generate a hotplug event when a disk is added?  Even if there's no
> notification to the kernel, it should be possible to generate the hotplug
> events in response to a /proc-based trigger.

Of course, it occurs to me that hotplug events must be happening (I guess
add_disk does it) as udev was quite happily creating hte device nodes for
me ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_May_2004_18_41_26_+1000_z_qu.9PFKAzRKivw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbU7FG47PeJeR58RArDMAKC3a2wWjixdcnKDvVI0CEtH/jgUqACdEDz6
mD4E3ht4y3iXLjfZxKfbZ+A=
=71c/
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_18_41_26_+1000_z_qu.9PFKAzRKivw--
