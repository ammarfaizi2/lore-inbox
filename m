Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUB0AqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUB0AqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:46:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:4056 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261557AbUB0Apm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:45:42 -0500
Date: Fri, 27 Feb 2004 11:45:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227114519.6c65e5cd.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.58.0402260932580.7830@ppc970.osdl.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<Pine.LNX.4.58.0402260932580.7830@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_11_45_19_+1100_6jImrdjf2EsR+cg="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_11_45_19_+1100_6jImrdjf2EsR+cg=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus,

On Thu, 26 Feb 2004 09:35:18 -0800 (PST) Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Thu, 26 Feb 2004, Stephen Rothwell wrote:
> > 
> > Unfortunately, things have moved on in the last couple of weeks and to
> > fix everyone;s abjections, I need to include in this patch a ppc64 specific
> > version of the dma_mapping routines.  They are pretty straight forward.
> 
> I'd _really_ like to see those as a separate patch and separately ack'ed 
> as having been tested on the different DMA architectures.

Fine.  I don't know what I was thinking at the time, I really didn't
need that for the viodasd patch anyway :-(

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_11_45_19_+1100_6jImrdjf2EsR+cg=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPpMfFG47PeJeR58RAlLsAJ0Q4q7XIHHlO+oNPWYgweF7PMdkIQCdEpRg
D/Yf9pOy0RxmjeRj/hxZ3yg=
=/mYK
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_11_45_19_+1100_6jImrdjf2EsR+cg=--
